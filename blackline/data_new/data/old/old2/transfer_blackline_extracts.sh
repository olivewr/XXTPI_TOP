THE_DATE=`date +"%m%d%Y"`
OUTPUT_PATH=/u02/app/TPIPROD/apps/apps_st/appl/xxtpi/12.0.0/blackline/data

~/ftp.blackline.com /u02/app/TPIPROD/apps/apps_st/appl/xxtpi/12.0.0/blackline/data/Currency_Rates_$THE_DATE.txt
~/ftp.blackline.com /u02/app/TPIPROD/apps/apps_st/appl/xxtpi/12.0.0/blackline/data/GL_extract_$THE_DATE.txt
~/ftp.blackline.com /u02/app/TPIPROD/apps/apps_st/appl/xxtpi/12.0.0/blackline/data/R12_BL_AR_V5_$THE_DATE.txt
~/ftp.blackline.com /u02/app/TPIPROD/apps/apps_st/appl/xxtpi/12.0.0/blackline/data/SUB_AP_extract_$THE_DATE.txt

# Save extracts into archive directory
mv $OUTPUT_PATH/*_$THE_DATE.txt $OUTPUT_PATH/archive/
