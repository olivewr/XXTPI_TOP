OUTPUT_PATH=/u03/app/applprod/11.5.10/tpiprodappl/xxtpi/11.5.0/blackline/data
SQLPLUS_PATH=/u03/app/applprod/11.5.10/tpiprodora/8.0.6/bin
THE_DATE=`date +"%m%d%Y"`

echo "execute dbms_application_info.set_client_info(103);"  >  $OUTPUT_PATH/run_SUB_AR_extract.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_extract.sql 
echo "spool $OUTPUT_PATH/SUB_AR_extract_$THE_DATE.txt01"    >> $OUTPUT_PATH/run_SUB_AR_extract.sql
cat $OUTPUT_PATH/SUB_AR_extract.sql                         >> $OUTPUT_PATH/run_SUB_AR_extract.sql
$SQLPLUS_PATH/sqlplus apps/applsys2 @$OUTPUT_PATH/run_SUB_AR_extract.sql

echo "execute dbms_application_info.set_client_info(162);"  >  $OUTPUT_PATH/run_SUB_AR_extract.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_extract.sql 
echo "spool $OUTPUT_PATH/SUB_AR_extract_$THE_DATE.txt02"    >> $OUTPUT_PATH/run_SUB_AR_extract.sql
cat $OUTPUT_PATH/SUB_AR_extract.sql                         >> $OUTPUT_PATH/run_SUB_AR_extract.sql
$SQLPLUS_PATH/sqlplus apps/applsys2 @$OUTPUT_PATH/run_SUB_AR_extract.sql

echo "execute dbms_application_info.set_client_info(164);"  >  $OUTPUT_PATH/run_SUB_AR_extract.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_extract.sql 
echo "spool $OUTPUT_PATH/SUB_AR_extract_$THE_DATE.txt03"    >> $OUTPUT_PATH/run_SUB_AR_extract.sql
cat $OUTPUT_PATH/SUB_AR_extract.sql                         >> $OUTPUT_PATH/run_SUB_AR_extract.sql
$SQLPLUS_PATH/sqlplus apps/applsys2 @$OUTPUT_PATH/run_SUB_AR_extract.sql

echo "execute dbms_application_info.set_client_info(166);"  >  $OUTPUT_PATH/run_SUB_AR_extract.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_extract.sql 
echo "spool $OUTPUT_PATH/SUB_AR_extract_$THE_DATE.txt04"    >> $OUTPUT_PATH/run_SUB_AR_extract.sql
cat $OUTPUT_PATH/SUB_AR_extract.sql                         >> $OUTPUT_PATH/run_SUB_AR_extract.sql
$SQLPLUS_PATH/sqlplus apps/applsys2 @$OUTPUT_PATH/run_SUB_AR_extract.sql

echo "execute dbms_application_info.set_client_info(168);"  >  $OUTPUT_PATH/run_SUB_AR_extract.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_extract.sql 
echo "spool $OUTPUT_PATH/SUB_AR_extract_$THE_DATE.txt05"    >> $OUTPUT_PATH/run_SUB_AR_extract.sql
cat $OUTPUT_PATH/SUB_AR_extract.sql                         >> $OUTPUT_PATH/run_SUB_AR_extract.sql
$SQLPLUS_PATH/sqlplus apps/applsys2 @$OUTPUT_PATH/run_SUB_AR_extract.sql

echo "execute dbms_application_info.set_client_info(170);"  >  $OUTPUT_PATH/run_SUB_AR_extract.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_extract.sql 
echo "spool $OUTPUT_PATH/SUB_AR_extract_$THE_DATE.txt06"    >> $OUTPUT_PATH/run_SUB_AR_extract.sql
cat $OUTPUT_PATH/SUB_AR_extract.sql                         >> $OUTPUT_PATH/run_SUB_AR_extract.sql
$SQLPLUS_PATH/sqlplus apps/applsys2 @$OUTPUT_PATH/run_SUB_AR_extract.sql

echo "execute dbms_application_info.set_client_info(183);"  >  $OUTPUT_PATH/run_SUB_AR_extract.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_extract.sql 
echo "spool $OUTPUT_PATH/SUB_AR_extract_$THE_DATE.txt07"    >> $OUTPUT_PATH/run_SUB_AR_extract.sql
cat $OUTPUT_PATH/SUB_AR_extract.sql                         >> $OUTPUT_PATH/run_SUB_AR_extract.sql
$SQLPLUS_PATH/sqlplus apps/applsys2 @$OUTPUT_PATH/run_SUB_AR_extract.sql

echo "execute dbms_application_info.set_client_info(184);"  >  $OUTPUT_PATH/run_SUB_AR_extract.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_extract.sql 
echo "spool $OUTPUT_PATH/SUB_AR_extract_$THE_DATE.txt08"    >> $OUTPUT_PATH/run_SUB_AR_extract.sql
cat $OUTPUT_PATH/SUB_AR_extract.sql                         >> $OUTPUT_PATH/run_SUB_AR_extract.sql
$SQLPLUS_PATH/sqlplus apps/applsys2 @$OUTPUT_PATH/run_SUB_AR_extract.sql

echo "execute dbms_application_info.set_client_info(282);"  >  $OUTPUT_PATH/run_SUB_AR_extract.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_extract.sql 
echo "spool $OUTPUT_PATH/SUB_AR_extract_$THE_DATE.txt09"    >> $OUTPUT_PATH/run_SUB_AR_extract.sql
cat $OUTPUT_PATH/SUB_AR_extract.sql                         >> $OUTPUT_PATH/run_SUB_AR_extract.sql
$SQLPLUS_PATH/sqlplus apps/applsys2 @$OUTPUT_PATH/run_SUB_AR_extract.sql

echo "execute dbms_application_info.set_client_info(342);"  >  $OUTPUT_PATH/run_SUB_AR_extract.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_extract.sql 
echo "spool $OUTPUT_PATH/SUB_AR_extract_$THE_DATE.txt10"    >> $OUTPUT_PATH/run_SUB_AR_extract.sql
cat $OUTPUT_PATH/SUB_AR_extract.sql                         >> $OUTPUT_PATH/run_SUB_AR_extract.sql
$SQLPLUS_PATH/sqlplus apps/applsys2 @$OUTPUT_PATH/run_SUB_AR_extract.sql

echo "execute dbms_application_info.set_client_info(382);"  >  $OUTPUT_PATH/run_SUB_AR_extract.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_extract.sql 
echo "spool $OUTPUT_PATH/SUB_AR_extract_$THE_DATE.txt11"    >> $OUTPUT_PATH/run_SUB_AR_extract.sql
cat $OUTPUT_PATH/SUB_AR_extract.sql                         >> $OUTPUT_PATH/run_SUB_AR_extract.sql
$SQLPLUS_PATH/sqlplus apps/applsys2 @$OUTPUT_PATH/run_SUB_AR_extract.sql

echo "execute dbms_application_info.set_client_info(383);"  >  $OUTPUT_PATH/run_SUB_AR_extract.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_extract.sql 
echo "spool $OUTPUT_PATH/SUB_AR_extract_$THE_DATE.txt12"    >> $OUTPUT_PATH/run_SUB_AR_extract.sql
cat $OUTPUT_PATH/SUB_AR_extract.sql                         >> $OUTPUT_PATH/run_SUB_AR_extract.sql
$SQLPLUS_PATH/sqlplus apps/applsys2 @$OUTPUT_PATH/run_SUB_AR_extract.sql

echo "execute dbms_application_info.set_client_info(422);"  >  $OUTPUT_PATH/run_SUB_AR_extract.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_extract.sql 
echo "spool $OUTPUT_PATH/SUB_AR_extract_$THE_DATE.txt13"    >> $OUTPUT_PATH/run_SUB_AR_extract.sql
cat $OUTPUT_PATH/SUB_AR_extract.sql                         >> $OUTPUT_PATH/run_SUB_AR_extract.sql
$SQLPLUS_PATH/sqlplus apps/applsys2 @$OUTPUT_PATH/run_SUB_AR_extract.sql

echo "execute dbms_application_info.set_client_info(481);"  >  $OUTPUT_PATH/run_SUB_AR_extract.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_extract.sql 
echo "spool $OUTPUT_PATH/SUB_AR_extract_$THE_DATE.txt14"    >> $OUTPUT_PATH/run_SUB_AR_extract.sql
cat $OUTPUT_PATH/SUB_AR_extract.sql                         >> $OUTPUT_PATH/run_SUB_AR_extract.sql
$SQLPLUS_PATH/sqlplus apps/applsys2 @$OUTPUT_PATH/run_SUB_AR_extract.sql

cat $OUTPUT_PATH/SUB_AR_extract_$THE_DATE.txt* | grep -v Unique | grep -v rows | grep -v "\-\-\-" | sed -e 's/^$//g' > $OUTPUT_PATH/SUB_AR_extract_$THE_DATE.txt
sed -i '/^$/d' $OUTPUT_PATH/SUB_AR_extract_$THE_DATE.txt
sed -i 's/  \+/ /g' $OUTPUT_PATH/SUB_AR_extract_$THE_DATE.txt
sed -i 's/ 	/	/g' $OUTPUT_PATH/SUB_AR_extract_$THE_DATE.txt
sed -i 's/	 /	/g' $OUTPUT_PATH/SUB_AR_extract_$THE_DATE.txt
sed -i 's/ $//g' $OUTPUT_PATH/SUB_AR_extract_$THE_DATE.txt
rm -rf $OUTPUT_PATH/SUB_AR_extract_$THE_DATE.txt0*
rm -rf $OUTPUT_PATH/SUB_AR_extract_$THE_DATE.txt1*
rm -rf $OUTPUT_PATH/run_SUB_AR_extract.sql
