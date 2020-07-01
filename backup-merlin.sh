#!/bin/sh
# schedbackup.sh
# Use NSRU utility to enable scheduled backups with retention
# shellcheck disable=SC2034 # ignore msg about unused colors
# shellcheck disable=SC2016 # ignore warning about using single quotes when searcing for \` char
##################################################################################
###########################################################################################################################################
# Changelog
#------------------------------------------------
# See: https://github.com/ttgapers/backup-merlin
# Version 0.0.1			  01-July-2020
# - Initial release
# - POSIX compliant - thanks @Adamm
#------------------------------------------------

VERSION=0.0.1

UTIL=nsru
BLOC=/mnt/YOUR-usb/$UTIL
BARC=$BLOC/archive
BKUP=$BLOC/backup
RETENTION=7
CRUNAME=$UTIL

# Add to cron to run
cru l | grep $CRUNAME >/dev/null || cru a $CRUNAME "0 5 * * * $0 $*"

# Check and exit if utility is not present
if [ ! -d "$BLOC" ];
    then echo "Backup utility not found" && exit 1
fi

# Remove old backup directory if there from previous runs (aids in archiving)
if [ -d "$BKUP" ];
    then echo "Cleaning working backup directory" && rm -rf $BKUP
fi

# Create backup directory for present execution
if [ ! -d "$BKUP" ];
    then echo "Creating working backup directory" && mkdir $BKUP
fi 

# Change directory to backup utility, if not exit
cd "$BLOC" || exit

# Execute backup
$BLOC/nvram-save.sh -clk -b

# Wait before running archive/retention
sleep 30

# Move and rename backup folder
echo "Rename backup folder"
mv "$BKUP" "$BKUP.$(hostname).$(date +%Y%m%d%H%M)"
echo "Move to archive folder"
mv "$BKUP.$(hostname).$(date +%Y%m%d%H%M)" "$BARC"


# Careful here.  You do not want this running if ntp hasn't synced.
# Run retention based on policy
echo "Run retention policy of $RETENTION days"
find $BARC -name "backup.$(hostname).20*" -mtime +$RETENTION -exec rm -rf {} \;

echo "Backup job and retention complete"

exit 0