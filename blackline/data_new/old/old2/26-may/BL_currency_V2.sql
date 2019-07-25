SET PAGESIZE 0
SET LINESIZE 2048
SET FEEDBACK OFF
SET TRIMSPOOL ON
SET TERMOUT OFF
set colsep '	'
column conversion_rate format 999.9999999999

SELECT             
         r.functional_currency iso_currency_code,
         ROUND (r.rev_rate, 10) conversion_rate,
         to_char(r.period_end_date, 'MM/DD/YYYY') period_end_date, 'D' conversion_method
    FROM gl_translation_rates_v r
   WHERE r.period_year =  TO_CHAR ((LAST_DAY (ADD_MONTHS (SYSDATE, -1))), 'YYYY')
     AND r.to_currency_code = 'USD'
     AND r.period_name =
                     TO_CHAR ((LAST_DAY (ADD_MONTHS (SYSDATE, -1))), 'MON-YY')
     AND r.set_of_books_id IN ('9001', '5002', '12001')
UNION ALL
SELECT 'USD', 1, TO_CHAR ((LAST_DAY (ADD_MONTHS (SYSDATE, -1))), 'MM/DD/YYYY') period_end_date, 'D'
from dual;

exit;
