# 代码

| 项目 | 地址 | Branch | Branch URL |
| :--- | :--- | :--- |:--- |
| SPARK | https://github.com/cjjnjust/spark | parquet_bf | https://github.com/cjjnjust/spark/tree/parquet_bf |
| IMPALA | https://github.com/cjjnjust/incubator-impala | parquet_bf | https://github.com/cjjnjust/incubator-impala/tree/parquet_bf |
| PARQUET_FORMAT | https://github.com/cjjnjust/parquet-format | parquet-41 | https://github.com/cjjnjust/parquet-format/tree/parquet-41 |
| PARQUET-MR | https://github.com/cjjnjust/parquet-mr | parquet-41 | https://github.com/cjjnjust/parquet-mr/tree/parquet-41 |

# 步骤

## 环境设置

```
export BRANCH_BF_ROOT_DIR=`pwd` 
export M2_REPO_HOME=$HOME/.m2/repository
```

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

### 验证Parquet文件

```
ls -l $BRANCH_BF_ROOT_DIR/parquet-format/target/parquet-format-2.3.1-SNAPSHOT.jar
ls -l $M2_REPO_HOME/org/apache/parquet/parquet-format/2.3.1-SNAPSHOT/parquet-format-2.3.1-SNAPSHOT.jar

ls -l $BRANCH_BF_ROOT_DIR/parquet-mr/parquet-tools/target/parquet-tools-1.8.2-SNAPSHOT.jar
ls -l $M2_REPO_HOME/org/apache/parquet/parquet-tools/1.8.2-SNAPSHOT/parquet-tools-1.8.2-SNAPSHOT.jar

ls -l $BRANCH_BF_ROOT_DIR//parquet-mr/parquet-tools/dependency-reduced-pom.xml
ls -l $M2_REPO_HOME/org/apache/parquet/parquet-tools/1.8.2-SNAPSHOT/parquet-tools-1.8.2-SNAPSHOT.pom

ls -l $BRANCH_BF_ROOT_DIR//parquet-mr/parquet-tools/target/parquet-tools-1.8.2-SNAPSHOT-tests.jar
ls -l $M2_REPO_HOME/org/apache/parquet/parquet-tools/1.8.2-SNAPSHOT/parquet-tools-1.8.2-SNAPSHOT-tests.jar
```

### 测试写入

```
import org.apache.spark.sql.SparkSession

val spark: SparkSession = SparkSession.builder.master("local").config("spark.sql.parquet.enable.bloom.filter","true").config("spark.sql.parquet.bloom.filter.expected.entries","3100").config("spark.sql.parquet.bloom.filter.col.name","record_id").appName("2.1 rebase: Load parquet with bf").getOrCreate

val sqlDF = spark.sql("SELECT record_id, cdr_id FROM parquet.`/home/ec2-user/data/b24d14ade0a4e0e9-d5c3b5e96e9bcb95_2035586954_data.9.parq`")

sqlDF.createOrReplaceTempView("tsample")

sql("SELECT record_id, cdr_id FROM tsample").write.parquet("/tmp/test.parq")

val bsqlDF = spark.sql("SELECT * FROM parquet.`/tmp/test.parq/part-r-00007-25e25fb1-1eea-46cb-b937-fc032ef471ef.snappy.parquet`")

bsqlDF.createOrReplaceTempView("tbf")

sql("select * from tbf where record_id = '1233024271'").show

sql("explain select * from tbf where record_id = '1233024271'").show
```

### 声明表

1. 将文件拷贝到HDFS
1. 声明外表（Impala外表必须在HDFS上）

```
CREATE EXTERNAL TABLE bf_real_data LIKE PARQUET '/data/bf_parq/part-r-00007-d98eb7a0-b566-467a-83fc-a7119b756178.snappy.parquet'
  STORED AS PARQUET
  LOCATION '/data/bf_parq';
```

## 部署