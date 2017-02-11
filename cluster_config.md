# 配置Impala

## 更改配置文件

1. 删除fe/src/test/resources目录下的文件，并将集群的配置文件到此目录，至少包括hdfs-site.xml、core-site.xml和hive-site.xml等文件。（这是impala-config.sh文件中设置的Hadoop配置文件目录，可以修改指向其他位置）

2. 检查core-site.xml中检查需要声明_fs.defaultFS_属性，并指向正确地址，一般为HDFS文件系统URL：

```xml
<property>
  <name>fs.defaultFS</name>
  <value>hdfs://ip-172-31-20-161.ap-northeast-2.compute.internal:8020</value>
</property>
```

3. 检查在hdfs-site.xml中_dfs.client.read.shortcircuite_属性被启用。

```xml
<property>
  <name>dfs.client.read.shortcircuit</name>
  <value>true</value>
</property>
```
注：其他属性需要和集群的设置相符，如_dfs.client.read.shortcircuit.skip.checksum_等。

4. 在hive-site.xml中，至少需要Hive Metadata Server的Thrift接口地址，样例文件如下：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
  <property>
    <name>hive.metastore.uris</name>
    <value>thrift://ip-172-31-20-161.ap-northeast-2.compute.internal:9083</value>
  </property>
</configuration>
```


## 启动测试集群

使用_bin/_目录下的_start-impala-cluster.sh_脚本可以在本机启动一个小型的Impala集群，包括一个Catalog服务，一个StateStore服务和三个Impala服务进程（数目可配置，见下）。

```bash
bin/start-impala-cluster.sh
```

如需停止集群，运行

```bash
bin/start-impala-cluster.sh --kill
```

如需强制停止所有服务，运行

```bash
bin/start-impala-cluster.sh --force_kill
```

_start-impala-cluster.sh_还支持其他的命令行配置：
