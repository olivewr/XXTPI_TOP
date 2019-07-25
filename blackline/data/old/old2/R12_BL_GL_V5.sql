-- Created by Taraj Khan
-- Purpose: Send this GL data to blackline ftp server from where it gets loaded into blackline system (Daily process)
-- Version 1: Query modified on 12-31-2015 
-- for US and ARM Company only
SELECT --gl_balances.CODE_COMBINATION_ID, 
   -- gl_combos.SEGMENT1||'.'||gl_combos.SEGMENT2||'.'||gl_combos.SEGMENT3||'.'||gl_combos.SEGMENT4||'.'||gl_combos.SEGMENT5||'.'||gl_combos.SEGMENT6 all_segment,
    gl_combos.SEGMENT1 "Entity Unique Identifier",
    gl_combos.SEGMENT3 "Account Number",
  --  valu.FLEX_VALUE_SET_ID,
  --  valu_tl.language,
    /*Insert Optional Segment Fields*/ NULL,
    /*Insert Optional Segment Fields*/ NULL,
    /*Insert Optional Segment Fields*/ NULL,
    /*Insert Optional Segment Fields*/ NULL,
    /*Insert Optional Segment Fields*/ NULL,
    /*Insert Optional Segment Fields*/ NULL,
    /*Insert Optional Segment Fields*/ NULL,
    /*Insert Optional Segment Fields*/ NULL,
   -- valu_tl.DESCRIPTION,*/
    APPS.XXTPI_GET_ACCOUNT_DESC_F ('ONE_SEGMENT',gl_balances.LEDGER_ID,NULL,'SEGMENT3',gl_combos.segment3,'US',NULL) "Account Description",
    NULL AS "AccountReference",
    'A',
    DECODE (gl_combos.ACCOUNT_TYPE, 'A','Asset','L', 'Liability', 'O', 'Equity', 'R', 'Revenue', 'E', 'Expense', NULL) "Account Type",
    'TRUE' AS "Active Account",
    'FALSE' AS "Activity InPeriod",
   -- DECODE ((ABS(gl_balances.PERIOD_NET_CR) + ABS(gl_balances.PERIOD_NET_DR)), 0, 'FALSE', 'TRUE') AS "Activity InPeriod",
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
    AND gl_combos.SEGMENT3 BETWEEN '00000' AND '39999'
    AND valu.FLEX_VALUE_SET_ID = '1009653' --GL_COA_PRODUCT   --'1009651' 
    AND valu.FLEX_VALUE_ID = valu_tl.FLEX_VALUE_ID 
    AND gl_combos.SEGMENT6 = valu.FLEX_VALUE
    AND gl_books.LEDGER_ID IN  (4001, 8001)
    AND gl_combos.segment1 IN ( '11', '12','13','14','15','20')-- for US and ARM co only
    AND gl_combos.segment1 NOT IN ('10','00', '50', '51','52','73','31','75','42', '30', '40','90','72','74')
    AND gl_books.LEDGER_ID = gl_balances.LEDGER_ID
    AND gl_balances.PERIOD_NAME = to_char((last_day(add_months(sysdate,-1))),'MON-YY')
    AND gl_balances.CURRENCY_CODE = 'USD' 
    AND gl_balances.ACTUAL_FLAG = 'A'
    AND valu_tl.language='US'
GROUP BY
   -- gl_balances.CODE_COMBINATION_ID,   
   -- gl_combos.SEGMENT1||'.'||gl_combos.SEGMENT2||'.'||gl_combos.SEGMENT3||'.'||gl_combos.SEGMENT4||'.'||gl_combos.SEGMENT5||'.'||gl_combos.SEGMENT6,
    valu_tl.language,
        gl_combos.SEGMENT1,gl_combos.SEGMENT3,valu.FLEX_VALUE_SET_ID,
    APPS.XXTPI_GET_ACCOUNT_DESC_F ('ONE_SEGMENT',gl_balances.LEDGER_ID,NULL,'SEGMENT3',gl_combos.segment3,'US',NULL),
    DECODE (gl_combos.ACCOUNT_TYPE, 'A','Asset','L', 'Liability', 'O', 'Equity', 'R', 'Revenue', 'E', 'Expense', NULL),
  -- DECODE ((ABS(gl_balances.PERIOD_NET_CR) + ABS(gl_balances.PERIOD_NET_DR)), 0, 'FALSE', 'TRUE'),
    gl_balances.CURRENCY_CODE,
    TRUNC (LAST_DAY (ADD_MONTHS (SYSDATE, -1)))    
UNION ALL
--for local companies with local curr only
SELECT --gl_balances.CODE_COMBINATION_ID, 
   -- gl_combos.SEGMENT1||'.'||gl_combos.SEGMENT2||'.'||gl_combos.SEGMENT3||'.'||gl_combos.SEGMENT4||'.'||gl_combos.SEGMENT5||'.'||gl_combos.SEGMENT6 all_segment,
    gl_combos.SEGMENT1 "Entity Unique Identifier",
    gl_combos.SEGMENT3 "Account Number",
    /*Insert Optional Segment Fields*/ NULL,
    /*Insert Optional Segment Fields*/ NULL,
    /*Insert Optional Segment Fields*/ NULL,
    /*Insert Optional Segment Fields*/ NULL,
    /*Insert Optional Segment Fields*/ NULL,
    /*Insert Optional Segment Fields*/ NULL,
    /*Insert Optional Segment Fields*/ NULL,
    /*Insert Optional Segment Fields*/ NULL,
   -- valu_tl.DESCRIPTION,*/
    APPS.XXTPI_GET_ACCOUNT_DESC_F ('ONE_SEGMENT',gl_balances.LEDGER_ID,NULL,'SEGMENT3',gl_combos.segment3,'US',NULL) "Account Description",
    NULL AS "AccountReference",
    'A',
    DECODE (gl_combos.ACCOUNT_TYPE, 'A','Asset','L', 'Liability', 'O', 'Equity', 'R', 'Revenue', 'E', 'Expense', NULL) "Account Type",
    'TRUE' AS "Active Account",
    'FALSE' AS "Activity InPeriod",
   -- DECODE ((ABS(gl_balances.PERIOD_NET_CR) + ABS(gl_balances.PERIOD_NET_DR)), 0, 'FALSE', 'TRUE') AS "Activity InPeriod",
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
    AND gl_combos.SEGMENT3 BETWEEN '00000' AND '39999'
    AND valu.FLEX_VALUE_SET_ID = '1009653' --GL_COA_PRODUCT   --'1009651' 
    AND valu.FLEX_VALUE_ID = valu_tl.FLEX_VALUE_ID 
    AND gl_combos.SEGMENT6 = valu.FLEX_VALUE
    AND gl_combos.segment1 IN ('30','35', '40','43','44','45', '72','74','90')-- for local co with local curr only, add mx-2 companies 
    AND gl_books.LEDGER_ID = gl_balances.LEDGER_ID
    AND gl_balances.PERIOD_NAME = to_char((last_day(add_months(sysdate,-1))),'MON-YY')
    AND gl_balances.CURRENCY_CODE IN ('TRY', 'MXN', 'CNY')
    AND gl_books.LEDGER_ID IN (9001, 12001, 5002, 15001,19001 )
    AND gl_balances.ACTUAL_FLAG = 'A'
    AND valu_tl.language='US'
GROUP BY
   -- gl_balances.CODE_COMBINATION_ID,   
   -- gl_combos.SEGMENT1||'.'||gl_combos.SEGMENT2||'.'||gl_combos.SEGMENT3||'.'||gl_combos.SEGMENT4||'.'||gl_combos.SEGMENT5||'.'||gl_combos.SEGMENT6,
    valu_tl.language,
        gl_combos.SEGMENT1,gl_combos.SEGMENT3,valu.FLEX_VALUE_SET_ID,
    APPS.XXTPI_GET_ACCOUNT_DESC_F ('ONE_SEGMENT',gl_balances.LEDGER_ID,NULL,'SEGMENT3',gl_combos.segment3,'US',NULL),
    DECODE (gl_combos.ACCOUNT_TYPE, 'A','Asset','L', 'Liability', 'O', 'Equity', 'R', 'Revenue', 'E', 'Expense', NULL),
  -- DECODE ((ABS(gl_balances.PERIOD_NET_CR) + ABS(gl_balances.PERIOD_NET_DR)), 0, 'FALSE', 'TRUE'),
    gl_balances.CURRENCY_CODE,
    TRUNC (LAST_DAY (ADD_MONTHS (SYSDATE, -1)))    
UNION ALL
--for co-71 only since co-71 SOB is different
SELECT --gl_balances.CODE_COMBINATION_ID, 
  --  gl_combos.SEGMENT1||'.'||gl_combos.SEGMENT2||'.'||gl_combos.SEGMENT3||'.'||gl_combos.SEGMENT4||'.'||gl_combos.SEGMENT5||'.'||gl_combos.SEGMENT6 all_segment,
    gl_combos.SEGMENT1 "Entity Unique Identifier",
    gl_combos.SEGMENT3 "Account Number",
    /*Insert Optional Segment Fields*/ NULL,
    /*Insert Optional Segment Fields*/ NULL,
    /*Insert Optional Segment Fields*/ NULL,
    /*Insert Optional Segment Fields*/ NULL,
    /*Insert Optional Segment Fields*/ NULL,
    /*Insert Optional Segment Fields*/ NULL,
    /*Insert Optional Segment Fields*/ NULL,
    /*Insert Optional Segment Fields*/ NULL,
   -- valu_tl.DESCRIPTION,*/
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
    AND gl_combos.SEGMENT3 BETWEEN '00000' AND '39999'
    AND valu.FLEX_VALUE_SET_ID = '1009653' --GL_COA_PRODUCT   --'1009651' 
    AND valu.FLEX_VALUE_ID = valu_tl.FLEX_VALUE_ID 
    AND gl_combos.SEGMENT6 = valu.FLEX_VALUE
    AND gl_books.LEDGER_ID IN (5001)
    AND gl_combos.segment1 IN ('71') -- This query for co-71 only since co-71 SOB is different
    AND gl_books.LEDGER_ID = gl_balances.LEDGER_ID
    AND gl_balances.PERIOD_NAME = to_char((last_day(add_months(sysdate,-1))),'MON-YY')
    AND gl_balances.CURRENCY_CODE = 'USD' 
    AND gl_balances.ACTUAL_FLAG = 'A'
    AND valu_tl.language='US'
GROUP BY
   -- gl_balances.CODE_COMBINATION_ID,   
   -- gl_combos.SEGMENT1||'.'||gl_combos.SEGMENT2||'.'||gl_combos.SEGMENT3||'.'||gl_combos.SEGMENT4||'.'||gl_combos.SEGMENT5||'.'||gl_combos.SEGMENT6,
    valu_tl.language,
        gl_combos.SEGMENT1,gl_combos.SEGMENT3,valu.FLEX_VALUE_SET_ID,
    APPS.XXTPI_GET_ACCOUNT_DESC_F ('ONE_SEGMENT',gl_balances.LEDGER_ID,NULL,'SEGMENT3',gl_combos.segment3,'US',NULL),
    DECODE (gl_combos.ACCOUNT_TYPE, 'A','Asset','L', 'Liability', 'O', 'Equity', 'R', 'Revenue', 'E', 'Expense', NULL),
    DECODE ((ABS(gl_balances.PERIOD_NET_CR) + ABS(gl_balances.PERIOD_NET_DR)), 0, 'FALSE', 'TRUE'),
    gl_balances.CURRENCY_CODE,
    TRUNC (LAST_DAY (ADD_MONTHS (SYSDATE, -1)))
UNION ALL
--for co-41 only since co-41 SOB is different
SELECT gl_combos.SEGMENT1 "Entity Unique Identifier",
     gl_combos.SEGMENT3 "Account Number",
     NULL,
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
    AND gl_combos.SEGMENT3 BETWEEN '00000' AND '39999'
    AND valu.FLEX_VALUE_SET_ID = '1009653' --GL_COA_PRODUCT   --'1009651' 
    AND valu.FLEX_VALUE_ID = valu_tl.FLEX_VALUE_ID 
    AND gl_combos.SEGMENT6 = valu.FLEX_VALUE
    AND gl_books.LEDGER_ID IN (13001)
    AND gl_combos.segment1 IN ('41','47','94','95') -- All Mexico US and Elimination companies SOB's 
    AND gl_books.LEDGER_ID = gl_balances.LEDGER_ID
    AND gl_balances.PERIOD_NAME = to_char((last_day(add_months(sysdate,-1))),'MON-YY')
    AND gl_balances.CURRENCY_CODE = 'USD' 
    AND gl_balances.ACTUAL_FLAG = 'A'
    AND valu_tl.language='US'
GROUP BY
    valu_tl.language,
        gl_combos.SEGMENT1,gl_combos.SEGMENT3,valu.FLEX_VALUE_SET_ID,
    APPS.XXTPI_GET_ACCOUNT_DESC_F ('ONE_SEGMENT',gl_balances.LEDGER_ID,NULL,'SEGMENT3',gl_combos.segment3,'US',NULL),
    DECODE (gl_combos.ACCOUNT_TYPE, 'A','Asset','L', 'Liability', 'O', 'Equity', 'R', 'Revenue', 'E', 'Expense', NULL),
    gl_balances.CURRENCY_CODE,
    TRUNC (LAST_DAY (ADD_MONTHS (SYSDATE, -1)))   
UNION ALL
SELECT gl_combos.SEGMENT1 "Entity Unique Identifier",
     gl_combos.SEGMENT3 "Account Number",
     NULL,
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
    AND gl_combos.SEGMENT3 BETWEEN '00000' AND '39999'
    AND valu.FLEX_VALUE_SET_ID = '1009653' --GL_COA_PRODUCT   --'1009651' 
    AND valu.FLEX_VALUE_ID = valu_tl.FLEX_VALUE_ID 
    AND gl_combos.SEGMENT6 = valu.FLEX_VALUE
    AND gl_books.LEDGER_ID IN (14001,20001)
    AND gl_combos.segment1 IN  ('32','37')  -- for TK LLC Comp 
    AND gl_books.LEDGER_ID = gl_balances.LEDGER_ID
    AND gl_balances.PERIOD_NAME = to_char((last_day(add_months(sysdate,-1))),'MON-YY')
    AND gl_balances.CURRENCY_CODE = 'USD' 
    AND gl_balances.ACTUAL_FLAG = 'A'
    AND valu_tl.language='US'
GROUP BY
    valu_tl.language,
        gl_combos.SEGMENT1,gl_combos.SEGMENT3,valu.FLEX_VALUE_SET_ID,
    APPS.XXTPI_GET_ACCOUNT_DESC_F ('ONE_SEGMENT',gl_balances.LEDGER_ID,NULL,'SEGMENT3',gl_combos.segment3,'US',NULL),
    DECODE (gl_combos.ACCOUNT_TYPE, 'A','Asset','L', 'Liability', 'O', 'Equity', 'R', 'Revenue', 'E', 'Expense', NULL),
    gl_balances.CURRENCY_CODE,
    TRUNC (LAST_DAY (ADD_MONTHS (SYSDATE, -1)));
