# 总结思路
1、记录出所有磁盘分区的挂载点（使用df、grep、awk、sed）
2、遍历所有挂载点（for）
3、使用dd命令进行读写测试
4、最后把测试文件删除