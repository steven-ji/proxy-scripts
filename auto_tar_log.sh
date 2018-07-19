#!/bin/bash
#将三天前的日志压缩处理
for i in `find /store/logs/ -type d -ctime +3 -name "20*"`
do
    dir=`dirname $i`
    basename=`basename $i`
    if [ ! -d $dir  ]; then
       continue
    fi
    cd $dir
    tar -czvf $basename.tar.gz $basename
    rm -rf $basename
done

# 删除5天之前的日志文件
find /store/logs/ -type f -name "*.tar.gz" -ctime +5 | xargs -i rm -f {}
