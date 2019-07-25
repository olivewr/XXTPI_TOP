PATH=$PATH:$HOME/bin:.; export PATH
unset USERNAME
unset LD_ASSUME_KERNEL
. /u10/programs/monitor/bin/param.ksh
. /home/oraprd/.bash_profile
. /u03/app/oraprod/11.1.0/TPIPROD_marvin.env

ORA_NLS10=/u03/app/oraprod/11.1.0/nls/data; export ORA_NLS10
unset LD_ASSUME_KERNEL
PATH=/usr/bin:/u03/app/oraprod/11.1.0/perl/bin:/u03/app/oraprod/11.1.0/Apache/perl/bin:/u03/app/oraprod/11.1.0/bin:/usr/bin:/usr/sbin:/u03/app/oraprod/11.1.0/jre/1.4.2/bin:/usr/ccs/bin:/bin:/usr/bin/X11:/usr/local/bin:/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin:/usr/X11R6/bin:/u03/app/oraprod/11.1.0/OPatch:.; export PATH
unset NLS_LANG

/u03/app/applprod/11.5.10/tpiprodappl/xxtpi/11.5.0/blackline/data/BL_AP_V2.sh 
/u03/app/applprod/11.5.10/tpiprodappl/xxtpi/11.5.0/blackline/data/BL_currency_V2.sh 
/u03/app/applprod/11.5.10/tpiprodappl/xxtpi/11.5.0/blackline/data/BL_GL_V2.sh
/u03/app/applprod/11.5.10/tpiprodappl/xxtpi/11.5.0/blackline/data/SUB_AR_extract.sh
