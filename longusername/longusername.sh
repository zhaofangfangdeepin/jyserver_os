#!/bin/bash
#  upport for user names not less than 31 bytes long
#  created by zhaofangfang@deepin.com
#  For Server OS test
#  https://deepin.com

username1="deepin-test-31-bytes-user-name"

printf "Create a 31-byte-long username\n"

if id -u $username1 &> /dev/null
then
	userdel -r $username1
fi

useradd -m -s /bin/bash $username1

if [ $? -eq 0 ];then
	printf "User name %s was created successfully\n" $username1
else
	printf "User name %s was created failed\n" $username1
	exit 1
fi
userdel -r $username1 &> /dev/null

if [ $? -eq 0 ];then
	printf "Create a 31-byte test of username length test PASS!\n"
fi
