OUTPUT_PATH=/u02/app/TPIPROD/apps/apps_st/appl/xxtpi/12.0.0/blackline/data
SQLPLUS_PATH=/u02/app/TPIPROD/db/tech_st/11.2.0.4/bin
THE_DATE=`date +"%m%d%Y"`

echo "spool $OUTPUT_PATH/GL_extract_$THE_DATE.txt01"    >  $OUTPUT_PATH/run_BL_GL_V5.sql
cat $OUTPUT_PATH/BL_GL_V5.sql                           >> $OUTPUT_PATH/run_BL_GL_V5.sql
$SQLPLUS_PATH/sqlplus apps/Oc7f3sta@TPIPROD @$OUTPUT_PATH/run_BL_GL_V5.sql

cat $OUTPUT_PATH/GL_extract_$THE_DATE.txt01 | grep -v Unique | grep -v rows | grep -v "\-\-\-" | sed -e 's/^$//g' > $OUTPUT_PATH/GL_extract_$THE_DATE.txt
sed -i '/^$/d'  $OUTPUT_PATH/GL_extract_$THE_DATE.txt
sed -i 's/  \+/ /g' $OUTPUT_PATH/GL_extract_$THE_DATE.txt
sed -i 's/ 	/	/g' $OUTPUT_PATH/GL_extract_$THE_DATE.txt
sed -i 's/	 /	/g' $OUTPUT_PATH/GL_extract_$THE_DATE.txt
sed -i 's/ $//g' $OUTPUT_PATH/GL_extract_$THE_DATE.txt
rm -rf $OUTPUT_PATH/GL_extract_$THE_DATE.txt01
rm -rf $OUTPUT_PATH/run_BL_GL_V5.sql
