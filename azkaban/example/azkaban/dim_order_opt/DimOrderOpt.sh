#!/bin/sh
#报表
function Application(){
#报表程序
spark-submit --master yarn --deploy-mode cluster --driver-memory ${driverMemory} --executor-memory ${executorMemory} --num-executors ${numberExecutors} --executor-cores ${executorCores} --class com.jianbing.controller.${mainClass} hdfs://jianbing/jars/${jar}-jar-with-dependencies.jar ${path}

#数据合并
hadoop fs -test -e ${path}/part*
if [ $? -eq 0 ]; then
hadoop fs -cat ${path}/part* | hadoop fs -appendToFile - ${path}.txt
fi

#删除目录
hadoop fs -test -e ${path}/part*
if [ $? -eq 0 ]; then
hdfs dfs -rm -r ${path}
fi
}
#--num-executors:6~8 --executor-cores:2~3 --driver-memory:4~6g--executor-memory：2~4g
driverMemory=4g
executorMemory=3g
numberExecutors=5
executorCores=2
mainClass=DimOrderOptController
jar=DimOrderOpt
#path=webhdfs://jianbing/tao/dim/zfgjj/dim_user_app_opt
path=webhdfs://jianbing/tmp/liuhao/dim_user_app_opt
Application