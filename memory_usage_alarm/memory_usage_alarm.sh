#!/bin/bash
#===============================================================================
#          FILE: ~/sendmail.sh
#         USAGE: sudo sh ~/sendmail.sh 
#   DESCRIPTION: All rights reserved. https://github.com/mrivandu/ops/blob/master/sendmail.sh
#        AUTHOR: IVAN DU (mrivandu), mrivandu@hotmail.com
#       CREATED: 2019-04-30-13:53:32
#      REVISION: v1.0
#===============================================================================
receiver_list=( 'gysl@163.com' 'gysl@qq.com' 'mrivandu@hotmail.com' )
available_memory=`free -m|grep 'Mem'|awk '{print $NF}'`
text="The available memory of current host is ${available_memory}MB. "

if [ -n "`sudo rpm -qa|grep mailx`" ];then
  echo "Mailx is installed!";
  else
    yum -y install mailx;
fi

if [ -z "`grep 'gysl' /etc/mail.rc`" ];then
  echo "set from=gysl@163.com smtp=smtp.163.com smtp-auth-user=gysl smtp-auth-password=r3P3GOd9ugZi smtp-auth=login">>/etc/mail.rc;
else
  echo "The username is exist. ";
fi

if [ ${available_memory} -lt 1500 ]; then
  for receiver in ${receiver_list[@]}; do
    echo ${text}|tee /tmp/mail.text
    mail -s "`date +%F-%T`-${text}" ${receiver} </tmp/mail.text
    if [ $? -eq 0 ];then
      echo "The system has sent an email to ${receiver}, please check it carefully. ";
    else
      echo "Mail delivery to ${receiver} is failed, please check the configuration! ";
      sleep 10;
    fi
    done
fi