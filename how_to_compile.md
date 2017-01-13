
# 编译Impala

source ${IMPALA_HOME}/bin/impala-config.sh # You must source this in your shell before most of the below commands will work.


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
