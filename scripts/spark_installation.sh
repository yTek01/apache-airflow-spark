#!/bin/bash
# -- use 'chmod u+x scripts/spark_installation.sh' to give spark_installation.sh executable permission

sudo apt update
sudo apt install default-jdk -y
sudo apt install curl mlocate git scala -y

curl -O https://archive.apache.org/dist/spark/spark-3.2.0/spark-3.2.0-bin-hadoop3.2.tgz
wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.227/aws-java-sdk-bundle-1.12.227.jar
wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.1/hadoop-aws-3.3.1.jar

sudo tar xvf spark-3.2.0-bin-hadoop3.2.tgz
sudo mkdir /opt/spark

sudo mv spark-3.2.0-bin-hadoop3.2/* /opt/spark
sudo mv hadoop-aws-3.3.1.jar /opt/spark/jars
sudo mv aws-java-sdk-bundle-1.12.227.jar /opt/spark/jars


sudo chmod -R 777 /opt/spark
echo 'export SPARK_HOME=/opt/spark' >> ~/.bashrc 
echo 'export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin' >> ~/.bashrc

# copy the lines below into your terminal, and execute them one by one
# source ~/.bashrc
# start-master.sh
# start-slave.sh spark://XXXXXXXXXXXX:7077 {{Replace the URL with your localhost URL the one with port 7077}}