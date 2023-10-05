#!/bin/bash

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