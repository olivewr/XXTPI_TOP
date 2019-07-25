OUTPUT_PATH=/u03/app/applprod/11.5.10/tpiprodappl/xxtpi/11.5.0/blackline/data
SQLPLUS_PATH=/u03/app/applprod/11.5.10/tpiprodora/8.0.6/bin
THE_DATE=`date +"%m%d%Y"`

echo "spool $OUTPUT_PATH/GL_extract_$THE_DATE.txt01"    >  $OUTPUT_PATH/run_BL_GL_V2.sql
cat $OUTPUT_PATH/BL_GL_V2.sql                           >> $OUTPUT_PATH/run_BL_GL_V2.sql
$SQLPLUS_PATH/sqlplus apps/applsys2 @$OUTPUT_PATH/run_BL_GL_V2.sql

cat $OUTPUT_PATH/GL_extract_$THE_DATE.txt01 | grep -v Unique | grep -v rows | grep -v "\-\-\-" | sed -e 's/^$//g' > $OUTPUT_PATH/GL_extract_$THE_DATE.txt
sed -i '/^$/d'  $OUTPUT_PATH/GL_extract_$THE_DATE.txt
sed -i 's/  \+/ /g' $OUTPUT_PATH/GL_extract_$THE_DATE.txt
sed -i 's/ 	/	/g' $OUTPUT_PATH/GL_extract_$THE_DATE.txt
sed -i 's/	 /	/g' $OUTPUT_PATH/GL_extract_$THE_DATE.txt
sed -i 's/ $//g' $OUTPUT_PATH/GL_extract_$THE_DATE.txt
rm -rf $OUTPUT_PATH/GL_extract_$THE_DATE.txt01
rm -rf $OUTPUT_PATH/run_BL_GL_V2.sql
