SET PAGESIZE 0
SET LINESIZE 2048
SET FEEDBACK OFF
SET TRIMSPOOL ON
SET TERMOUT OFF
set colsep '	'
column conversion_rate format 999.9999999999

SELECT   distinct       
         r.to_currency iso_currency_code,
         ROUND (r.conversion_rate, 10) conversion_rate, to_char(end_date,'MM/DD/YYYY') period_end_date, 'D' conversion_method
    FROM gl_daily_rates r, GL_PERIOD_STATUSES p
   WHERE 1=1
     AND to_char(CONVERSION_DATE,'MON-YY') = P.PERIOD_NAME
     AND r.FROM_currency = 'USD'
     AND to_char(CONVERSION_DATE,'MON-YY')  =  TO_CHAR ((LAST_DAY (ADD_MONTHS (SYSDATE, -1))), 'MON-YY')
     AND r.to_currency in ('CNY','TRY','MXN', 'DKK', 'CHF')
     AND to_char(end_date,'MM/DD/YYYY')  =  to_char(CONVERSION_DATE,'MM/DD/YYYY')
     AND to_char(end_date,'MM/DD/YYYY')  =  TO_CHAR ((LAST_DAY (ADD_MONTHS (SYSDATE, -1))), 'MM/DD/YYYY')
     AND (r.conversion_type like  'Period End%' or r.conversion_type = '1140')
UNION ALL
SELECT 'USD', 1, TO_CHAR ((LAST_DAY (ADD_MONTHS (SYSDATE, -1))), 'MM/DD/YYYY') period_end_date, 'D'
from dual;

exit;
