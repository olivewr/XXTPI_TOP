SELECT  gl_combos.SEGMENT1 "Entity Unique Identifier",
         gl_combos.SEGMENT3 "Account Number",
         NULL "Key3",
         NULL "Key4",
         NULL "Key5",
         NULL "Key6",
         NULL "Key7",
         NULL "Key8",
         NULL "Key9",
         NULL "Key10",
  to_char(last_day(add_months(sysdate,-1)),'MM/DD/YYYY') "Period End Date",
        NULL "SL Reporting Balance",
        NULL "SL Alternate Balance",
  (SUM(ap_balances.ACCOUNTED_DR) - SUM(ap_balances.ACCOUNTED_CR)) "Subledger Account Balance"
FROM APPS.AP_LIABILITY_BALANCE ap_balances,
  GL.GL_CODE_COMBINATIONS gl_combos,
  GL.GL_LEDGERS gl_books
WHERE 1=1
  AND ap_balances.CODE_COMBINATION_ID = gl_combos.CODE_COMBINATION_ID
  and gl_combos.segment1 NOT IN ('10','00', '50', '51','52','73','31','36','75','42')
   AND gl_combos.SEGMENT3 BETWEEN '00000' AND '39999'
  --AND (gl_combos.SEGMENT6 = '20010' OR gl_combos.SEGMENT6 = '20110')
  --AND gl_books.NAME = 'TPI_CN_RMB' 
  AND gl_books.LEDGER_ID = ap_balances.SET_OF_BOOKS_ID
  AND ap_balances.accounting_date <= TO_CHAR(last_day(add_months(sysdate,-1)), 'DD-MON-YYYY')
GROUP BY gl_combos.SEGMENT1,
  gl_combos.SEGMENT6,
  gl_combos.SEGMENT2,
  gl_combos.SEGMENT3,
  gl_combos.SEGMENT4,
  gl_combos.SEGMENT7
ORDER BY gl_combos.SEGMENT1,
  gl_combos.SEGMENT6,
  gl_combos.SEGMENT2,
  gl_combos.SEGMENT3,
  gl_combos.SEGMENT4,
  gl_combos.SEGMENT7;
