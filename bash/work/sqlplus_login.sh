#!/bin/bash

conf_file="$HOME/services/apache-tomcat-*-CORE/conf/context.xml"

username=$(cat $conf_file | grep username | head -1 | cut -d'"' -f2)
password=$(cat $conf_file | grep password | head -1 | cut -d'"' -f2)
url=$(cat $conf_file | grep url | head -1 | cut -d'"' -f2 | sed 's/.*@//')

sqlplus $username/"$password"@$url

sleep 5
