OUTPUT_PATH=/u02/app/TPIPROD/apps/apps_st/appl/xxtpi/12.0.0/blackline/data
SQLPLUS_PATH=/u02/app/TPIPROD/db/tech_st/11.2.0.4/bin
THE_DATE=`date +"%m%d%Y"`

echo "execute MO_GLOBAL.SET_POLICY_CONTEXT('S',103);"  >  $OUTPUT_PATH/run_SUB_AR_V5.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_V5.sql 
echo "spool $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt01"    >> $OUTPUT_PATH/run_SUB_AR_V5.sql
cat $OUTPUT_PATH/SUB_AR_V5.sql                         >> $OUTPUT_PATH/run_SUB_AR_V5.sql
$SQLPLUS_PATH/sqlplus apps/Oc7f3sta@TPIPROD @$OUTPUT_PATH/run_SUB_AR_V5.sql

echo "execute MO_GLOBAL.SET_POLICY_CONTEXT('S',162);"  >  $OUTPUT_PATH/run_SUB_AR_V5.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_V5.sql 
echo "spool $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt02"    >> $OUTPUT_PATH/run_SUB_AR_V5.sql
cat $OUTPUT_PATH/SUB_AR_V5.sql                         >> $OUTPUT_PATH/run_SUB_AR_V5.sql
$SQLPLUS_PATH/sqlplus apps/Oc7f3sta@TPIPROD @$OUTPUT_PATH/run_SUB_AR_V5.sql

echo "execute MO_GLOBAL.SET_POLICY_CONTEXT('S',164);"  >  $OUTPUT_PATH/run_SUB_AR_V5.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_V5.sql 
echo "spool $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt03"    >> $OUTPUT_PATH/run_SUB_AR_V5.sql
cat $OUTPUT_PATH/SUB_AR_V5.sql                         >> $OUTPUT_PATH/run_SUB_AR_V5.sql
$SQLPLUS_PATH/sqlplus apps/Oc7f3sta@TPIPROD @$OUTPUT_PATH/run_SUB_AR_V5.sql

echo "execute MO_GLOBAL.SET_POLICY_CONTEXT('S',166);"  >  $OUTPUT_PATH/run_SUB_AR_V5.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_V5.sql 
echo "spool $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt04"    >> $OUTPUT_PATH/run_SUB_AR_V5.sql
cat $OUTPUT_PATH/SUB_AR_V5.sql                         >> $OUTPUT_PATH/run_SUB_AR_V5.sql
$SQLPLUS_PATH/sqlplus apps/Oc7f3sta@TPIPROD @$OUTPUT_PATH/run_SUB_AR_V5.sql

echo "execute MO_GLOBAL.SET_POLICY_CONTEXT('S',168);"  >  $OUTPUT_PATH/run_SUB_AR_V5.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_V5.sql 
echo "spool $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt05"    >> $OUTPUT_PATH/run_SUB_AR_V5.sql
cat $OUTPUT_PATH/SUB_AR_V5.sql                         >> $OUTPUT_PATH/run_SUB_AR_V5.sql
$SQLPLUS_PATH/sqlplus apps/Oc7f3sta@TPIPROD @$OUTPUT_PATH/run_SUB_AR_V5.sql

echo "execute MO_GLOBAL.SET_POLICY_CONTEXT('S',170);"  >  $OUTPUT_PATH/run_SUB_AR_V5.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_V5.sql 
echo "spool $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt06"    >> $OUTPUT_PATH/run_SUB_AR_V5.sql
cat $OUTPUT_PATH/SUB_AR_V5.sql                         >> $OUTPUT_PATH/run_SUB_AR_V5.sql
$SQLPLUS_PATH/sqlplus apps/Oc7f3sta@TPIPROD @$OUTPUT_PATH/run_SUB_AR_V5.sql

echo "execute MO_GLOBAL.SET_POLICY_CONTEXT('S',183);"  >  $OUTPUT_PATH/run_SUB_AR_V5.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_V5.sql 
echo "spool $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt07"    >> $OUTPUT_PATH/run_SUB_AR_V5.sql
cat $OUTPUT_PATH/SUB_AR_V5.sql                         >> $OUTPUT_PATH/run_SUB_AR_V5.sql
$SQLPLUS_PATH/sqlplus apps/Oc7f3sta@TPIPROD @$OUTPUT_PATH/run_SUB_AR_V5.sql

echo "execute MO_GLOBAL.SET_POLICY_CONTEXT('S',184);"  >  $OUTPUT_PATH/run_SUB_AR_V5.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_V5.sql 
echo "spool $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt08"    >> $OUTPUT_PATH/run_SUB_AR_V5.sql
cat $OUTPUT_PATH/SUB_AR_V5.sql                         >> $OUTPUT_PATH/run_SUB_AR_V5.sql
$SQLPLUS_PATH/sqlplus apps/Oc7f3sta@TPIPROD @$OUTPUT_PATH/run_SUB_AR_V5.sql

echo "execute MO_GLOBAL.SET_POLICY_CONTEXT('S',282);"  >  $OUTPUT_PATH/run_SUB_AR_V5.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_V5.sql 
echo "spool $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt09"    >> $OUTPUT_PATH/run_SUB_AR_V5.sql
cat $OUTPUT_PATH/SUB_AR_V5.sql                         >> $OUTPUT_PATH/run_SUB_AR_V5.sql
$SQLPLUS_PATH/sqlplus apps/Oc7f3sta@TPIPROD @$OUTPUT_PATH/run_SUB_AR_V5.sql

echo "execute MO_GLOBAL.SET_POLICY_CONTEXT('S',342);"  >  $OUTPUT_PATH/run_SUB_AR_V5.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_V5.sql 
echo "spool $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt10"    >> $OUTPUT_PATH/run_SUB_AR_V5.sql
cat $OUTPUT_PATH/SUB_AR_V5.sql                         >> $OUTPUT_PATH/run_SUB_AR_V5.sql
$SQLPLUS_PATH/sqlplus apps/Oc7f3sta@TPIPROD @$OUTPUT_PATH/run_SUB_AR_V5.sql

echo "execute MO_GLOBAL.SET_POLICY_CONTEXT('S',382);"  >  $OUTPUT_PATH/run_SUB_AR_V5.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_V5.sql 
echo "spool $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt11"    >> $OUTPUT_PATH/run_SUB_AR_V5.sql
cat $OUTPUT_PATH/SUB_AR_V5.sql                         >> $OUTPUT_PATH/run_SUB_AR_V5.sql
$SQLPLUS_PATH/sqlplus apps/Oc7f3sta@TPIPROD @$OUTPUT_PATH/run_SUB_AR_V5.sql

echo "execute MO_GLOBAL.SET_POLICY_CONTEXT('S',383);"  >  $OUTPUT_PATH/run_SUB_AR_V5.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_V5.sql 
echo "spool $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt12"    >> $OUTPUT_PATH/run_SUB_AR_V5.sql
cat $OUTPUT_PATH/SUB_AR_V5.sql                         >> $OUTPUT_PATH/run_SUB_AR_V5.sql
$SQLPLUS_PATH/sqlplus apps/Oc7f3sta@TPIPROD @$OUTPUT_PATH/run_SUB_AR_V5.sql

echo "execute MO_GLOBAL.SET_POLICY_CONTEXT('S',422);"  >  $OUTPUT_PATH/run_SUB_AR_V5.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_V5.sql 
echo "spool $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt13"    >> $OUTPUT_PATH/run_SUB_AR_V5.sql
cat $OUTPUT_PATH/SUB_AR_V5.sql                         >> $OUTPUT_PATH/run_SUB_AR_V5.sql
$SQLPLUS_PATH/sqlplus apps/Oc7f3sta@TPIPROD @$OUTPUT_PATH/run_SUB_AR_V5.sql

echo "execute MO_GLOBAL.SET_POLICY_CONTEXT('S',481);"  >  $OUTPUT_PATH/run_SUB_AR_V5.sql
echo "set colsep '	'"                                  >> $OUTPUT_PATH/run_SUB_AR_V5.sql 
echo "spool $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt14"    >> $OUTPUT_PATH/run_SUB_AR_V5.sql
cat $OUTPUT_PATH/SUB_AR_V5.sql                         >> $OUTPUT_PATH/run_SUB_AR_V5.sql
$SQLPLUS_PATH/sqlplus apps/Oc7f3sta@TPIPROD @$OUTPUT_PATH/run_SUB_AR_V5.sql

cat $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt* | grep -v Unique | grep -v rows | grep -v "\-\-\-" | sed -e 's/^$//g' > $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt
sed -i '/^$/d' $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt
sed -i 's/  \+/ /g' $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt
sed -i 's/ 	/	/g' $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt
sed -i 's/	 /	/g' $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt
sed -i 's/ $//g' $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt
sort < $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt > $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt.tmp
cat $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt.tmp | uniq > $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt

rm -rf $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt0*
rm -rf $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt1*
rm -rf $OUTPUT_PATH/run_SUB_AR_V5.sql
rm -rf $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt.tmp
