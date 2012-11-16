
for testName in $(cat Tests.txt)
do
	path=$(echo $testName|sed 's=/Allrun==g')
	printableName=$(echo $path|sed 's=/=-=g')
	script=scripts/Test_$printableName.sh
	cp scripts/Template.sh $script 
	expression="s=__TEST_NAME__=$printableName=g"
	sed -i $expression $script
	expression="s=__TEST_PATH__=$path=g"
	sed -i $expression $script
done
