#!/bin/bash
# 写一个检测脚本，用来检测本机所有磁盘分区读写是否都正常。

disk_part_check(){
    local bs=$1
    local count=$2

    # 获取所有挂载点
    local mount_points=$(df -h | sed '1d' |grep '^\/dev'|awk '{print $NF}')

    # 遍历所有挂载点
    for mount_point in $mount_points
    do
        # 在每个挂载点上新建一个测试文件
        local test_file="${mount_point}/test_file"
        if dd if=/dev/zero of=${test_file} bs=${bs} count=${count} >/dev/null 2>&1
        then
            echo "在${mount_point}上成功新建了测试文件。"
            # 读取新文件
            if dd if=${test_file} of=/dev/null bs=${bs} count=${count} >/dev/null 2>&1
            then
                echo "在${mount_point}上成功读取了测试文件。"
            else
                echo "警告：无法在${mount_point}上读取文件。可能存在读取问题。"
                rm -rf ${test_file}
                exit 1
            fi
        else
            echo "警告：无法在${mount_point}上新建测试文件。可能存在写入问题。"
            exit 1
        fi
        rm -rf ${test_file}
    done
    echo "检查完成。"
}

main(){
    disk_part_check 100M 1
}

main
