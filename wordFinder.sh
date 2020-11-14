#!/bin/bash
length=${$#}
file1_tmp=${@: -2:1}
argv="$@"
char="${@: -2:1}"
num="${@: -1}"
err=0

if [ "$#"  -lt 3 ]; then 
	echo "Number of parameters received : $#" >&2
	echo 'Usage : wordFinder.sh <valid file name> [More Files]... <char> <length>'
	exit 1
else
if ! [[  "$char" ==  [[:upper:]] || "$char" == [[:lower:]]  ]]; then
	echo "Only one char needed : "$char""
	err=1
fi

if [[ ! "$num" =~ ^[0-9]+$ || $num -lt  0 ]] ; then
   echo "Not a positive number : $num" >&2
   err=1
fi

if [[ $err -ne 0 ]]; then
	echo 'Usage : wordFinder.sh <valid file name> [More Files]... <char> <length>'
	exit 1
fi
fi

for ((i=1; i<$#-1; i++)); 
do
	if  [ -f "${!i}" ]; then
		cat ${!i} | tr '[:space:]' '[\n*]' | tr '[:punct:]' '[\n*]' | tr '[A-Z]' '[a-z]' | grep ^[$char] >> new_f_tmp.txt
		sed -i "/^.\{,$((num-1))\}$/d" new_f_tmp.txt                                       
	else
	    echo "File does not exist : ${!i}" >&2
	    echo 'Usage : wordFinder.sh <valid file name> [More Files]... <char> <length>'
	    exit 1
	fi
done
	#cat new_f_tmp.txt
	sort new_f_tmp.txt | uniq -c | sort -n | sed 's/^ *//'
	rm new_f_tmp.txt
