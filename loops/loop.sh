#!/bin/bash
loops="FOR WHILE UNTIL"
echo "In shell scripting, there are primarily three types of loops"

for loop in $loops
do
	echo $loop loop condition 
done
echo Below are the syntaxes for each

echo ============FOR loop==================

for_loop="RED GREEN ORANGE"
for for_loops in $for_loop;
do
echo "we have $for_loops color for you"	
done

echo ============WHILE loop==================

echo "While condition is used to continues when the condition is true Ex: when the input is lesser than equal to 5 "
while_loop=1
while [ $while_loop -le 5 ]
do 
	echo $while_loop
	((while_loop++))
done

echo ============UNTILL loop==================

echo "untill condition is used to exec untill when the condition is true EX: Exec untill when the input is lesser than equal to 5 "

untill_loop=10
until [ $untill_loop -le 5 ]
do 
	echo $untill_loop
	((untill_loop--))

done
