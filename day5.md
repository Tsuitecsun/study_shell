# 总结思路
1、使用for循环查找该目录所有一级子目录，使用参数-maxdepth 1。
2、使用mv命令对于需要迁移的目录进行移动。
3、迁移成功后使用ln -s做软连接，把迁移好的业务做快捷方式弄回去旧路径。
4、成功与失败都记录日志。