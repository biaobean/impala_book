#!/bin/sh

## 如果是release build，将BUILD_TYPE设置为release（小写）
## 如果是debug build，将BUILD_TYPE设置为debug（小写）
export BUILD_TYPE=debug

BUILD_DIR=`pwd`

## 函数，将原来$IMPALA_HOME制定目录下所有文件及子目录拷贝到当前目录，并保持相对路径不变
function copy_dir() {
  if [[ "$1" = "" ]]; then
    return
  fi

  mkdir -p $1
  cp -r $IMPALA_HOME/$1/* $1
}

## 函数，将$PATH中引用到的非系统目录全部拷贝，简单粗暴有效。
## 传入参数$1 $PATH
function copy_dir_in_paths() {
  if [[ "$1" = "" ]]; then
    return
  fi

  IFS=: DIRS=($1)
  declare -p DIRS
  for f in "${DIRS[@]}"; do
    if [[ "$f" = "$IMPALA_HOME" ]]; then
      continue
    fi
    REDIR=${f#${IMPALA_HOME}/}
    [[ ! -e ${REDIR} ]] || continue
    copy_dir $REDIR
  done
  IFS=
}

if [[ "$IMPALA_HOME" = "" ]]; then
  echo '$IMPALA_HOME Must be set.'
  return
fi

if [[ "$IMPALA_HOME" = "$BUILD_DIR" ]]; then
  echo 'Cannot package Impala in the same path as $IMPALA_HOME.'
  return
fi

cd $IMPALA_HOME/
source $IMPALA_HOME/bin/impala-config.sh

mkdir -p $BUILD_DIR
cd $BUILD_DIR

TIMESTAMP=`date +%Y%m%d%H%M`
########################################
# Step 1. Copy files
########################################

copy_dir bin
copy_dir www ## Web UI
copy_dir infra
copy_dir shell
copy_dir be/build
# copy_dir fe/src/test/resources
copy_dir testdata/bin
copy_dir testdata/common
copy_dir testdata/cluster ## 集群启动脚本
cp $IMPALA_HOME/testdata/__init__* $BUILD_DIR/testdata

mkdir -p tests
copy_dir tests/common
cp $IMPALA_HOME/tests/*.py* tests
cp $IMPALA_HOME/tests/*.sh tests

## Log dir for start-impala-cluster
mkdir -p logs/cluster



## 将Impala目录下所有.so结尾的文件都复制到lib/目录下
mkdir lib
find $IMPALA_HOME -name '*.so' | xargs -i cp {} ./lib

## 复制Java文件
mkdir -p fe/target
cp -r $IMPALA_HOME/fe/target/dependency fe/target
cp -r $IMPALA_HOME/fe/target/classes fe/target
cp -r $IMPALA_HOME/fe/target/test-classes fe/target
cp $IMPALA_HOME/fe/target/*.jar fe/target
#rm fe/target/*-tests.jar
cp $IMPALA_HOME/fe/target/impala-frontend-*-SNAPSHOT.jar fe/target

#IMPALA_SNAPPY_VERSION=1.1.3
#IMPALA_GCC_VERSION=4.9.2
#IMPALA_LLVM_VERSION=3.8.0-p1

## 复制依赖包
cp ${HADOOP_LIB_DIR}/native/*.so ./lib
cp ${IMPALA_SNAPPY_PATH}/*.so ./lib
cp ${IMPALA_LZO}/build/*.so ./lib

export USE_SYSTEM_GCC=${USE_SYSTEM_GCC-0}
if [ $USE_SYSTEM_GCC -eq 0 ]; then
  mkdir -p toolchain/gcc/
  cp -r ${IMPALA_TOOLCHAIN_GCC_LIB} toolchain/gcc/
fi

## 拷贝Python依赖
copy_dir_in_paths $PYTHONPATH

########################################
# Step 2. Modify Path
########################################

rm be/build/latest
ln -s $BUILD_TYPE be/build/latest
rm -rf be/build/latest/benchmarks

rm be/build/$BUILD_TYPE/catalog/catalogd
ln -s ../service/impalad be/build/$BUILD_TYPE/catalog/catalogd

rm be/build/$BUILD_TYPE/statestore/statestored
ln -s ../service/impalad be/build/$BUILD_TYPE/statestore/statestored

### Configs
mkdir conf
cp -r $IMPALA_HOME/fe/src/test/resources/* conf

mkdir -p fe/src/test/
ln -s ../../../conf fe/src/test/resources


## 添加路径
echo '
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$IMPALA_HOME/lib:$IMPALA_HOME/toolchain/gcc/lib64
echo Added lib/ dir, now LD_LIBRARY_PATH=$LD_LIBRARY_PATH
' >> bin/impala-config.sh

########################################
# Step 3. Package
########################################

## Build
cd ..

tar zcvf impala_${TIMESTAMP}.tar.gz ${BUILD_DIR} --exclude="*-test" --exclude=".gitignore"

#tar zcvf impala.tar.gz ${IMPALA_HOME} \
#	--exclude="${IMPALA_HOME}/be/build/release/benchmarks" \
#	--exclude="*.class" --exclude="*.o" --exclude="*.o" --exclude="${IMPALA_HOME}/thirdparty" --#exclude="${IMPALA_HOME}/.git" --exclude="${IMPALA_HOME}/tests" --exclude="${IMPALA_HOME}/Testing" --#exclude="${IMPALA_HOME}/testdata" --exclude="*.java" --exclude="*.cpp" --exclude="*.cc" --exclude="*.h" -#-exclude="expr-test"