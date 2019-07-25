PATH=$PATH:$HOME/bin:.; export PATH
unset USERNAME
unset LD_ASSUME_KERNEL
. /orashared/TPIPROD/scripts/param.sh
/orashared/TPIPROD/oraprd/bash_profile
. /home/applprd/inst_top/apps/TPIPROD_azcs-p-ebsapp1/ora/10.1.3/TPIPROD_azcs-p-ebsapp1.env

ORA_NLS10=/u01/app/TPIPROD/apps/tech_st/10.1.3/nls/data/9idata; export ORA_NLS10
unset LD_ASSUME_KERNEL
PATH=/usr/bin:/u01/app/TPIPROD/apps/tech_st/10.1.3/bin:/u01/app/TPIPROD/apps/tech_st/10.1.3/bin:/usr/bin:/usr/sbin:/u01/app/TPIPROD/apps/tech_st/10.1.3/jdk/jre/bin:/bin:/usr/bin/X11:/usr/local/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/oraprd/.local/bin:/home/oraprd/bin:.; export PATH
unset NLS_LANG

/u01/app/TPIPROD/apps/apps_st/appl/xxtpi/12.0.0/blackline/data/BL_AP_COA.sh 
/u01/app/TPIPROD/apps/apps_st/appl/xxtpi/12.0.0/blackline/data/BL_currency_COA.sh 
/u01/app/TPIPROD/apps/apps_st/appl/xxtpi/12.0.0/blackline/data/BL_GL_COA.sh
/u01/app/TPIPROD/apps/apps_st/appl/xxtpi/12.0.0/blackline/data/BL_AR_COA.sh
