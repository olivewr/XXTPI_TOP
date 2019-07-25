set lines 200

SELECT seg1 "Entity Unique Identifier",
       seg3 "Account Number",
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
       sum(sab) "Subledger Account Balance"
       from (
SELECT segment1 seg1,
       segment3 seg3,
       NULL "Key3",
       NULL "Key4",
       NULL "Key5",
       NULL "Key6",
       NULL "Key7",
       NULL "Key8",
       NULL "Key9",
       NULL "Key10",
       to_char(last_day(add_months(sysdate,-1)),'MM/DD/YYYY') ped,
       NULL "SL Reporting Balance",
       NULL "SL Alternate Balance",
       sum(fuctional_outstanding_balance) sab
       from (
select bill_party.party_name customer_name,
    rat.trx_number,
    rat.TRX_DATE,
    gcc.segment1,
    to_char(last_day(add_months(sysdate,-1)),'MM/DD/YYYY') "Period End Date",
    gcc.segment3,
    gld.gl_date,
    amount orj_amount,
    (select nvl(sum(decode(status,'APP',-1*(nvl(amount,0)+nvl(discount,0)),(nvl(amount,0)+nvl(discount,0)))),0) from AR_APP_ADJ_V where  CUSTOMER_TRX_ID=gld.CUSTOMER_TRX_ID and Status_meaning<>'Waiting Approval' and decode(class,'Adjustment',last_day(add_months(sysdate,-1))-1,gl_date)<=last_day(add_months(sysdate,-1))) orj_applied_amount,
    NVL(amount,0) + (select nvl(sum(decode(status,'APP',-1*(nvl(amount,0)+nvl(discount,0)),(nvl(amount,0)+nvl(discount,0)))),0) from AR_APP_ADJ_V where  CUSTOMER_TRX_ID=gld.CUSTOMER_TRX_ID and Status_meaning<>'Waiting Approval' and decode(class,'Adjustment',last_day(add_months(sysdate,-1))-1,gl_date)<=last_day(add_months(sysdate,-1))) Orj_outstanding_balance,
    round((amount + (select nvl(sum(decode(status,'APP',-1*(nvl(amount,0)+nvl(discount,0)),(nvl(amount,0)+nvl(discount,0)))),0) from AR_APP_ADJ_V where  CUSTOMER_TRX_ID=gld.CUSTOMER_TRX_ID and Status_meaning<>'Waiting Approval' and decode(class,'Adjustment',last_day(add_months(sysdate,-1))-1,gl_date)<=last_day(add_months(sysdate,-1)))) * nvl(rat.exchange_rate,1),2) fuctional_outstanding_balance
    ,rat.customer_trx_id
    from  ra_customer_trx rat,
          ra_cust_trx_line_gl_dist       gld,
          gl_code_combinations_kfv gcc,
          hz_cust_accounts bill_cus,
          hz_parties bill_party,
          HZ_CUST_SITE_USES_ALL hcs_bill,
          HZ_CUST_ACCT_SITES_ALL hca_bill,
          hz_party_sites hps_bill,
          hz_locations hl_bill
      where  1=1
AND rat.bill_to_customer_id   =bill_cus.cust_account_id
AND bill_party.party_id       =bill_cus.party_id
AND rat.bill_to_site_use_id   =hcs_bill.site_use_id
AND hcs_bill.site_use_code    ='BILL_TO'
AND hca_bill.cust_acct_site_id=hcs_bill.cust_acct_site_id
AND hps_bill.party_site_id    =hca_bill.party_site_id
AND hl_bill.location_id       =hps_bill.location_id
      and    rat.customer_trx_id=gld.customer_trx_id
      and     gld.code_combination_id=gcc.code_combination_id
     -- and     rat.BILL_TO_CUSTOMER_ID = cust.CUSTOMER_ID      
      and    gld.gl_date<= last_day(add_months(sysdate,-1))
      and    gld.account_class in ('REC')
      and    gld.latest_rec_flag  = 'Y'
      and    gld.org_id in (103, 162, 164, 166, 168, 170, 183, 184, 282, 342, 382, 383, 422,442, 481, 542, 562, 582, 585)
     and rat.complete_flag='Y'
     and rat.TRX_NUMBER <> '15646'
     and gcc.segment1 not in ('10')
     and gcc.segment3 not in ('201100')
) where Orj_outstanding_balance<>0
group by SEGMENT1, SEGMENT3
UNION
SELECT segment1 seg1,
       segment3 seg3,
       NULL "Key3",
       NULL "Key4",
       NULL "Key5",
       NULL "Key6",
       NULL "Key7",
       NULL "Key8",
       NULL "Key9",
       NULL "Key10",
       to_char(last_day(add_months(sysdate,-1)),'MM/DD/YYYY') ped,
       NULL "SL Reporting Balance",
       NULL "SL Alternate Balance",
       sum(amount_dr)-sum(amount_cr)  sab
       from (
           -- sum(amount_dr)-sum(amount_cr) Diff from (
  select
    cr.CUSTOMER_NAME,
    cr.CUSTOMER_NUMBER,
   -- f.TRX_NUMBER,
    cr.RECEIPT_NUMBER,
    f.TRX_DATE,
    gl.segment1,
    to_char(last_day(add_months(sysdate,-1)),'MM/DD/YYYY') Period_End_Date,
    gl.segment3,
    rap.GL_DATE,
    gl.CONCATENATED_SEGMENTS,
    NVL (amount_dr, 0) "AMOUNT_DR",
          NVL (amount_cr, 0) "AMOUNT_CR",
          NVL (acctd_amount_dr, 0) "ACCTD_AMOUNT_DR",
          NVL (acctd_amount_cr, 0) "ACCTD_AMOUNT_CR",
          DECODE (rap.POSTING_CONTROL_ID, -3, 'N', 'Y') "POSTED",
          cr.CASH_RECEIPT_ID
          --ard.*
  FROM ar_cash_receipts_v cr,
          ar_receivable_applications_all rap,
          gl_code_combinations_kfv gl,
          ar_distributions_all ard,
          ra_customer_trx f
    -- , ra_cust_trx_types tip
    WHERE     cr.CASH_RECEIPT_ID = rap.CASH_RECEIPT_ID
          --AND rap.CODE_COMBINATION_ID = gl.CODE_COMBINATION_ID
          AND ard.CODE_COMBINATION_ID = gl.CODE_COMBINATION_ID                                                     --08.10.2009 IU
          AND rap.RECEIVABLE_APPLICATION_ID = ard.SOURCE_ID
          AND rap.APPLIED_CUSTOMER_TRX_ID = f.CUSTOMER_TRX_ID(+)
          AND source_table = 'RA'
          AND source_type NOT IN ('EXCH_GAIN', 'EXCH_LOSS')
          AND ard.source_type <> 'EDISC'
          AND cr.RECEIPT_STATUS = 'UNAPP'
          AND rap.GL_DATE <= last_day(add_months(sysdate,-1))
         -- and cr.CASH_RECEIPT_ID =66095
          AND GL.SEGMENT3 = 111970
          --AND GL.SEGMENT1 = 11     
          and gl.segment1 not in ('10')    
          )
group by SEGMENT1, SEGMENT3
union
SELECT segment1 seg1,
       segment3 seg3,
       NULL "Key3",
       NULL "Key4",
       NULL "Key5",
       NULL "Key6",
       NULL "Key7",
       NULL "Key8",
       NULL "Key9",
       NULL "Key10",
       to_char(last_day(add_months(sysdate,-1)),'MM/DD/YYYY') ped,
       NULL "SL Reporting Balance",
       NULL "SL Alternate Balance",
       sum(fuctional_outstanding_balance) sab
       from (
select bill_party.party_name customer_name,
    rat.trx_number,
    rat.TRX_DATE,
    gcc.segment1,
    to_char(last_day(add_months(sysdate,-1)),'MM/DD/YYYY') "Period End Date",
    gcc.segment3,
    gld.gl_date,
    amount orj_amount,
    (select nvl(sum(decode(status,'APP',-1*(nvl(amount,0)+nvl(discount,0)),(nvl(amount,0)+nvl(discount,0)))),0) from AR_APP_ADJ_V where  CUSTOMER_TRX_ID=gld.CUSTOMER_TRX_ID and Status_meaning<>'Waiting Approval' and decode(class,'Adjustment',last_day(add_months(sysdate,-1))-1,gl_date)<=last_day(add_months(sysdate,-1))) orj_applied_amount,
    NVL(amount,0) + (select nvl(sum(decode(status,'APP',-1*(nvl(amount,0)+nvl(discount,0)),(nvl(amount,0)+nvl(discount,0)))),0) from AR_APP_ADJ_V where  CUSTOMER_TRX_ID=gld.CUSTOMER_TRX_ID and Status_meaning<>'Waiting Approval' and decode(class,'Adjustment',last_day(add_months(sysdate,-1))-1,gl_date)<=last_day(add_months(sysdate,-1))) Orj_outstanding_balance,
    round((amount ) * nvl(rat.exchange_rate,1),2) fuctional_outstanding_balance
    ,rat.customer_trx_id
    from  ra_customer_trx_all rat,
             ra_cust_trx_line_gl_dist       gld,
             gl_code_combinations_kfv gcc,
          hz_cust_accounts bill_cus,
          hz_parties bill_party,
          HZ_CUST_SITE_USES_ALL hcs_bill,
          HZ_CUST_ACCT_SITES_ALL hca_bill,
          hz_party_sites hps_bill,
          hz_locations hl_bill
      where  1=1
AND rat.bill_to_customer_id   =bill_cus.cust_account_id
AND bill_party.party_id       =bill_cus.party_id
AND rat.bill_to_site_use_id   =hcs_bill.site_use_id
AND hcs_bill.site_use_code    ='BILL_TO'
AND hca_bill.cust_acct_site_id=hcs_bill.cust_acct_site_id
AND hps_bill.party_site_id    =hca_bill.party_site_id
AND hl_bill.location_id       =hps_bill.location_id
      and    rat.customer_trx_id=gld.customer_trx_id
      and     gld.code_combination_id=gcc.code_combination_id
     -- and     rat.BILL_TO_CUSTOMER_ID = cust.CUSTOMER_ID      
      and    gld.gl_date<= last_day(add_months(sysdate,-1))
      and    gld.account_class in ('REC')
      and    gld.latest_rec_flag  = 'Y'
      and    gld.org_id in (103, 162, 164, 166, 168, 170, 183, 184, 282, 342, 382, 383, 422,442, 481, 542, 562, 582, 585)
     and rat.complete_flag='Y'
     and rat.TRX_NUMBER = '27405'--'27547'
     and gcc.segment1 not in ('10')
) where 1=1
group by SEGMENT1, SEGMENT3)
group by seg1,seg3
ORDER BY 1,2;

exit;

