# 编译Impala

## 安装系统组件

以CentOS系统为例，运行以下命令：

```
yum install libevent-devel automake libtool flex bison gcc-c++ openssl-devel make cmake doxygen.x86_64 glib-devel python-devel bzip2-devel svn libevent-devel cyrus-sasl-devel wget git unzip openldap-devel db4-devel
```

Ubuntu系统：

```bash
# General build requirements
sudo apt-get install build-essential git

# Requirements for specific packages
sudo apt-get install bison # For binutils
sudo apt-get install autoconf automake libtool # For libevent
sudo apt-get install libz-dev # For OpenSSL
sudo apt-get install libssl-dev # For Thrift
sudo apt-get install libncurses-dev # For GDB
sudo apt-get install libsasl2-dev # For Kudu
```

## 安装maven

【步骤1】下载maven包，并解压。例如：

```
wget http://www.interior-dsgn.com/apache/maven/maven-3/3.0.5/binaries/apache-maven-3.0.5-bin.tar.gz
tar -zxvf apache-maven-3.0.5-bin.tar.gz
```

此处以3.0.5版本为例，其他版本请替换版本号。

【步骤2】移动软件包至安装目录下

```
sudo mv apache-maven-3.0.5 /opt
sudo ln -s /opt/apache-maven-3.0.5 /opt/maven
```

【步骤3】添加环境变量，修改.shrc或.bashrc如下：

```
export M2_HOME=/opt/maven
export M2=${M2_HOME}/bin
export PATH=${M2}:$PATH
```

【步骤4】更新环境变量：

```
source $HOME/.bashrc
```

【步骤5】验证是否成功安装，使用命令：

```
mvn -version
```

## 安装依赖项目

### 下载native-toolchain项目

```
# Checkout the toolchain
git clone https://github.com/cloudera/native-toolchain.git
```

### 安装

```
cd native-toolchain
./buildall.sh
```

这一步将下载、编译和安装数十个依赖的项目，需要很长的时间，而且像Kudu等新的项目很容易编译出错。在build/目录下能看到所有的依赖项目。如果未能成功完成所有项目，在后续编译Impala时会遇到类似“_required packages were missing_”的错误，比如：

```
The following packages are not in their expected locations.
  breakpad (expected directory /home/ec2-user/git/incubator-impala/toolchain/breakpad-20150612-p1 to exist)
  kudu (expected directory /home/ec2-user/git/incubator-impala/toolchain/kudu-1.0.0-RC1 to exist)
  tpc-h (expected directory /home/ec2-user/git/incubator-impala/toolchain/tpc-h-2.17.0 to exist)
  tpc-ds (expected directory /home/ec2-user/git/incubator-impala/toolchain/tpc-ds-2.1.0 to exist)
Pre-built toolchain archives not available for your platform.
Clone and build native toolchain from source using this repository:
    https://github.com/cloudera/native-toolchain
Traceback (most recent call last):
  File "/home/ec2-user/git/incubator-impala/bin/bootstrap_toolchain.py", line 355, in <module>
    bootstrap(toolchain_root, packages)
  File "/home/ec2-user/git/incubator-impala/bin/bootstrap_toolchain.py", line 106, in bootstrap
    check_custom_toolchain(toolchain_root, packages)
  File "/home/ec2-user/git/incubator-impala/bin/bootstrap_toolchain.py", line 158, in check_custom_toolchain
    raise Exception("Toolchain bootstrap failed: required packages were missing")
Exception: Toolchain bootstrap failed: required packages were missing
```

可以到native-toolchain的check/目录下找到所有项目对应的日志，检查是否出现错误。

## 编译Impala

### 下载Impala项目

```
git clone https://git-wip-us.apache.org/repos/asf/incubator-impala.git
cd incubator-impala
```

### 添加toolchain链接

```
ln -s ${NATIVE_TOOLCHAIN}/build toolchain ##将NATIVE_TOOLCHAIN替换为上一步checkout的native_toolchain项目实际目录
```

### 导入环境变量

    export IMPALA_HOME=`pwd`
    source ${IMPALA_HOME}/bin/impala-config.sh

注意：通常在运行任何Impala命令，都需要先运行impala-config.sh。

### 修改编译版本

Impala的根目录下的buildall.sh文件是编译脚本，默认编译类型是Debug版，如需编译Release版本，可以在文件中找到找到TARGET\_BUILD\_TYPE这行，将Debug改成Release。

### 编译

```
./buildall.sh -skiptests -so
```

注：如果有maven下包出现错误，应该是网络问题，重新更换网络，执行编译命令

## 参考资源

[https://cwiki.apache.org/confluence/display/IMPALA/Building+Impala](https://cwiki.apache.org/confluence/display/IMPALA/Building+Impala)

