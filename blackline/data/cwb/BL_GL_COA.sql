SET PAGESIZE 0
SET LINESIZE 8048
SET FEEDBACK OFF
SET TRIMSPOOL ON
SET TERMOUT OFF
set colsep '	'
set numwidth 15

-- Created by Taraj Khan
-- Purpose: Send this GL data to blackline ftp server from where it gets loaded into blackline system (Daily process)
-- Version 6: COA Project changes by Taraj, Query modified on 01-06-2017 

---- for all US and ARM companies only 
SELECT --gl_balances.CODE_COMBINATION_ID, 
   -- gl_combos.SEGMENT1||'.'||gl_combos.SEGMENT2||'.'||gl_combos.SEGMENT3||'.'||gl_combos.SEGMENT4||'.'||gl_combos.SEGMENT5||'.'||gl_combos.SEGMENT6 all_segment,
         gl_combos.SEGMENT1 "Entity Unique Identifier",
         gl_combos.SEGMENT3 "Account Number",
         gl_combos.SEGMENT5 "Intercompany",
         NULL "Key4",
         NULL "Key5",
         NULL "Key6",
         NULL "Key7",
         NULL "Key8",
         NULL "Key9",
         NULL "Key10",
   -- valu_tl.DESCRIPTION,*/
    APPS.XXTPI_GET_ACCOUNT_DESC_F ('ONE_SEGMENT',gl_balances.LEDGER_ID,NULL,'SEGMENT3',gl_combos.segment3,'US',NULL) "Account Description",
    NULL AS "AccountReference",
    'A',
    DECODE (gl_combos.ACCOUNT_TYPE, 'A','Asset','L', 'Liability', 'O', 'Equity', 'R', 'Revenue', 'E', 'Expense', NULL) "Account Type",
    'TRUE' AS "Active Account",
    'FALSE' AS "Activity InPeriod",
   -- DECODE ((ABS(gl_balances.PERIOD_NET_CR) + ABS(gl_balances.PERIOD_NET_DR)), 0, 'FALSE', 'TRUE') AS ""Activity InPeriod"",
    /*Insert Field for Functional Currency*/ NULL AS "AlternateCurrency",
     gl_balances.CURRENCY_CODE AS "AccountCurrency",
     to_char(last_day(add_months(sysdate,-1)),'MM/DD/YYYY') "Period End Date",
    /*Insert Field for Reporting Currency Balance*/ NULL "GL Reporting Balance",
    /*Insert Field for Functional Currency Balance*/ NULL "GL Alternate Balance",
    SUM((gl_balances.BEGIN_BALANCE_DR + gl_balances.PERIOD_NET_DR - gl_balances.BEGIN_BALANCE_CR - gl_balances.PERIOD_NET_CR)) "GL Account Balance"
FROM 
    GL.GL_BALANCES gl_balances,
    GL.GL_CODE_COMBINATIONS gl_combos,
    GL.gl_ledgers gl_books,
    APPLSYS.FND_FLEX_VALUES valu,
    APPLSYS.FND_FLEX_VALUES_TL valu_tl
WHERE gl_balances.CODE_COMBINATION_ID = gl_combos.CODE_COMBINATION_ID
    AND gl_combos.SUMMARY_FLAG = 'N' 
    AND gl_combos.SEGMENT3 BETWEEN '000000' AND '399999'
    AND valu.FLEX_VALUE_SET_ID = '1016917' --GL_COA_PRODUCT   --'1009651' 
    AND valu.FLEX_VALUE_ID = valu_tl.FLEX_VALUE_ID 
    AND gl_combos.SEGMENT4 = valu.FLEX_VALUE
    AND gl_books.LEDGER_ID IN  (4001, 8001)
    and gl_balances.ledger_id = gl_books.ledger_id 
    AND gl_balances.CURRENCY_CODE = 'USD' 
    AND gl_combos.segment1 IN ( '110', '120','130','140','141', '150', '160', '200')-- for all US and ARM companies only
    AND gl_combos.segment1 NOT IN ('100','000', '500', '510','520','730','310','750','420', '300', '400','900','720','740')
    AND gl_combos.segment3 NOT LIKE ('00%')
    AND gl_books.LEDGER_ID = gl_balances.LEDGER_ID
    AND gl_balances.PERIOD_NAME = to_char((last_day(add_months(sysdate,-1))),'MON-YY')
    AND gl_balances.ACTUAL_FLAG = 'A'
    AND valu_tl.language='US'
GROUP BY
   -- gl_balances.CODE_COMBINATION_ID,   
   -- gl_combos.SEGMENT1||'.'||gl_combos.SEGMENT2||'.'||gl_combos.SEGMENT3||'.'||gl_combos.SEGMENT4||'.'||gl_combos.SEGMENT5||'.'||gl_combos.SEGMENT6,
    valu_tl.language,
    gl_combos.SEGMENT1,gl_combos.SEGMENT3,gl_combos.SEGMENT5, valu.FLEX_VALUE_SET_ID,
    APPS.XXTPI_GET_ACCOUNT_DESC_F ('ONE_SEGMENT',gl_balances.LEDGER_ID,NULL,'SEGMENT3',gl_combos.segment3,'US',NULL),
    DECODE (gl_combos.ACCOUNT_TYPE, 'A','Asset','L', 'Liability', 'O', 'Equity', 'R', 'Revenue', 'E', 'Expense', NULL),
  -- DECODE ((ABS(gl_balances.PERIOD_NET_CR) + ABS(gl_balances.PERIOD_NET_DR)), 0, 'FALSE', 'TRUE'),
    gl_balances.CURRENCY_CODE,
    TRUNC (LAST_DAY (ADD_MONTHS (SYSDATE, -1)))       
UNION ALL
--For all local companies with local curr only
SELECT --gl_balances.CODE_COMBINATION_ID, 
   -- gl_combos.SEGMENT1||'.'||gl_combos.SEGMENT2||'.'||gl_combos.SEGMENT3||'.'||gl_combos.SEGMENT4||'.'||gl_combos.SEGMENT5||'.'||gl_combos.SEGMENT6 all_segment,
  gl_combos.SEGMENT1 "Entity Unique Identifier",
         gl_combos.SEGMENT3 "Account Number",
         gl_combos.SEGMENT5 "Intercompany",
         NULL "Key4",
         NULL "Key5",
         NULL "Key6",
         NULL "Key7",
         NULL "Key8",
         NULL "Key9",
         NULL "Key10",
    APPS.XXTPI_GET_ACCOUNT_DESC_F ('ONE_SEGMENT',gl_balances.LEDGER_ID,NULL,'SEGMENT3',gl_combos.segment3,'US',NULL) "Account Description",
    NULL AS "AccountReference",
    'A',
    DECODE (gl_combos.ACCOUNT_TYPE, 'A','Asset','L', 'Liability', 'O', 'Equity', 'R', 'Revenue', 'E', 'Expense', NULL) "Account Type",
    'TRUE' AS "Active Account",
    'FALSE' AS "Activity InPeriod",
   -- DECODE ((ABS(gl_balances.PERIOD_NET_CR) + ABS(gl_balances.PERIOD_NET_DR)), 0, 'FALSE', 'TRUE') AS ""Activity InPeriod"",
    /*Insert Field for Functional Currency*/ NULL AS "AlternateCurrency",
     gl_balances.CURRENCY_CODE AS "AccountCurrency",
     to_char(last_day(add_months(sysdate,-1)),'MM/DD/YYYY') "Period End Date",
    /*Insert Field for Reporting Currency Balance*/ NULL "GL Reporting Balance",
    /*Insert Field for Functional Currency Balance*/ NULL "GL Alternate Balance",
    SUM((gl_balances.BEGIN_BALANCE_DR + gl_balances.PERIOD_NET_DR - gl_balances.BEGIN_BALANCE_CR - gl_balances.PERIOD_NET_CR)) "GL Account Balance"
FROM 
    GL.GL_BALANCES gl_balances,
    GL.GL_CODE_COMBINATIONS gl_combos,
    GL.gl_ledgers gl_books,
    APPLSYS.FND_FLEX_VALUES valu,
    APPLSYS.FND_FLEX_VALUES_TL valu_tl
WHERE gl_balances.CODE_COMBINATION_ID = gl_combos.CODE_COMBINATION_ID
    AND gl_combos.SUMMARY_FLAG = 'N' 
    AND gl_combos.SEGMENT3 BETWEEN '000000' AND '399999'
    AND valu.FLEX_VALUE_SET_ID = '1016917' --GL_COA_PRODUCT   --'1009651' 
    AND valu.FLEX_VALUE_ID = valu_tl.FLEX_VALUE_ID 
    AND gl_combos.SEGMENT4 = valu.FLEX_VALUE
    and gl_balances.ledger_id = gl_books.ledger_id 
 -- Taraj update on 6/11/18 - Switz, Denm and IA-2 is added
    AND gl_combos.segment1 IN ('300','350', '400','430','460','440','450','480', '720','740', '900', '801', '802', '141')-- for all local companies with local curr only 
    AND gl_combos.segment3 NOT LIKE ('00%')
    AND gl_balances.PERIOD_NAME = to_char((last_day(add_months(sysdate,-1))),'MON-YY')
 -- Remove hard coding and added below condition since Switz ledger contains DKK JEs and vice-versa...Taraj on 06/11/18 
    AND gl_books.CURRENCY_CODE = gl_balances.CURRENCY_CODE
    --AND gl_balances.CURRENCY_CODE IN ('TRY', 'MXN', 'CNY', 'DKK', 'CHF')
   -- AND gl_books.LEDGER_ID NOT IN (6001, 16001, 17001, 18001, 19002, 21002) -- Excluding STAT Ledgers to fix Tk petty cash and Intercompany accounts issue, by Taraj on 12/21/16 
    AND gl_books.LEDGER_ID IN (5002, 9001, 12001, 15001,19001, 21001,  23103, 23143)-- all non-us ledgers
    AND gl_balances.ACTUAL_FLAG = 'A'
    AND valu_tl.language='US'
GROUP BY
   -- gl_balances.CODE_COMBINATION_ID,   
   -- gl_combos.SEGMENT1||'.'||gl_combos.SEGMENT2||'.'||gl_combos.SEGMENT3||'.'||gl_combos.SEGMENT4||'.'||gl_combos.SEGMENT5||'.'||gl_combos.SEGMENT6,
    valu_tl.language,
        gl_combos.SEGMENT1,gl_combos.SEGMENT3,gl_combos.SEGMENT5,valu.FLEX_VALUE_SET_ID,
    APPS.XXTPI_GET_ACCOUNT_DESC_F ('ONE_SEGMENT',gl_balances.LEDGER_ID,NULL,'SEGMENT3',gl_combos.segment3,'US',NULL),
    DECODE (gl_combos.ACCOUNT_TYPE, 'A','Asset','L', 'Liability', 'O', 'Equity', 'R', 'Revenue', 'E', 'Expense', NULL),
  -- DECODE ((ABS(gl_balances.PERIOD_NET_CR) + ABS(gl_balances.PERIOD_NET_DR)), 0, 'FALSE', 'TRUE'),
    gl_balances.CURRENCY_CODE,
    TRUNC (LAST_DAY (ADD_MONTHS (SYSDATE, -1)))      
UNION ALL
--For China-LLC company only since co-71 SOB is different
SELECT --gl_balances.CODE_COMBINATION_ID, 
  --  gl_combos.SEGMENT1||'.'||gl_combos.SEGMENT2||'.'||gl_combos.SEGMENT3||'.'||gl_combos.SEGMENT4||'.'||gl_combos.SEGMENT5||'.'||gl_combos.SEGMENT6 all_segment,
  gl_combos.SEGMENT1 "Entity Unique Identifier",
         gl_combos.SEGMENT3 "Account Number",
         gl_combos.SEGMENT5 "Intercompany",
         NULL "Key4",
         NULL "Key5",
         NULL "Key6",
         NULL "Key7",
         NULL "Key8",
         NULL "Key9",
         NULL "Key10",
    APPS.XXTPI_GET_ACCOUNT_DESC_F ('ONE_SEGMENT',gl_balances.LEDGER_ID,NULL,'SEGMENT3',gl_combos.segment3,'US',NULL) "Account Description",
    NULL AS "AccountReference",
    'A',
    DECODE (gl_combos.ACCOUNT_TYPE, 'A','Asset','L', 'Liability', 'O', 'Equity', 'R', 'Revenue', 'E', 'Expense', NULL) "Account Type",
    'TRUE' AS "Active Account",
    'FALSE' AS "Activity InPeriod",
    /*Insert Field for Functional Currency*/ NULL AS "AlternateCurrency",
    gl_balances.CURRENCY_CODE AS "AccountCurrency",
    to_char(last_day(add_months(sysdate,-1)),'MM/DD/YYYY') "Period End Date",
    /*Insert Field for Reporting Currency Balance*/ NULL "GL Reporting Balance",
    /*Insert Field for Functional Currency Balance*/ NULL "GL Alternate Balance",
    SUM((gl_balances.BEGIN_BALANCE_DR + gl_balances.PERIOD_NET_DR - gl_balances.BEGIN_BALANCE_CR - gl_balances.PERIOD_NET_CR)) "GL Account Balance"
FROM 
    GL.GL_BALANCES gl_balances,
    GL.GL_CODE_COMBINATIONS gl_combos,
    GL.gl_ledgers gl_books,
    APPLSYS.FND_FLEX_VALUES valu,
    APPLSYS.FND_FLEX_VALUES_TL valu_tl
WHERE gl_balances.CODE_COMBINATION_ID = gl_combos.CODE_COMBINATION_ID
    AND gl_combos.SUMMARY_FLAG = 'N' 
    AND gl_combos.SEGMENT3 BETWEEN '000000' AND '399999'
    AND valu.FLEX_VALUE_SET_ID = '1016917' --GL_COA_PRODUCT   --'1009651' 
    AND valu.FLEX_VALUE_ID = valu_tl.FLEX_VALUE_ID 
    AND gl_combos.SEGMENT4 = valu.FLEX_VALUE
    and gl_balances.ledger_id = gl_books.ledger_id 
    AND gl_books.LEDGER_ID IN (5001)
    AND gl_combos.segment1 IN ('710') -- This query for co-71 only since co-71 SOB is different
    AND gl_combos.segment3 NOT LIKE ('00%')
    AND gl_books.LEDGER_ID = gl_balances.LEDGER_ID
    AND gl_balances.PERIOD_NAME = to_char((last_day(add_months(sysdate,-1))),'MON-YY')
    AND gl_balances.CURRENCY_CODE = 'USD' 
    AND gl_balances.ACTUAL_FLAG = 'A'
    AND valu_tl.language='US'
GROUP BY
   -- gl_balances.CODE_COMBINATION_ID,   
   -- gl_combos.SEGMENT1||'.'||gl_combos.SEGMENT2||'.'||gl_combos.SEGMENT3||'.'||gl_combos.SEGMENT4||'.'||gl_combos.SEGMENT5||'.'||gl_combos.SEGMENT6,
    valu_tl.language,
        gl_combos.SEGMENT1,gl_combos.SEGMENT3,gl_combos.SEGMENT5,valu.FLEX_VALUE_SET_ID,
    APPS.XXTPI_GET_ACCOUNT_DESC_F ('ONE_SEGMENT',gl_balances.LEDGER_ID,NULL,'SEGMENT3',gl_combos.segment3,'US',NULL),
    DECODE (gl_combos.ACCOUNT_TYPE, 'A','Asset','L', 'Liability', 'O', 'Equity', 'R', 'Revenue', 'E', 'Expense', NULL),
   -- DECODE ((ABS(gl_balances.PERIOD_NET_CR) + ABS(gl_balances.PERIOD_NET_DR)), 0, 'FALSE', 'TRUE'),
    gl_balances.CURRENCY_CODE,
    TRUNC (LAST_DAY (ADD_MONTHS (SYSDATE, -1)))
UNION ALL
-- For all Mexico US LLC and Elimination companies Ledgers 
SELECT   gl_combos.SEGMENT1 "Entity Unique Identifier",
         gl_combos.SEGMENT3 "Account Number",
         gl_combos.SEGMENT5 "Intercompany",
         NULL "Key4",
         NULL "Key5",
         NULL "Key6",
         NULL "Key7",
         NULL "Key8",
         NULL "Key9",
         NULL "Key10",
    APPS.XXTPI_GET_ACCOUNT_DESC_F ('ONE_SEGMENT',gl_balances.LEDGER_ID,NULL,'SEGMENT3',gl_combos.segment3,'US',NULL) "Account Description",
    NULL AS "AccountReference",
    'A',
    DECODE (gl_combos.ACCOUNT_TYPE, 'A','Asset','L', 'Liability', 'O', 'Equity', 'R', 'Revenue', 'E', 'Expense', NULL) "Account Type",
    'TRUE' AS "Active Account",
     'FALSE' AS "Activity InPeriod",
    /*Insert Field for Functional Currency*/ NULL AS "AlternateCurrency",
    gl_balances.CURRENCY_CODE AS "AccountCurrency",
     to_char(last_day(add_months(sysdate,-1)),'MM/DD/YYYY') "Period End Date",
    /*Insert Field for Reporting Currency Balance*/ NULL "GL Reporting Balance",
    /*Insert Field for Functional Currency Balance*/ NULL "GL Alternate Balance",
    SUM((gl_balances.BEGIN_BALANCE_DR + gl_balances.PERIOD_NET_DR - gl_balances.BEGIN_BALANCE_CR - gl_balances.PERIOD_NET_CR)) "GL Account Balance"
FROM 
    GL.GL_BALANCES gl_balances,
    GL.GL_CODE_COMBINATIONS gl_combos,
    GL.gl_ledgers gl_books,
    APPLSYS.FND_FLEX_VALUES valu,
    APPLSYS.FND_FLEX_VALUES_TL valu_tl
WHERE gl_balances.CODE_COMBINATION_ID = gl_combos.CODE_COMBINATION_ID
    AND gl_combos.SUMMARY_FLAG = 'N' 
    AND gl_combos.SEGMENT3 BETWEEN '000000' AND '399999'
    AND valu.FLEX_VALUE_SET_ID = '1016917' --GL_COA_PRODUCT   --'1009651' 
    AND valu.FLEX_VALUE_ID = valu_tl.FLEX_VALUE_ID 
    AND gl_combos.SEGMENT4 = valu.FLEX_VALUE
    and gl_balances.ledger_id = gl_books.ledger_id 
    AND gl_books.LEDGER_ID IN (13001)
    AND gl_combos.segment1 IN ('410','470','490','940','950', '960') -- For all Mexico US LLC and Elimination companies Ledgers 
    AND gl_combos.segment3 NOT LIKE ('00%')   
    AND gl_books.LEDGER_ID = gl_balances.LEDGER_ID
    AND gl_balances.PERIOD_NAME = to_char((last_day(add_months(sysdate,-1))),'MON-YY')
    AND gl_balances.CURRENCY_CODE = 'USD' 
    AND gl_balances.ACTUAL_FLAG = 'A'
    AND valu_tl.language='US'
GROUP BY
    valu_tl.language,
        gl_combos.SEGMENT1,gl_combos.SEGMENT3,gl_combos.SEGMENT5,valu.FLEX_VALUE_SET_ID,
    APPS.XXTPI_GET_ACCOUNT_DESC_F ('ONE_SEGMENT',gl_balances.LEDGER_ID,NULL,'SEGMENT3',gl_combos.segment3,'US',NULL),
    DECODE (gl_combos.ACCOUNT_TYPE, 'A','Asset','L', 'Liability', 'O', 'Equity', 'R', 'Revenue', 'E', 'Expense', NULL),
    gl_balances.CURRENCY_CODE,
    TRUNC (LAST_DAY (ADD_MONTHS (SYSDATE, -1)))   
UNION ALL
--for TK1-LLC, TK2-LLC Companies
SELECT gl_combos.SEGMENT1 "Entity Unique Identifier",
     gl_combos.SEGMENT3 "Account Number",
      gl_combos.SEGMENT5 "Intercompany",
     NULL,
     NULL,
     NULL,
     NULL,
     NULL,
     NULL,
     NULL,
    APPS.XXTPI_GET_ACCOUNT_DESC_F ('ONE_SEGMENT',gl_balances.LEDGER_ID,NULL,'SEGMENT3',gl_combos.segment3,'US',NULL) "Account Description",
    NULL AS "AccountReference",
    'A',
    DECODE (gl_combos.ACCOUNT_TYPE, 'A','Asset','L', 'Liability', 'O', 'Equity', 'R', 'Revenue', 'E', 'Expense', NULL) "Account Type",
    'TRUE' AS "Active Account",
     'FALSE' AS "Activity InPeriod",
    /*Insert Field for Functional Currency*/ NULL AS "AlternateCurrency",
    gl_balances.CURRENCY_CODE AS "AccountCurrency",
     to_char(last_day(add_months(sysdate,-1)),'MM/DD/YYYY') "Period End Date",
    /*Insert Field for Reporting Currency Balance*/ NULL "GL Reporting Balance",
    /*Insert Field for Functional Currency Balance*/ NULL "GL Alternate Balance",
    SUM((gl_balances.BEGIN_BALANCE_DR + gl_balances.PERIOD_NET_DR - gl_balances.BEGIN_BALANCE_CR - gl_balances.PERIOD_NET_CR)) "GL Account Balance"
FROM 
    GL.GL_BALANCES gl_balances,
    GL.GL_CODE_COMBINATIONS gl_combos,
    GL.gl_ledgers gl_books,
    APPLSYS.FND_FLEX_VALUES valu,
    APPLSYS.FND_FLEX_VALUES_TL valu_tl
WHERE gl_balances.CODE_COMBINATION_ID = gl_combos.CODE_COMBINATION_ID
    AND gl_combos.SUMMARY_FLAG = 'N' 
    AND gl_combos.SEGMENT3 BETWEEN '000000' AND '399999'
    AND valu.FLEX_VALUE_SET_ID = '1016917' --GL_COA_PRODUCT   --'1009651' 
    AND valu.FLEX_VALUE_ID = valu_tl.FLEX_VALUE_ID 
    AND gl_combos.SEGMENT4 = valu.FLEX_VALUE
    AND gl_books.LEDGER_ID IN (14001,20001)
    and gl_balances.ledger_id = gl_books.ledger_id 
    AND gl_combos.segment1 IN  ('320','370')  -- for TK1-LLC, TK2-LLC Companies
    AND gl_books.LEDGER_ID = gl_balances.LEDGER_ID
    AND gl_balances.PERIOD_NAME = to_char((last_day(add_months(sysdate,-1))),'MON-YY')
    AND gl_balances.CURRENCY_CODE = 'USD' 
    AND gl_balances.ACTUAL_FLAG = 'A'
    AND valu_tl.language='US'
GROUP BY
    valu_tl.language,
        gl_combos.SEGMENT1,gl_combos.SEGMENT3,gl_combos.SEGMENT5,valu.FLEX_VALUE_SET_ID,
    APPS.XXTPI_GET_ACCOUNT_DESC_F ('ONE_SEGMENT',gl_balances.LEDGER_ID,NULL,'SEGMENT3',gl_combos.segment3,'US',NULL),
    DECODE (gl_combos.ACCOUNT_TYPE, 'A','Asset','L', 'Liability', 'O', 'Equity', 'R', 'Revenue', 'E', 'Expense', NULL),
    gl_balances.CURRENCY_CODE,
    TRUNC (LAST_DAY (ADD_MONTHS (SYSDATE, -1)))
ORDER BY  1,2, 3;

exit
