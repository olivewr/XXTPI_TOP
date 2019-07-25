THE_DATE=`date +"%m%d%Y"`
OUTPUT_PATH=/u03/app/applprod/11.5.10/tpiprodappl/xxtpi/11.5.0/blackline/data

~/ftp.blackline.com /u03/app/applprod/11.5.10/tpiprodappl/xxtpi/11.5.0/blackline/data/Currency_Rates_$THE_DATE.txt
~/ftp.blackline.com /u03/app/applprod/11.5.10/tpiprodappl/xxtpi/11.5.0/blackline/data/GL_extract_$THE_DATE.txt
~/ftp.blackline.com /u03/app/applprod/11.5.10/tpiprodappl/xxtpi/11.5.0/blackline/data/SUB_AR_extract_$THE_DATE.txt
~/ftp.blackline.com /u03/app/applprod/11.5.10/tpiprodappl/xxtpi/11.5.0/blackline/data/SUB_AP_extract_$THE_DATE.txt

# Save extracts into archive directory
mv $OUTPUT_PATH/*_$THE_DATE.txt $OUTPUT_PATH/archive/
