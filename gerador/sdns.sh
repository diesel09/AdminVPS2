#!/bin/bash
declare -A cor=( [0]="\033[1;37m" [1]="\033[1;34m" [2]="\033[1;31m" [3]="\033[1;33m" [4]="\033[1;32m" )
SCPfrm="/etc/ger-frm" && [[ ! -d ${SCPfrm} ]] && exit
SCPinst="/etc/ger-inst" && [[ ! -d ${SCPinst} ]] && exit

clear
fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
 tput civis
echo -ne "  \033[1;33mESPERE \033[1;37m- \033[1;33m["
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "\033[1;31m#"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   sleep 1s
   tput cuu1
   tput dl1
   echo -ne "  \033[1;33mESPERE \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}
clear
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%40s%s%-12s\n' "INSTALADOR SLOWDNS MANAGER" ; tput sgr0
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -e ""
echo -e "      Iniciando instalacion para"
echo -e "   administrar conexion SlowDNS."
echo -e ""
echo -e "         \033[1;33mEjecutando Instalador  \033[1;37m"
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo ""
echo -e "Descargando Archivos..."
echo ""
fun_att () {
apt install ncurses-utils -y
mkdir /etc/slowdns
cd /etc/slowdns
wget https://github.com/leitura/slowdns/raw/main/dns-server; chmod +x dns-server
wget https://raw.githubusercontent.com/diesel09/slowdns/main/remove-slow; chmod +x remove-slow
wget https://raw.githubusercontent.com/diesel09/slowdns/main/slowdns-info; chmod +x slowdns-info
wget https://raw.githubusercontent.com/diesel09/slowdns/main/slowdns-drop; chmod +x slowdns-drop
wget https://raw.githubusercontent.com/diesel09/slowdns/main/slowdns-ssh; chmod +x slowdns-ssh
wget https://raw.githubusercontent.com/diesel09/slowdns/main/slowdns-ssl; chmod +x slowdns-ssl
wget https://raw.githubusercontent.com/diesel09/slowdns/main/slowdns-socks; chmod +x slowdns-socks
wget https://raw.githubusercontent.com/diesel09/slowdns/main/slowdns; chmod +x slowdns; cp slowdns /bin/
wget https://raw.githubusercontent.com/diesel09/slowdns/main/stopdns; chmod +x stopdns
}
fun_bar 'fun_att'
echo -e "CONFIGURANDO FIREWALL..."
echo ""
fun_ports () {
apt install firewalld -y && sudo firewall-cmd --zone=public --permanent --add-port=80/tcp && sudo firewall-cmd --zone=public --permanent --add-port=8080/tcp && sudo firewall-cmd --zone=public --permanent --add-port=443/tcp && sudo firewall-cmd && sudo firewall-cmd --zone=public --permanent --add-port=53/udp && sudo firewall-cmd --zone=public --permanent --add-port=5300/udp && sudo firewall-cmd && sudo firewall-cmd --zone=public --permanent --add-port=2222/tcp && sudo firewall-cmd --reload
}
fun_bar 'fun_ports'
echo -e "ESTABLECIENDO DNS DE CLOUDFLARE..."
echo ""
fun_dnscf () {
sudo systemctl disable systemd-resolved.service && sudo systemctl stop systemd-resolved.service && sudo mv /etc/resolv.conf /etc/resolv.conf.bkp && echo "nameserver 1.1.1.1" > /etc/resolv.conf
sudo systemctl enable systemd-resolved.service && sudo systemctl start systemd-resolved.service
sleep 2
}
fun_bar 'fun_dnscf'
clear
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%40s%s%-12s\n' "INSTALADOR SLOWDNS" ; tput sgr0
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo ""
echo -e "          \033[1;33mINSTALACION FINALIZADA!\033[0m          "
echo ""
echo -e "Para abrir otravez el menu, use el comando: \033[1;33mslowdns\033[0m"
cd
#rm install
slowdns
