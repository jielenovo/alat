#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
MYIP=$(wget -qO- ipv4.icanhazip.com);
wshs=$(cat /usr/sbin/ldpp.conf | grep -w "wshs" | cut -d: -f2|sed 's/ //g')
wsdb=$(cat /usr/sbin/ldpp.conf | grep -w "wsdb" | cut -d: -f2|sed 's/ //g')
dhs=$(cat /usr/sbin/ldpp.conf | grep -w "dhs" | cut -d: -f2|sed 's/ //g')
ddb=$(cat /usr/sbin/ldpp.conf | grep -w "ddb" | cut -d: -f2|sed 's/ //g')
openssh=$(cat /usr/sbin/ldpp.conf | grep -w "openssh" | cut -d: -f2|sed 's/ //g')
ssh=$(cat /usr/sbin/ldpp.conf | grep -w "ssh" | cut -d: -f2|sed 's/ //g')
drop1=$(cat /usr/sbin/ldpp.conf | grep -w "drop1" | cut -d: -f2|sed 's/ //g')
drop2=$(cat /usr/sbin/ldpp.conf | grep -w "drop2" | cut -d: -f2|sed 's/ //g')
drop3=$(cat /usr/sbin/ldpp.conf | grep -w "drop3" | cut -d: -f2|sed 's/ //g')
sshssl=$(cat /usr/sbin/ldpp.conf | grep -w "sshssl" | cut -d: -f2|sed 's/ //g')
dropssl=$(cat /usr/sbin/ldpp.conf | grep -w "dropssl" | cut -d: -f2|sed 's/ //g')
vpntcp=$(cat /usr/sbin/ldpp.conf | grep -w "vpntcp" | cut -d: -f2|sed 's/ //g')
vpnudp=$(cat /usr/sbin/ldpp.conf | grep -w "vpnudp" | cut -d: -f2|sed 's/ //g')
vpnssl1=$(cat /usr/sbin/ldpp.conf | grep -w "vpnssl1" | cut -d: -f2|sed 's/ //g')
vpnssl2=$(cat /usr/sbin/ldpp.conf | grep -w "vpnssl2" | cut -d: -f2|sed 's/ //g')
squid1=$(cat /usr/sbin/ldpp.conf | grep -w "squid1" | cut -d: -f2|sed 's/ //g')
squid2=$(cat /usr/sbin/ldpp.conf | grep -w "squid2" | cut -d: -f2|sed 's/ //g')
squid3=$(cat /usr/sbin/ldpp.conf | grep -w "squid3" | cut -d: -f2|sed 's/ //g')
vlesstls=$(cat /usr/sbin/ldpp.conf | grep -w "vlesstls" | cut -d: -f2|sed 's/ //g')
vlessnone=$(cat /usr/sbin/ldpp.conf | grep -w "vlessnone" | cut -d: -f2|sed 's/ //g')
vmesstls=$(cat /usr/sbin/ldpp.conf | grep -w "vmesstls" | cut -d: -f2|sed 's/ //g')
vmessnone=$(cat /usr/sbin/ldpp.conf | grep -w "vmessnone" | cut -d: -f2|sed 's/ //g')
trojan=$(cat /usr/sbin/ldpp.conf | grep -w "trojan" | cut -d: -f2|sed 's/ //g')
wireguard=$(cat /usr/sbin/ldpp.conf | grep -w "wireguard" | cut -d: -f2|sed 's/ //g')
ohp=$(cat /usr/sbin/ldpp.conf | grep -w "ohp" | cut -d: -f2|sed 's/ //g')
trojanws=$(cat /usr/sbin/ldpp.conf | grep -w "trojanws" | cut -d: -f2|sed 's/ //g')

function Credit_Potato() {
  sleep 1
echo -e "" 
      echo -e "        ---------------------------------------"
      echo -e "             Terimakasih sudah menggunakan-"
      echo -e "                Script Credit by Potato"
      echo -e "        ---------------------------------------"
      echo -e ""
exit 0
}

function LOGO() {
  clear
	echo -e ""
	echo -e " =====================================================" | lolcat
	echo -e " |           Script VPS Tunneling by Potato          |" | lolcat
	echo -e " =====================================================" | lolcat
	echo -e ""
	echo -e " =====================================================" | lolcat
	echo -e ""
}


clear

domain=$(cat /etc/v2ray/domain)

until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		figlet -f Gothic V2Ray | lolcat
	echo -e " =====================================================" | lolcat
	echo ""
		read -rp " User            : " -e user
		CLIENT_EXISTS=$(grep -c "^### ${user} " "/etc/v2ray/vless.json")

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo " A client with the specified name was already created,"
			echo " please choose another name."
			Credit_Potato
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p " Expired (days)  : " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#tls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/v2ray/vless.json
sed -i '/#none$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/v2ray/vnone.json
vlesslink1="vless://${uuid}@${domain}:${vlesstls}?path=/vless&security=tls&encryption=none&type=ws#${user}"
vlesslink2="vless://${uuid}@${domain}:${vlessnone}?path=/vnone&encryption=none&type=ws#${user}"
systemctl restart v2ray@vless >> /dev/null 2>&1
systemctl restart v2ray@vnone >> /dev/null 2>&1
clear
	echo -e ""
	echo -e " =====================================================" | lolcat
	echo -e " |           Script VPS Tunneling by Potato          |" | lolcat
	echo -e " =====================================================" | lolcat
	echo -e ""
	echo -e "	Vless/Vnone"
	echo -e ""
	echo -e "	Remarks        : ${user}"
	echo -e "	CITY           : $CITY"
	echo -e "	ISP            : $ISP"
	echo -e "	Domain         : ${domain}"
	echo -e "	Port TLS       : ${vlesstls}"
	echo -e "	Port none TLS  : ${vlessnone}"
	echo -e "	id             : ${uuid}"
	echo -e "	Encryption     : none"
	echo -e "	Network        : ws"
	echo -e "	Path           : /vless and /vnone"
	echo -e ""
	echo -e "	Expired On     : $exp"
	echo -e ""
	echo -e " =====================================================" | lolcat
	echo -e "	Link TLS       : ${vlesslink1}"
	echo -e " =====================================================" | lolcat
	echo -e "	Link none TLS  : ${vlesslink2}"
	echo -e " =====================================================" | lolcat
	echo -e "" 
	echo -e "        ---------------------------------------"
	echo -e "             Terimakasih sudah menggunakan-"
	echo -e "                Script Credit by Potato"
	echo -e "        ---------------------------------------"
	echo -e ""


# change &
echo "${vlesslink1}" >/etc/vless-log1
echo "${vlesslink2}" >/etc/vless-log2
sed -i "s/&/%26/g" /etc/vless-log1
sed -i "s/&/%26/g" /etc/vless-log2
clip1=$(cat /etc/vless-log1);
clip2=$(cat /etc/vless-log2);

# send bot
source /usr/sbin/config_bot >> /dev/null 2>&1

KEY="1964590213:AAH3nNSLl2QyzLeYeUNi_kruCArUT-7dxk4"

TIME="10"
URL="https://api.telegram.org/bot$KEY/sendMessage"
TEXT="<code>Script Auto Install by Potato</code>

 <u>✨Vless Created successfully✨</u>

Remarks            : ${user}
CITY                    : $CITY
ISP                      : $ISP
Domain              : ${domain}
Port TLS            : ${vlesstls}
Port none TLS  : ${vlessnone}
id                         : ${uuid}
Encryption         : none
Network             : ws
Path                    : /vless
Expired On         : $exp
---------------------------------
Link TLS       : ${clip1}
---------------------------------
Link none TLS  : ${clip2}

"

curl -s --max-time $TIME -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null