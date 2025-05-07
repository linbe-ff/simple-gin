#!/bin/sh
# 定义应用组名
group_name='nnzmr'
# 定义应用名称
app_name='game'
# 定义应用版本
app_version='latest'
echo '----stop and remove previous container----'
docker stop ${app_name} 2>/dev/null
docker rm ${app_name} 2>/dev/null
echo '----remove previous image----'
docker rmi ${group_name}/${app_name}:${app_version} 2>/dev/null
# 打包编译docker镜像
docker build -t ${group_name}/${app_name}:${app_version} .
echo '----build image----'
docker run -p 8080:8080 --name ${app_name} \
-e TZ="Asia/Shanghai" \
-v /etc/localtime:/etc/localtime \
-d ${group_name}/${app_name}:${app_version}
echo '----start container----'