#! /bin/bash -x
#coin flip simulator (display heads or tails as winner)

total_toss=20
toss_count=0
head_count=0
tail_count=0
calculate_percentage () {

	percentage=`awk "BEGIN {print $1 / 20 *100 }"`
	return $percentage
}

while [ $toss_count -lt $total_toss ]
do
	toss=$(($RANDOM%2))
	if [ $toss -eq 1 ];
	then
		echo "you got heads"
		head_count=$(($head_count+1))
		toss_count=$(($toss_count+1))
	else
        	echo "you got tails"
		tail_count=$(($tail_count+1))
		toss_count=$(($toss_count+1))
	fi
done
calculate_percentage $head_count
percent_head=$?
calculate_percentage $tail_count
percent_tail=$?
singlet_dict=("heads=$head_count:percent=$percent_head" "tails=$tail_count:percent=$percent_tail")
echo ${singlet_dict[@]}

