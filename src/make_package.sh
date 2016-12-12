#!/bin/sh

IMPALA_HOME=incubator-impala
BUILD_DIR=impala
#tar zcvf impala.tar.gz ${IMPALA_HOME} \
#	--exclude="${IMPALA_HOME}/be/build/release/benchmarks" \
#	--exclude="*.class" --exclude="*.o" --exclude="*.o" --exclude="${IMPALA_HOME}/thirdparty" --#exclude="${IMPALA_HOME}/.git" --exclude="${IMPALA_HOME}/tests" --exclude="${IMPALA_HOME}/Testing" --#exclude="${IMPALA_HOME}/testdata" --exclude="*.java" --exclude="*.cpp" --exclude="*.cc" --exclude="*.h" -#-exclude="expr-test"
	
mkdrir -p $BUILD_DIR
cd $BUILD_DIR

## Get /bin
cp -r $IMPALA_HOME/bin .

## Get /be
mkdir -p be/build/latest
cp -r $IMPALA_HOME/be/build/latest/* be/build/latest
rm -rf be/build/latest/benchmarks

## Get /fe
mkdir -p fe/target
cp -r $IMPALA_HOME/fe/target/classes fe/target
cp -r $IMPALA_HOME/fe/target/dependency fe/target
cp -r $IMPALA_HOME/fe/target/test-classes fe/target
#cp $IMPALA_HOME/fe/target/*.jar fe/target
#rm fe/target/*-tests.jar
cp $IMPALA_HOME/fe/target/impala-frontend-*-SNAPSHOT.jar fe/target

## Get /shell
cp -r $IMPALA_HOME/shell .

## Get /toolchain

tar zcvf impala.tar.gz ${IMPALA_HOME} \
	--exclude="*-test"
