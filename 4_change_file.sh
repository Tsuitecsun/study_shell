#!/bin/bash
# 检查/data/wwwroot/app录下所有文件和目录，看是否满足下面条件：
# 1）所有文件权限为644
# 2）所有目录权限为755
# 3）文件和目录所有者为www，所属组为root
# 如果不满足，改成符合要求
# 注意，不要直接改权限，一定要有判断的过程。
change_file(){
find_dir=/data/wwwroot/app/

for i in `find ${find_dir}`
do
    file_a=`stat -c "%a" ${i}`
    file_U=`stat -c "%U" ${i}`
    file_G=`stat -c "%G" ${i}`

    if [ ! -d ${i} ]
    then
        if [ ${file_a} != '644' ]
        then
            chmod 644 ${i}
        fi
    else
     if [ ${file_a} != '755' ]
        then
            chmod 755 ${i}
        fi
    fi

    if [ ${file_U} != 'www' ]
    then
        chown www ${i}
    fi

    if [ ${file_G} != 'www' ]
    then
        chown :root ${i}
    fi
done
}

main(){
    change_file
}

main