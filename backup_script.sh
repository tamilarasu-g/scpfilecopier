#!/bin/bash

###
# variables that  M U S T  be VERIFIED
###
DestHost=labfiler1.base.loc
DestDir="backupinbox"

###
# Backup source. For folders not at root level,
# enter the path (ex.: /var/named/ should be entered as  var/named ).
###
SRC[1]="etc"
SRC[2]="root"
#SRC[3]="var/named"   # Translates to /var/named/.
#SRC[4]="data"

###
# variables
###
HourStart=$(date +"%Y-%m-%d--%H")   # For naming backup .tar.gz and for dir holding them
DayStart=$(date +"%Y-%m-%d")   # For dir to be created on backup storage accepting incoming .tar.gz
NowHour=$HourStart
NowDay=$DayStart

Login=backupuser


###
# script
###
# create time stamped dir and copy them to the backup server. This dir will contain all backups from 1 particular day.
/bin/mkdir -p /tmp/`hostname -s`/$NowDay
/bin/chmod -R 770 /tmp/`hostname -s`/$NowDay

/usr/bin/rsync -ave "ssh -i /root/.ssh/id_rsa_`hostname -s`_backupclient" /tmp/`hostname -s`/$NowDay $Login@$DestHost:/$DestDir/`hostname -s`

#rsync over files
for i in "${SRC[@]}"
do
        [ "$(ls -A /$i)" ] && x=`echo $i | tr / -`; /bin/tar -czf /tmp/$x--$NowHour.tar.gz /$i 2>/dev/null;\
        /usr/bin/rsync -ave "ssh -i /root/.ssh/id_rsa_`hostname -s`_backupclient" --delete /tmp/$x--$NowHour.tar.gz $Login@$DestHost:/$DestDir/`hostname -s`/$NowDay/ 2>/dev/null;\
        rm /tmp/$x--$NowHour.tar.gz 2>/dev/null

#        [ "$(ls -A /$i)" ] && x=`echo $i | tr / -`; /bin/tar -czf /tmp/$x--$NowHour.tar.gz --use-compress-program='gzip -9' /$i 2>/dev/null;\
#        /usr/bin/rsync -ave "ssh -i /root/.ssh/id_rsa_`hostname -s`_backupclient" --delete /tmp/$x--$NowHour.tar.gz $Login@$DestHost:/$DestDir/`hostname -s`/$NowDay/ 2>/dev/null;\
#        rm /tmp/$x--$NowHour.tar.gz 2>/dev/null
done

# rsync files that do not need datestamp
# /usr/bin/rsync -ave "ssh -i /root/.ssh/id_rsa_`hostname -s`_backupclient" --delete /data/www/yumrepo $Login@$DestHost:/$DestDir/`hostname -s`/

# clean up
rm -rf /tmp/`hostname -s`

exit 0