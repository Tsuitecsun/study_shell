#!/bin/bash


backup_file(){
base_dir=/data/
file_type=txt
time_suffix=`date '+%Y%m%d'`
backup_dir=/backup/

[ -d ${backup_dir} ] && echo dir exist || mkdir ${backup_dir}

for i in `find ${base_dir} -type f -name *.${file_type}`
do
    # 版本1
    # echo ${i} | awk -F '/' '{print $NF}'
    # basename 
    # base_name=`basename ${i}`
    # cp ${i} ${backup_dir}${base_name}_${time_suffix}

    # 版本2
    # /data/2/1.txt ---> _data_2_1.txt_20230928

    backup_name=`echo ${i}|sed 's/\//_/g'`
    
    cp ${i} ${backup_dir}${backup_name}_${time_suffix}

    echo "${i} 文件已经备份成功！！"
done

}

main(){
backup_file
}

main