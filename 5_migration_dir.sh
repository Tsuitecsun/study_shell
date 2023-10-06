#!/bin/bash
# 有一个目录/data/business/，该目录下有数百个子目录，
# 比如/data/business/nginx，/data/business/tomcat
# 然后再深入一层为以日期命名的目录，例如/data/business/nginx/20221008,
# 每天会生成一个日期新目录，由于/data所在磁盘快满了，
# 所以需要将老文件（一年以前的）迁移另外一个目录/data1/business下，
# 迁移结束之后，
# 还需要做软链接，
# 写一个脚本，要求/data/business/下所有子目录都要按此操作，
# 要求数据迁移结束后才创建软连接，并且需要记录日志需要有日志 

need_migration_path=/data/business/
migration_path=/data1/business/  
[ ! -d ${migration_path} ] && mkdir -p ${migration_path}
date_log=`date "+%c"`
migration_log_path=/var/log/migration_log/
[ ! -d ${migration_log_path} ] && mkdir ${migration_log_path}


migration_dir(){
echo "******************迁移开始*******************"
for i in `find ${need_migration_path} -maxdepth 1 -type d | sed '1d'`
do 
    mv ${i} ${migration_path}
    echo "正在迁移--------->${i}"
    base_name=`basename ${i}`
    if [ $? -eq 0 ]
    then
        migration_log ${base_name} 0
    else
        migration_log ${base_name} 0

    fi
done
echo "******************迁移结束*******************"
}

migration_log(){
date_pre=`date "+%Y%m%d"`
log_file=${migration_log_path}${date_pre}_${1}.log
soure_dir=${need_migration_path}${1}
des_dir=${migration_path}${1}

if [ ${2} -eq 0 ]
then
    ln -s ${des_dir} ${soure_dir}
    echo "${date_log}---->${soure_dir}，迁移成功至新目录---->${des_dir}" >>${log_file}
else
    echo "${date_log}---->${soure_dir}，迁移失败至新目录---->${des_dir}" >>${log_file}
fi
}

main(){
migration_dir
}

main