OUTPUT_PATH=/u03/app/applprod/11.5.10/tpiprodappl/xxtpi/11.5.0/blackline/data
SQLPLUS_PATH=/u03/app/applprod/11.5.10/tpiprodora/8.0.6/bin
THE_DATE=`date +"%m%d%Y"`

echo "spool $OUTPUT_PATH/SUB_AP_extract_$THE_DATE.txt"    >  $OUTPUT_PATH/run_BL_AP_V2.sql
cat $OUTPUT_PATH/BL_AP_V2.sql                             >> $OUTPUT_PATH/run_BL_AP_V2.sql
$SQLPLUS_PATH/sqlplus apps/applsys2 @$OUTPUT_PATH/run_BL_AP_V2.sql

cat $OUTPUT_PATH/SUB_AP_extract_$THE_DATE.txt | grep -v Unique | grep -v rows | grep -v "\-\-\-" | sed -e 's/^$//g' > $OUTPUT_PATH/SUB_AP_extract_$THE_DATE.txt01
sed -i '/^$/d'  $OUTPUT_PATH/SUB_AP_extract_$THE_DATE.txt01
sed -i 's/  \+/ /g' $OUTPUT_PATH/SUB_AP_extract_$THE_DATE.txt01
sed -i 's/ 	/	/g' $OUTPUT_PATH/SUB_AP_extract_$THE_DATE.txt01
sed -i 's/	 /	/g' $OUTPUT_PATH/SUB_AP_extract_$THE_DATE.txt01
sed -i 's/ $//g' $OUTPUT_PATH/SUB_AP_extract_$THE_DATE.txt01
mv $OUTPUT_PATH/SUB_AP_extract_$THE_DATE.txt01 $OUTPUT_PATH/SUB_AP_extract_$THE_DATE.txt
rm -rf $OUTPUT_PATH/run_BL_AP_V2.sql
