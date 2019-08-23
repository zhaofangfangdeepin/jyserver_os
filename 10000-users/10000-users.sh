#!/bin/bash
######################################
#  script for Test creating multiple users 
#  created by zhaofangfang@deepin.com
#  For Server OS test
#  Support for no less than 10,000 users
#  https://deepin.com
#####################################

del_all_testusers(){
	for i in $(seq 1 $1)
	do
		userdel -r user$i >& /dev/null
	done
}

create_all_testusers(){
	for i in $(seq 1 $1)
	do
		egrep "^user$i" /etc/passwd >& /dev/null
		
		if [ $? -eq 0  ];then
			userdel -r user$i >& /dev/null
		fi
		
		useradd -m -s /bin/bash user$i >& /dev/null
		
		if [ $? -eq 0 ] ;then
			printf "user%d create success!\n" $i
		else
			printf "user%d create failed!\n" $i
			exit 1
		fi
	done
}

show_usage() {
	echo "Usage :`basename $0` usernumbers"
}

if [ $# != 1 ];then
	show_usage
	exit 1
fi

if [ `whoami` != "root" ];then
    printf "请使用root用户.\n"
    exit 1
fi
printf "Create $1 users test started. please wait...\n"
create_all_testusers $1
printf "All $1 users create success!\n"
printf "Now del all $1 users.please wait...\n"
del_all_testusers $1
printf "Create $1 users test PASS!\n"
exit 0 
