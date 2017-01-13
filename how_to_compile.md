
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

### 下载native-toolchain项目

```
git clone https://git-wip-us.apache.org/repos/asf/incubator-impala.git
cd incubator-impala
```

### 导入环境变量

```
export IMPALA_HOME=`pwd`
source ${IMPALA_HOME}/bin/impala-config.sh
```

注意：通常在运行任何Impala命令，都需要先运行impala-config.sh。

## 1.1安装组件

以root用户登录hadoop001节点，安装组件



`yum install libevent-devel automake libtool flex bison gcc-c++ openssl-devel  make cmake doxygen.x86_64 glib-devel python-devel bzip2-devel svn libevent-devel cyrus-sasl-devel wget git unzip openldap-devel db4-devel`





## 1.2安装maven

1.下载maven包



以hadoop用户登录hadoop001节点，在家目录下下载maven包



cd ~

wget[**http://www.interior-dsgn.com/apache/maven/maven-3/3.0.5/binaries/apache-maven-3.0.5-bin.tar.gz**](http://www.interior-dsgn.com/apache/maven/maven-3/3.0.5/binaries/apache-maven-3.0.5-bin.tar.gz)





2.移动软件包至安装目录下

mvapache-maven-3.0.5-bin.tar.gz /opt/beh/core/

3.解压软件包

cd /opt/beh/core/

tar -zxvf apache-maven-3.0.5-bin.tar.gz

4.删除软件包

rm apache-maven-3.0.5-bin.tar.gz

5.重命名目录

mv apache-maven-3.0.5 maven



6.配置环境变量

vi /etc/beh/conf/beh\_env

添加以下内容：

export M2\_HOME=/opt/beh/core/maven

export M2=$M2\_HOME/bin

export PATH=$M2:$PATH

7.source文件

source /etc/beh/conf/beh\_env

8.在当前目录下验证是否成功安装

mvn -version



## 1.3编译boost

1.删除旧版本boost

切换到root用户，用yum删除

su root

yum remove boost\*

su hadoop



2.将软件包从本地上传到家目录下之后转移到安装目录

mvboost\_1\_46\_0.tar.gz /opt/beh/core/

3.解压软件包

cd /opt/beh/core

tar -xvzf boost\_1\_46\_0.tar.gz

4.更改目录名称

mv boost\_1\_46\_0.tar.gz boost

5.删除软件包

rm boost\_1\_46\_0.tar.gz

6.编译安装

切换到root用户

su root

cd boost

./bootstrap.sh

./bjam --build-[**type**](http://cpro.baidu.com/cpro/ui/uijs.php?adclass=0&app_id=0&c=news&cf=1001&ch=0&di=128&fv=20&is_app=0&jk=d69315dc18698732&k=type&k0=type&kdi0=0&luki=5&mcpm=0&n=10&p=baidu&q=65035100_cpr&rb=0&rs=1&seller_id=1&sid=32876918dc1593d6&ssp2=1&stid=9&t=tpclicked3_hc&td=1836545&tu=u1836545&u=http://www.bubuko.com/infodetail-252619.html&urlid=0)=complete --[**layout**](http://cpro.baidu.com/cpro/ui/uijs.php?adclass=0&app_id=0&c=news&cf=1001&ch=0&di=128&fv=20&is_app=0&jk=d69315dc18698732&k=layout&k0=layout&kdi0=0&luki=7&mcpm=0&n=10&p=baidu&q=65035100_cpr&rb=0&rs=1&seller_id=1&sid=32876918dc1593d6&ssp2=1&stid=9&t=tpclicked3_hc&td=1836545&tu=u1836545&u=http://www.bubuko.com/infodetail-252619.html&urlid=0)=tagged --mt install



## 1.4编译llvm

1.下载源码

在hadoop家目录下下载安装包

wget[http://llvm.org/releases/3.3/llvm-3.3.src.tar.gz](http://llvm.org/releases/3.3/llvm-3.3.src.tar.gz)

2.将软件包移动到安装目录下并解压

mv llvm-3.3.src.tar.gz /opt/beh/core/

cd /opt/beh/core/

tar -xvzf llvm-3.3.src.tar.gz

3.更改路径名称

mv llvm-3.3.src.tar.gz llvm

4.删除压缩包

rm llvm-3.3.src.tar.gz

5.用svn来checkout



cd llvm-3.3.src/tools

svn co http://llvm.org/svn/llvm-project/cfe/tags/RELEASE\_33/final/ clang

cd ../projects

svn co http://llvm.org/svn/llvm-project/compiler-rt/tags/RELEASE\_33/final/ compiler-rt

6.编译

cd ..

./configure --with-pic

make -j4 REQUIRES\_RTTI=1

7.使用root用户安装

su root

make install

8.安装完成后切换回hadoop用户

su hadoop

## 1.5编译impala

1.下载源码

在家目录下用hadoop用户下载源码包

wget[http://archive.cloudera.com/cdh5/cdh/5/](http://archive.cloudera.com/cdh5/cdh/5/)



2.将源码包移动到安装目录

mvimpala-2.1.4-cdh5.3.5-src.tar.gz /opt/beh/core/

3.解压源码包

cd /opt/beh/core/

tar -zxvf impala-2.1.4-cdh5.3.5-src.tar.gz

4.更改目录名

mv impala-2.1.4-cdh5.3.5 impala

5.删除压缩包

rm impala-2.1.4-cdh5.3.5-src.tar.gz

6.更改编译版本

impala的编译脚本buildall.sh默认编译类型是debug版，我们选择编译release版

cd impala

vi buildall.sh

找到TARGET\_BUILD\_TYPE这行

将Debug改成Release

保存退出



cd impala

./buildall.sh -noclean -skiptests -so



注：如果有maven下包出现错误，应该是网络问题，重新更换网络，执行编译命令

## 参考资源

https://cwiki.apache.org/confluence/display/IMPALA/Building+Impala
