PATH=$PATH:$HOME/bin:.; export PATH
unset USERNAME
unset LD_ASSUME_KERNEL
. /u03/programs/monitor/bin/param.sh
. /home/oraprd/.bash_profile
. /u02/app/TPIPROD/db/tech_st/11.2.0.4/TPIPROD_mork.env

ORA_NLS10=/u02/app/TPIPROD/db/tech_st/11.2.0.4/nls/data; export ORA_NLS10
unset LD_ASSUME_KERNEL
PATH=/usr/bin:/u02/app/TPIPROD/db/tech_st/11.2.0.4/perl/bin:/u02/app/TPIPROD/db/tech_st/11.2.0.4/Apache/perl/bin:/u02/app/TPIPROD/db/tech_st/11.2.0.4/bin:/usr/bin:/usr/sbin:/u02/app/TPIPROD/db/tech_st/11.2.0.4/jre/1.4.2/bin:/usr/ccs/bin:/bin:/usr/bin/X11:/usr/local/bin:/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin:/usr/X11R6/bin:/u02/app/TPIPROD/db/tech_st/11.2.0.4/OPatch:.; export PATH
unset NLS_LANG

/u02/app/TPIPROD/apps/apps_st/appl/xxtpi/12.0.0/blackline/data/BL_AP_COA.sh 
/u02/app/TPIPROD/apps/apps_st/appl/xxtpi/12.0.0/blackline/data/BL_currency_COA.sh 
/u02/app/TPIPROD/apps/apps_st/appl/xxtpi/12.0.0/blackline/data/BL_GL_COA.sh
/u02/app/TPIPROD/apps/apps_st/appl/xxtpi/12.0.0/blackline/data/BL_AR_COA.sh
