#!/bin/bash

towns=()
exec 100<> towns.txt
while read line <&100
do
{
	town_id=${line%%|*}
	line=${line#*|}

	town_name=${line%%|*}
	line=${line#*|}

	border_or_inland=${line%%|*}
	line=${line#*|}

	towns+=($town_name)
}
done
exec 100>&-

echo "Caller Information:"
echo "Caller Information:" >> $1locations.log
exec 400<> subscribers.txt
while read line <&400
do
{
	#Extract data
	phone_number=${line%%|*} #extract the phone number
	line=${line#*|}

	name=${line%%|*}
	line=${line#*|}

	gender=${line%%|*}
	line=${line#*|}

	birth_year=${line%%|*}
	line=${line#*|}

	town_id=${line%%|*}
	line=${line#*|}

	email=${line%%|*}
	line=${line#*|}

	current_year=$(date +'%Y')

	age=$( expr $current_year - $birth_year);

	if [ $1 = $phone_number ];
	then
		echo "$phone_number | $name | $age | $gender | ${towns[$town_id]}"
		echo "$phone_number | $name | $age | $gender | ${towns[$town_id]}" >> $1locations.log
	fi
}
done
exec 400>&-

echo "Locations:"
echo "Locations:" >> $1locations.log

exec 200<> calls.txt
while read line <&200
do
{
	call_date=${line%%|*}
        line=${line#*|}

	call_time=${line%%|*}
        line=${line#*|}

	call_duration=${line%%|*}
        line=${line#*|}

	callee=${line%%|*}
        line=${line#*|}

	caller=${line%%|*}
        line=${line#*|}

	callee_location=${line%%|*}
        line=${line#*|}

	caller_location=${line%%|*}
        line=${line#*|}

	if [ $1 = $caller ];
	then
		echo "${towns[$callee_location]}"
		echo "${towns[$callee_location]}" >> $1locations.log
	fi
}
done
exec 200>&-
