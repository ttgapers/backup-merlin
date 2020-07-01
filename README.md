# backup-merlin

## Pre-requisites
1.  Currently only supports Asus routers running [Merlin firmware](https://github.com/RMerl/asuswrt-merlin.ng)
2.  Installed supported version of [NVRAM Save Restore Utility] (https://github.com/Xentrk/nvram-save-restore-utility)
3.  USB Storage
4.  JFFS Custom Scripts Enabled

## Install Example

1.  Run the installer:
	```sh
	mkdir -p /jffs/addons/schedbackup && /usr/sbin/curl -s "https://raw.githubusercontent.com/ttgapers/backup-merlin/master/backup-merlin.sh" -o "/jffs/addons/schedbackup/backup-merlin" && chmod 755 /jffs/addons/schedbackup/backup-merlin```

2.  Edit backup-merlin.sh and update BLOC to reflect USB name, and RETENTION for your chosen retention in days (default 7)

3.  Edit /jffs/script/services-start

4.  Add /jffs/addons/schedbackup/backup-merlin.sh

5.  Execute /jffs/addons/schedbackup/backup-merlin.sh OR Reboot router to only add scheduled task

## Uninstall/Remove

1.  SSH to the router and execute:

2.  Delete /jffs/addons/schedbackup folder

3.  Edit /jffs/script/services-start

4.  Remove /jffs/addons/schedbackup/backup-merlin.sh
