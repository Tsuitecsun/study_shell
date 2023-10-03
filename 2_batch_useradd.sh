#!/bin/bash


user_add(){
user_info_dir=/var/log/

[ -f ${user_info_dir}userinfo.txt ] && rm -rf ${user_info_dir}userinfo.txt

for i in {00..09}
do
    username="user_"${i}
    pwd=`openssl rand -base64 20|tr -dc "a-zA-Z0-9"|fold -w 15|head -n 1`
    useradd ${username} -s /bin/bash && echo "${username}:${pwd}"|chpasswd
    if [ $? -eq 0 ]
    then
    echo "${username}创建成功"
    echo "用户：${username}   密码：${pwd}">>${user_info_dir}userinfo.txt
    else
    echo "${username}创建失败"
    fi  
done

}

main(){
user_add
}

main