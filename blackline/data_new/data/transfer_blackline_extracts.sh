OUTPUT_PATH=/u02/app/TPIPROD/apps/apps_st/appl/xxtpi/12.0.0/blackline/data
(

THE_DATE=`date +"%m%d%Y"`

cp -rfp $OUTPUT_PATH/BL_currency_COA_extract_$THE_DATE.txt  $OUTPUT_PATH/Currency_Rates_$THE_DATE.txt
cp -rfp $OUTPUT_PATH/BL_GL_COA_extract_$THE_DATE.txt        $OUTPUT_PATH/GL_extract_$THE_DATE.txt
cp -rfp $OUTPUT_PATH/BL_AR_COA_extract_$THE_DATE.txt        $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt
cp -rfp $OUTPUT_PATH/BL_AP_COA_extract_$THE_DATE.txt        $OUTPUT_PATH/SUB_AP_extract_$THE_DATE.txt

echo "put $OUTPUT_PATH/Currency_Rates_$THE_DATE.txt" >  $OUTPUT_PATH/sftp_transfer_commands.txt
echo "put $OUTPUT_PATH/GL_extract_$THE_DATE.txt"     >> $OUTPUT_PATH/sftp_transfer_commands.txt
echo "put $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt"      >> $OUTPUT_PATH/sftp_transfer_commands.txt
echo "put $OUTPUT_PATH/SUB_AP_extract_$THE_DATE.txt" >> $OUTPUT_PATH/sftp_transfer_commands.txt
echo "bye"                                           >> $OUTPUT_PATH/sftp_transfer_commands.txt
echo "Starting SFTP now!!!"
sftp  -vvv -b $OUTPUT_PATH/sftp_transfer_commands.txt "TPIComposites"@"ftp.blackline.com"
echo "SFTP done!!!"

# Save extracts into archive directory
#rm -rf $OUTPUT_PATH/BL*.txt
#mv     $OUTPUT_PATH/*_$THE_DATE.txt $OUTPUT_PATH/archive/

) > $OUTPUT_PATH/transfer_blackline_extracts.log
