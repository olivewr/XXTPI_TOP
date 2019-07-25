SET PAGESIZE 0
SET LINESIZE 2048
SET FEEDBACK OFF
 SET TRIMSPOOL ON
 SET TERMOUT OFF
set colsep '	'
set head off

SELECT --gl_balances.CODE_COMBINATION_ID,
--gl_combos.SEGMENT1||'.'||gl_combos.SEGMENT2||'.'||gl_combos.SEGMENT3||'.'||gl_combos.SEGMENT4||'.'||gl_combos.SEGMENT5||'.'||gl_combos.SEGMENT6||'.'||gl_combos.SEGMENT7||'.'||gl_combos.SEGMENT8 all_segment,
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
  to_char(last_day(add_months(sysdate,-2)),'MM/DD/YYYY') "Period End Date",
        NULL "SL Reporting Balance",
        NULL "SL Alternate Balance",
NVL(SUM(nvl(ap_balances.ACCTD_ROUNDED_DR,0)) - SUM(nvl(ap_balances.ACCTD_ROUNDED_CR,0)), 0) "Subledger Account Balance"
--NVL(SUM(ap_balances.ACCTD_ROUNDED_DR) - SUM(ap_balances.ACCTD_ROUNDED_CR), 0) "Subledger Account Balance"
FROM APPS.XLA_TRIAL_BALANCES ap_balances,
GL.GL_CODE_COMBINATIONS gl_combos,
  GL.GL_LEDGERS gl_books
WHERE 1=1
    AND ap_balances.CODE_COMBINATION_ID = gl_combos.CODE_COMBINATION_ID
    AND gl_books.LEDGER_ID IN (1001, 4001, 5001, 5002, 8001, 9001, 12001, 13001, 14001, 15001, 19001, 20001, 21001, 23103, 23143, 23201, 23221)
    AND gl_combos.SEGMENT3 BETWEEN '000000' AND '399999'
    AND gl_books.LEDGER_ID = ap_balances.ledger_id
    AND ap_balances.gl_date <= TO_CHAR(last_day(add_months(sysdate,-2)), 'DD-MON-YYYY')
GROUP BY gl_combos.SEGMENT1,
  --gl_balances.CODE_COMBINATION_ID,
--gl_combos.SEGMENT1||'.'||gl_combos.SEGMENT2||'.'||gl_combos.SEGMENT3||'.'||gl_combos.SEGMENT4||'.'||gl_combos.SEGMENT5||'.'||gl_combos.SEGMENT6||'.'||gl_combos.SEGMENT7||'.'||gl_combos.SEGMENT8,
 -- gl_combos.SEGMENT6,
--  gl_combos.SEGMENT2,
  gl_combos.SEGMENT3,
 -- gl_combos.SEGMENT4,
 -- gl_combos.SEGMENT7,
  gl_combos.SEGMENT5
ORDER BY gl_combos.SEGMENT1 desc,
  gl_combos.SEGMENT3,
  gl_combos.SEGMENT5;

exit

