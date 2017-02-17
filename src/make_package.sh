#!/bin/sh
if [[ "$IMPALA_HOME" = "" ]]; then
  echo '$IMPALA_HOME Must be set.'
  return
fi

BUILD_DIR=`pwd`

if [[ "$IMPALA_HOME" = "$BUILD_DIR" ]]; then
  echo 'Cannot package Impala in the same path as $IMPALA_HOME.'
  return
fi


## 如果是release build，将BUILD_TYPE设置为release（小写）
## 如果是debug build，将BUILD_TYPE设置为debug（小写）
export BUILD_TYPE=debug

cd $IMPALA_HOME/

rm be/build/latest
ln -s $BUILD_TYPE latest

rm be/build/$BUILD_TYPE/catalog/catalogd
ln -s ../service/impalad be/build/$BUILD_TYPE/catalog/catalogd

rm be/build/$BUILD_TYPE/statestore/statestored
ln -s ../service/impalad be/build/$BUILD_TYPE/statestore/statestored
准备Impala文件
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

source $IMPALA_HOME/bin/impala-config.sh

copy_dir bin
copy_dir www ## Web UI
copy_dir infra
copy_dir be/build
copy_dir fe/src/test/resources
copy_dir testdata/common
copy_dir testdata/cluster ## 集群启动脚本

## 将Impala目录下所有.so结尾的文件都复制到lib/目录下
mkdir lib
find $IMPALA_HOME -name '*.so' | xargs -i cp {} ./lib

## 复制Java文件
mkdir -p fe/target
cp -r $IMPALA_HOME/fe/target/dependency fe/target
cp -r $IMPALA_HOME/fe/target/classes fe/target
cp $IMPALA_HOME/fe/target/*.jar fe/target

## 复制依赖包
cp ${HADOOP_LIB_DIR}/native/*.so ./lib
cp ${IMPALA_SNAPPY_PATH}/*.so ./lib
cp ${IMPALA_LZO}/build/*.so ./lib

export USE_SYSTEM_GCC=${USE_SYSTEM_GCC-0}
if [ $USE_SYSTEM_GCC -eq 0 ]; then
  cp ${IMPALA_TOOLCHAIN_GCC_LIB}/*.so ./lib
fi

## 加入Python依赖
copy_dir_in_paths $PYTHONPATH


## 添加路径
echo '
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$IMPALA_HOME/lib
echo Added lib/ dir, now LD_LIBRARY_PATH=$LD_LIBRARY_PATH
' >> bin/impala-config.sh








IMPALA_SNAPPY_VERSION=1.1.3
IMPALA_GCC_VERSION=4.9.2
IMPALA_LLVM_VERSION=3.8.0-p1


#tar zcvf impala.tar.gz ${IMPALA_HOME} \
#	--exclude="${IMPALA_HOME}/be/build/release/benchmarks" \
#	--exclude="*.class" --exclude="*.o" --exclude="*.o" --exclude="${IMPALA_HOME}/thirdparty" --#exclude="${IMPALA_HOME}/.git" --exclude="${IMPALA_HOME}/tests" --exclude="${IMPALA_HOME}/Testing" --#exclude="${IMPALA_HOME}/testdata" --exclude="*.java" --exclude="*.cpp" --exclude="*.cc" --exclude="*.h" -#-exclude="expr-test"
mkdrir -p $BUILD_DIR
cd $BUILD_DIR

## Get /bin
cp -r $IMPALA_HOME/bin .

## Get WWW
cp -r $IMPALA_HOME/www .

## Get /be
mkdir -p be/build/latest
cp -r $IMPALA_HOME/be/build/latest/* be/build/latest
rm -rf be/build/latest/benchmarks

mkdir -p be/build/debug
cp -r $IMPALA_HOME/be/build/debug/service be/build/debug

## Get /fe
mkdir -p fe/target
cp -r $IMPALA_HOME/fe/target/classes fe/target
cp -r $IMPALA_HOME/fe/target/dependency fe/target
cp -r $IMPALA_HOME/fe/target/test-classes fe/target
#cp $IMPALA_HOME/fe/target/*.jar fe/target
#rm fe/target/*-tests.jar
cp $IMPALA_HOME/fe/target/impala-frontend-*-SNAPSHOT.jar fe/target

### Configs
mkdir conf
cp -r $IMPALA_HOME/fe/src/test/resources conf

mkdir -p fe/src/test/
ln -s ../../../conf fe/src/test/resources

## Get /shell
cp -r $IMPALA_HOME/shell .

cp -r $IMPALA_HOME/infra .

## Get /toolchain
mkdir toolchain

### cdh component
cp -r $IMPALA_HOME/toolchain/cdh_components toolchain

### Snappy
mkdir toolchain/snappy-${IMPALA_SNAPPY_VERSION}/
cp -r $IMPALA_HOME/toolchain/snappy-${IMPALA_SNAPPY_VERSION}/lib toolchain/snappy-${IMPALA_SNAPPY_VERSION}/ 

### GCC
mkdir toolchain/gcc-${IMPALA_GCC_VERSION}/
cp -r $IMPALA_HOME/toolchain/gcc-${IMPALA_GCC_VERSION}/lib64 toolchain/gcc-${IMPALA_GCC_VERSION}

### LLVM
cp -r $IMPALA_HOME/toolchain/llvm-${IMPALA_LLVM_VERSION} toolchain


rm be/build/latest/statestore/statestored
ln -s ../../latest/service/impalad be/build/latest/statestore/statestored

rm be/build/latest/catalog/catalogd
ln -s ../../latest/service/impalad be/build/latest/catalog/catalogd


mkdir so
mkdir lib
find $IMPALA_HOME/be/build -name '*.so'  | xargs -i cp {} ./lib

cp $IMPALA_HOME/toolchain/kudu-1.0.0-RC1/release/lib64/* ./lib

export IMPALA_HOME=`pwd`
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$IMPALA_HOME/lib/


## Build
cd ..
tar zcvf impala.tar.gz ${BUILD_DIR} --exclude="*-test" --exclude=".gitignore"



/usr/lib/x86_64-linux-gnu:/etc/alternatives/java_sdk_1.8.0/jre/lib/amd64:/etc/alternatives/java_sdk_1.8.0/jre/lib/amd64/server:/etc/alternatives/java_sdk_1.8.0/jre/lib/amd64/server:/home/ec2-user/git/incubator-impala/toolchain/cdh_components/hadoop-2.6.0-cdh5.10.0-SNAPSHOT//lib/native:/home/ec2-user/git/incubator-impala/be/build/debug/service:/home/ec2-user/git/incubator-impala/toolchain/snappy-1.1.3/lib:/home/ec2-user/git/incubator-impala/../Impala-lzo/build:/home/ec2-user/git/incubator-impala/toolchain/gcc-4.9.2/lib64


source bin/impala-config.sh
source bin/set-classpath.sh