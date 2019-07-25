SELECT   distinct       
         r.to_currency iso_currency_code,
         ROUND (r.conversion_rate, 10) conversion_rate, to_char(end_date,'MM/DD/YYYY') period_end_date, 'D' conversion_method
    FROM gl_daily_rates r, GL_PERIOD_STATUSES p
   WHERE 1=1
     AND to_char(CONVERSION_DATE,'MON-YY') = P.PERIOD_NAME
     AND r.FROM_currency = 'USD'
     AND to_char(CONVERSION_DATE,'MON-YY')  =  TO_CHAR ((LAST_DAY (ADD_MONTHS (SYSDATE, -1))), 'MON-YY')
     AND r.to_currency in ('CNY','TRY','MXN')
     AND to_char(end_date,'MM/DD/YYYY')  =  to_char(CONVERSION_DATE,'MM/DD/YYYY')
     AND to_char(end_date,'MM/DD/YYYY')  =  TO_CHAR ((LAST_DAY (ADD_MONTHS (SYSDATE, -1))), 'MM/DD/YYYY')
     AND r.conversion_type like  'Period End%'
 UNION ALL
SELECT 'USD', 1, TO_CHAR ((LAST_DAY (ADD_MONTHS (SYSDATE, -1))), 'MM/DD/YYYY') period_end_date, 'D'
from dual;

