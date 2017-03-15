# 代码

| 项目 | 地址 | Branch | Branch URL |
| :--- | :--- | :--- |:--- |
| SPARK | https://github.com/cjjnjust/spark | parquet_bf | https://github.com/cjjnjust/spark/tree/parquet_bf |
| IMPALA | https://github.com/cjjnjust/incubator-impala | parquet_bf | https://github.com/cjjnjust/incubator-impala/tree/parquet_bf |
| PARQUET_FORMAT | https://github.com/cjjnjust/parquet-format | parquet-41 | https://github.com/cjjnjust/parquet-format/tree/parquet-41 |
| PARQUET-MR | https://github.com/cjjnjust/parquet-mr | parquet-41 | https://github.com/cjjnjust/parquet-mr/tree/parquet-41 |

# 步骤
## 下载代码

```
git clone https://github.com/cjjnjust/spark.git
cd spark
git checkout parquet_bf
## git log

cd ..
git clone https://github.com/cjjnjust/incubator-impala
cd incubator-impala
git checkout parquet_bf
## git log

cd ..
git clone https://github.com/cjjnjust/parquet-format
cd parquet-format
git checkout parquet-41
## git log

cd ..
git clone https://github.com/cjjnjust/parquet-mr
cd parquet-mr
git checkout parquet-41
## git log
```

## 编译

```
BRANCH_BF_ROOT_DIR=`pwd` 
cd $BRANCH_BF_ROOT_DIR/parquet-format
mvn clean install -DskipTests

cd $BRANCH_BF_ROOT_DIR/parquet-mr
mvn clean install -DskipTests

cd $BRANCH_BF_ROOT_DIR/spark
rm spark-2.1.0-SNAPSHOT-bin-custom-spark.tgz
./build/mvn -Pyarn -Phadoop-2.6 -Dhadoop.version=2.6.0 -DskipTests clean package

./dev/make-distribution.sh --name custom-spark --tgz -Phadoop-2.6 -Pyarn

cd $BRANCH_BF_ROOT_DIR/impala
export IMPALA_HOME=`pwd`
source $IMPALA_HOME/bin/impala-config.sh
./buildall.sh -notests -build_shared_libs
```
注意验证编译正确性

## 打包

## 测试

## 部署