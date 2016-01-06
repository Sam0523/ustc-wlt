#!/bin/sh
#
#    Copyright (C) 2016 Sam Yu <ytz1995@gmail.com>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# vim: shiftwidth=2

# check requirement
if ! command -v w3m > /dev/null; then
  echo -e >&2 "w3m is required but not installed.\nPlease install w3m."
  if command -v command-not-found > /dev/null; then
    command-not-found w3m
  fi
  exit 1
fi

WLT_ISP_DEFAULT="1"
WLT_TIME_DEFAULT="0"

# read and check configuration file
if [ -r $HOME/.wlt.conf ]; then
  . $HOME/.wlt.conf
else
  echo 1>&2 "\
Configuration file not found or unreadable.
Please set WLT_USERNAME and WLT_PASSWORD to your username and password in ~/.wlt.conf."
  exit 1
fi

if [ -z "$WLT_USERNAME" -o -z "$WLT_PASSWORD" ]; then
  echo 1>&2 "\
Configuration file is incorrect.
Please set WLT_USERNAME and WLT_PASSWORD to your username and password in ~/.wlt.conf."
  exit 1
fi

# Main
case "$1" in
  info)
    # show profile infomation
    w3m -dump "http://wlt.ustc.edu.cn/cgi-bin/ip?name=$WLT_USERNAME&password=$WLT_PASSWORD&cmd=login" |
    grep -m1 -A5 "用户"
    ;;
  status)
    # show current ISP status
    w3m -no-graph -dump "http://wlt.ustc.edu.cn/cgi-bin/ip?name=$WLT_USERNAME&password=$WLT_PASSWORD&cmd=login" |
    grep -m1 -A2 "IP地址" | sed 's/| *//g; /^$/d'
    ;;
  list)
    # show the list of available ISPs
    echo "可选出口列表："
    w3m -no-graph -dump "http://wlt.ustc.edu.cn/cgi-bin/ip?name=$WLT_USERNAME&password=$WLT_PASSWORD&cmd=login" |
    sed -n '/^|(/{s/|(.) //g; s/ *|.*|$//g; s/^[0-9]*/  & /g; p}; /建议/{s/[| ]*//g; p}'
    ;;
  set)
    # set ISP

    WLT_ISP="$WLT_ISP_DEFAULT"
    WLT_TIME="$WLT_TIME_DEFAULT"
    test -n "$2" && WLT_ISP="$2"
    test -n "$3" && WLT_TIME="$3"
    WLT_ISP=$(($WLT_ISP - 1))

    w3m -no-graph -dump "http://wlt.ustc.edu.cn/cgi-bin/ip?name=$WLT_USERNAME&password=$WLT_PASSWORD&cmd=set&type=$WLT_ISP&exp=$WLT_TIME" |
    grep -m1 -A2 "信息" | sed 's/^ *//g; /^$/d; /+-*/,$d;'
    ;;
  log)
    # show recent log
    w3m -dump "http://wlt.ustc.edu.cn/cgi-bin/ip?name=$WLT_USERNAME&password=$WLT_PASSWORD&cmd=login" |
    sed -n '/最近日志/,/^$/{s/最近日志.*$/最近日志：/; /^$/,$d; p}'
    ;;
  dump)
    # dump the whole page (hidden feature for debug)
    w3m -$* "http://wlt.ustc.edu.cn/cgi-bin/ip?name=$WLT_USERNAME&password=$WLT_PASSWORD&cmd=login"
    ;;
  *)
    # show usage
    programname=$(basename "$0")
    echo "\
Usage:
    $programname info
	Show profile infomation
    $programname status
	Show current ISP status
    $programname list
	Show the list of available ISPs
    $programname set [ISP [expire time]]
	Set ISP
    $programname log
	Show recent log"
    ;;
esac
