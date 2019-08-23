#!/bin/bash
#  upport for user names not less than 31 bytes long
#  created by zhaofangfang@deepin.com
#  For Server OS test
#  https://deepin.com

str=`cat /dev/urandom |sed 's/[^a-zA-Z0-9]//g'|strings -n 8 |head -n 32 |xargs printf "%s"`

filename_254=${str:0:254}
filename_255=${str:0:255}
filename_256=${str:0:256}

create_file(){
	if [ -f $1 ];then
		rm -f $1
		touch $1
	else
		touch $1
	fi	
}

printf "Create a file with a file name length of 254 letters\n"
create_file $filename_254
if [ $? -eq 0 ];then
	printf "Create a file with a file name length of 254 letters success!\n"
else
	printf "Create a file with a file name length of 254 letters failed!\n"
	exit 1
fi
rm -f $filename_254

printf "Create a file with a file name length of 255 letters\n"
create_file $filename_255
if [ $? -eq 0 ];then
	printf "Create a file with a file name length of 255 letters success!\n"
else
	printf "Create a file with a file name length of 255 letters failed!\n"
	exit 1
fi
rm -f $filename_255

printf "Create a file with a file name length of 256 letters\n"
create_file $filename_256 &> /dev/null
if [ $? -eq 0 ];then
	printf "Create a file with a file name length of 256 letters success!\n"
	printf "This does not meet the standards!\n"
	rm -f $filename_256
	exit 1
else
	printf "Create a file with a file name length of 256 letters failed!\n"
fi

printf "Up to 255-character files with file names are supported!\n Test PASS!\n"
