# 总结思路
1、使用for循环查找该目录下面的所有文件和目录。
2、使用stat命令获取权限、属主、属组的相关信息。
3、对权限、属主、属组的相关信息进行相应的判断，最后使用chmod，chown更改信息。
