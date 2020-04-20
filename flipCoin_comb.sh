#! /bin/bash -x
#coin flip simulator (display heads or tails as winner)

toss=$(($RANDOM%2))
if [ $toss -eq 1 ];
then
	echo "you got heads"
else
        echo "you got tails"
fi
