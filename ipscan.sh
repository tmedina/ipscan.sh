#!/bin/bash
trap "exit 1" SIGHUP SIGINT SIGTERM

if [ "$1" = "do_scan" ]; then
				if ( ping -qc 1 -t1 $2 2>/dev/null 1>/dev/null );then
								MAC=`arp $2 | awk '{print $4}' | sed 's/^\(.\):/0\1:/' | sed 's/:\(.\):/:0\1:/g' | sed 's/:\(.\)$/:0\1/'`
								if [ "$MAC" = "no" ];then
												MAC="local"
								fi
								echo "$2	$MAC"
				fi
elif [ "$1" = "" ]; then
				echo "Usage: ipscan <first.three.octets>"
				exit 1
else

	for  i in {1..254}
	do
					ipscan do_scan $1.$i &
	done

fi

sleep 1
