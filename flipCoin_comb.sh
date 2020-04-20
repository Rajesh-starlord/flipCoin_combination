#! /bin/bash -x
#coin flip simulator storing single doublet and triplet combination as well

total_toss=20
toss_count=0
head_count=0
tail_count=0
calculate_percentage () {

	percentage=`awk "BEGIN {print $1 / 20 *100 }"`
	return $percentage
}

toss () {
	toss=$(($RANDOM%2))
	if [ $toss -eq 1 ];
        then
		return 1
        else
		return 0
        fi
}

extract_val () {
        value=`echo $@ | awk -F"=" '{print $2}'`
        return $value
}

extract_key () {
        key=`echo $@ | awk -F"=" '{print $1}'`
        echo "$key"
}


get_singlet_comb () {
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
	toss_count=0
}

doublet=""
dict1=(HH HT TH TT)
doublet_dict=("HH=0" "HT=0" "TH=0" "TT=0")
get_doublet_comb () {
        while [ $toss_count -lt $total_toss ]
        do
               	for ((i=0;i<2;i++))
		do
			toss
			if [ $? -eq 1 ];
			then
				doublet+="H"
			else
				doublet+="T"
			fi
		done
		echo $doublet
                for((i=0;i<${#doublet_dict[@]};i++))
		do
			key=${dict1[$i]}
			if [ $key == $doublet ];
			then
				extract_val ${doublet_dict[$i]}
				val=$?
				val=$(($val+1))
				doublet_dict[$i]="${dict1[$i]}=$val"
			fi
		done
		toss_count=$(($toss_count+1))
		doublet=""
        done
	for((i=0;i<${#doublet_dict[@]};i++))
        do
		extract_val ${doublet_dict[$i]}
                val=$?
		calculate_percentage $val
		percentage=$?
		doublet_dict[$i]="${doublet_dict[$i]}:percent=$percentage"
        done
        echo ${doublet_dict[@]}
	toss_count=0
}

dict2=(HHH HHT HTT HTH THH TTH THT TTT)
triplet_dict=(HHH=0 HHT=0 HTT=0 HTH=0 THH=0 TTH=0 THT=0 TTT=0)
get_triplet_comb () {
        while [ $toss_count -lt $total_toss ]
        do
                for ((i=0;i<3;i++))
                do
                        toss
                        if [ $? -eq 1 ];
                        then
                                triplet+="H"
                        else
                                triplet+="T"
                        fi
                done
                echo $triplet
                for((i=0;i<${#triplet_dict[@]};i++))
                do
                        key=${dict2[$i]}
                        if [ $key == $triplet ];
                        then
                                extract_val ${triplet_dict[$i]}
                                val=$?
                                val=$(($val+1))
                                triplet_dict[$i]="${dict2[$i]}=$val"
                        fi
                done
                toss_count=$(($toss_count+1))
                triplet=""
        done
        for((i=0;i<${#triplet_dict[@]};i++))
        do
                extract_val ${triplet_dict[$i]}
                val=$?
                calculate_percentage $val
                percentage=$?
                triplet_dict[$i]="${triplet_dict[$i]}:percent=$percentage"
        done
        echo ${triplet_dict[@]}
        toss_count=0
}

get_singlet_comb
get_doublet_comb
get_triplet_comb
