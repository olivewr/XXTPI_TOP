OUTPUT_PATH=/u02/app/TPIPROD/apps/apps_st/appl/xxtpi/12.0.0/blackline/data
(

THE_DATE=`date +"%m%d%Y"`
echo "put $OUTPUT_PATH/Currency_Rates_$THE_DATE.txt" >  $OUTPUT_PATH/sftp_transfer_commands.txt
echo "put $OUTPUT_PATH/GL_extract_$THE_DATE.txt"     >> $OUTPUT_PATH/sftp_transfer_commands.txt
echo "put $OUTPUT_PATH/SUB_AR_V5_$THE_DATE.txt"       >> $OUTPUT_PATH/sftp_transfer_commands.txt
echo "put $OUTPUT_PATH/SUB_AP_extract_$THE_DATE.txt" >> $OUTPUT_PATH/sftp_transfer_commands.txt
echo "bye"                                           >> $OUTPUT_PATH/sftp_transfer_commands.txt
echo "Starting SFTP now!!!"
sftp  -b $OUTPUT_PATH/sftp_transfer_commands.txt "TPIComposites"@"ftp.blackline.com"
echo "SFTP done!!!"

# Save extracts into archive directory
mv $OUTPUT_PATH/*_$THE_DATE.txt $OUTPUT_PATH/archive/

) > $OUTPUT_PATH/transfer_blackline_extracts.log
