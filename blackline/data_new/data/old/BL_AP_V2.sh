OUTPUT_PATH=/u02/app/TPIPROD/apps/apps_st/appl/xxtpi/12.0.0/blackline/data
SQLPLUS_PATH=/u02/app/TPIPROD/db/tech_st/11.2.0.4/bin
THE_DATE=`date +"%m%d%Y"`

echo "spool $OUTPUT_PATH/SUB_AP_extract_$THE_DATE.txt"    >  $OUTPUT_PATH/run_BL_AP_V5.sql
cat $OUTPUT_PATH/BL_AP_V5.sql                             >> $OUTPUT_PATH/run_BL_AP_V5.sql
$SQLPLUS_PATH/sqlplus apps/Oc7f3sta@TPIPROD @$OUTPUT_PATH/run_BL_AP_V5.sql

cat $OUTPUT_PATH/SUB_AP_extract_$THE_DATE.txt | grep -v Unique | grep -v rows | grep -v "\-\-\-" | sed -e 's/^$//g' > $OUTPUT_PATH/SUB_AP_extract_$THE_DATE.txt01
sed -i '/^$/d'  $OUTPUT_PATH/SUB_AP_extract_$THE_DATE.txt01
sed -i 's/  \+/ /g' $OUTPUT_PATH/SUB_AP_extract_$THE_DATE.txt01
sed -i 's/ 	/	/g' $OUTPUT_PATH/SUB_AP_extract_$THE_DATE.txt01
sed -i 's/	 /	/g' $OUTPUT_PATH/SUB_AP_extract_$THE_DATE.txt01
sed -i 's/ $//g' $OUTPUT_PATH/SUB_AP_extract_$THE_DATE.txt01
mv $OUTPUT_PATH/SUB_AP_extract_$THE_DATE.txt01 $OUTPUT_PATH/SUB_AP_extract_$THE_DATE.txt
rm -rf $OUTPUT_PATH/run_BL_AP_V5.sql
