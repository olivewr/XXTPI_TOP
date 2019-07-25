CTL_FILE=/orashared/TPIPROD/applprd/.CTL_FILE
APPSP=`cat $CTL_FILE|grep -i ^$DBNAME|grep DBSERVER|awk -F'+' '{print $9}'`

OUTPUT_PATH=/u01/app/TPIPROD/apps/apps_st/appl/xxtpi/12.0.0/blackline/data
SQLPLUS_PATH=/u01/app/TPIPROD/apps/tech_st/10.1.3/bin
THE_DATE=`date +"%m%d%Y"`

echo "spool $OUTPUT_PATH/BL_GL_COA_extract_$THE_DATE.txt01" >  $OUTPUT_PATH/run_BL_GL_COA.sql
cat $OUTPUT_PATH/BL_GL_COA.sql                              >> $OUTPUT_PATH/run_BL_GL_COA.sql
$SQLPLUS_PATH/sqlplus apps/$APPSP@TPIPROD @$OUTPUT_PATH/run_BL_GL_COA.sql

cat $OUTPUT_PATH/BL_GL_COA_extract_$THE_DATE.txt01 | grep -v Unique | grep -v rows | grep -v "\-\-\-" | sed -e 's/^$//g' > $OUTPUT_PATH/BL_GL_COA_extract_$THE_DATE.txt
sed -i '/^$/d'              $OUTPUT_PATH/BL_GL_COA_extract_$THE_DATE.txt
sed -i 's/  \+/ /g'         $OUTPUT_PATH/BL_GL_COA_extract_$THE_DATE.txt
sed -i 's/ 	/	/g' $OUTPUT_PATH/BL_GL_COA_extract_$THE_DATE.txt
sed -i 's/	 /	/g' $OUTPUT_PATH/BL_GL_COA_extract_$THE_DATE.txt
sed -i 's/ $//g'            $OUTPUT_PATH/BL_GL_COA_extract_$THE_DATE.txt
rm -rf $OUTPUT_PATH/BL_GL_COA_extract_$THE_DATE.txt01
rm -rf $OUTPUT_PATH/run_BL_GL_COA.sql
