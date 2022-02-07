#!/bin/bash
#18/06/2021
declare -A cor=( [0]="\033[1;37m" [1]="\033[1;34m" [2]="\033[1;31m" [3]="\033[1;33m" [4]="\033[1;32m" )
SCPfrm="/etc/ger-frm" && [[ ! -d ${SCPfrm} ]] && exit
SCPinst="/etc/ger-inst" && [[ ! -d ${SCPinst} ]] && exit
mportas () {
unset portas
portas_var=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
while read port; do
var1=$(echo $port | awk '{print $1}') && var2=$(echo $port | awk '{print $9}' | awk -F ":" '{print $2}')
[[ "$(echo -e $portas|grep "$var1 $var2")" ]] || portas+="$var1 $var2\n"
done <<< "$portas_var"
i=1
echo -e "$portas"
}
fun_ip () {
MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MEU_IP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MEU_IP" != "$MEU_IP2" ]] && IP="$MEU_IP2" || IP="$MEU_IP"
}
fun_eth () {
eth=$(ifconfig | grep -v inet6 | grep -v lo | grep -v 127.0.0.1 | grep "encap:Ethernet" | awk '{print $1}')
    [[ $eth != "" ]] && {
    msg -bar
    echo -e "${cor[3]} $(fun_trans  "Aplicar el sistema para mejorar los paquetes SSH?")"
    echo -e "${cor[3]} $(fun_trans  "Opciones para usuarios avanzados")"
    msg -bar
    read -p " [S/N]: " -e -i n sshsn
           [[ "$sshsn" = @(s|S|y|Y) ]] && {
           echo -e "${cor[1]} $(fun_trans  "Corrección de problemas de paquetes en SSH...")"
           echo -e " $(fun_trans  "¿Cual es la tasa RX?")"
           echo -ne "[ 1 - 999999999 ]: "; read rx
           [[ "$rx" = "" ]] && rx="999999999"
           echo -e " $(fun_trans  "¿Cuál es la tarifa TX?")"
           echo -ne "[ 1 - 999999999 ]: "; read tx
           [[ "$tx" = "" ]] && tx="999999999"
           apt-get install ethtool -y > /dev/null 2>&1
           ethtool -G $eth rx $rx tx $tx > /dev/null 2>&1
           }
     msg -bar
     }
}
fun_bar () {
comando="$1"
 _=$(
$comando > /dev/null 2>&1
) & > /dev/null
pid=$!
while [[ -d /proc/$pid ]]; do
echo -ne " \033[1;33m["
   for((i=0; i<10; i++)); do
   echo -ne "\033[1;31m##"
   sleep 0.2
   done
echo -ne "\033[1;33m]"
sleep 1s
echo
tput cuu1
tput dl1
done
echo -e " \033[1;33m[\033[1;31m####################\033[1;33m] - \033[1;32m100%\033[0m"
sleep 1s
}
ssl_stunel () {
[[ $(mportas|grep stunnel4|head -1) ]] && {
echo -e "\033[1;33m $(fun_trans  "Parando Stunnel")"
msg -bar
fun_bar "apt-get purge stunnel4 -y"
msg -bar
echo -e "\033[1;33m $(fun_trans  "Parado Con Exito!")"
msg -bar
return 0
}
echo -e "\033[1;32m $(fun_trans  "INSTALADOR SSL By MOD MX")"
msg -bar
echo -e "\033[1;33m $(fun_trans  "Seleccione una puerta de redirección interna.")"
echo -e "\033[1;33m $(fun_trans  "Es decir, un puerto en su servidor para SSL")"
msg -bar
         while true; do
         echo -ne "\033[1;37m"
         read -p " Local-Port: " portx
         if [[ ! -z $portx ]]; then
             if [[ $(echo $portx|grep [0-9]) ]]; then
                [[ $(mportas|grep $portx|head -1) ]] && break || echo -e "\033[1;31m $(fun_trans  "Puerta invalida")"
             fi
         fi
         done
msg -bar
DPORT="$(mportas|grep $portx|awk '{print $2}'|head -1)"
echo -e "\033[1;33m $(fun_trans  "Ahora Prestamos Saber Que Puerta del SSL, Va a Escuchar")"
msg -bar
    while true; do
    read -p " Listen-SSL: " SSLPORT
    [[ $(mportas|grep -w "$SSLPORT") ]] || break
    echo -e "\033[1;33m $(fun_trans  "Esta puerta está en uso")"
    unset SSLPORT
    done
msg -bar
echo -e "\033[1;33m $(fun_trans  "Instalando SSL")"
msg -bar
fun_bar "apt-get install stunnel4 -y"
echo -e "client = no\n[SSL]\ncert = /etc/stunnel/stunnel.pem\naccept = ${SSLPORT}\nconnect = 127.0.0.1:${DPORT}" > /etc/stunnel/stunnel.conf
####Coreccion2.0##### 
openssl genrsa -out stunnel.key 2048 > /dev/null 2>&1

(echo "mx" ; echo "mx" ; echo "mx" ; echo "data-cloud.club" ; echo "mx" ; echo "mx" ; echo "@info@datacloud.club" )|openssl req -new -key stunnel.key -x509 -days 1000 -out stunnel.crt > /dev/null 2>&1

cat stunnel.crt stunnel.key > stunnel.pem 

mv stunnel.pem /etc/stunnel/
######-------
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
service stunnel4 restart > /dev/null 2>&1
msg -bar
echo -e "\033[1;33m $(fun_trans  "INSTALADO CON EXITO")"
msg -bar
rm -rf /etc/ger-frm/stunnel.crt > /dev/null 2>&1
rm -rf /etc/ger-frm/stunnel.key > /dev/null 2>&1
rm -rf /root/stunnel.crt > /dev/null 2>&1
rm -rf /root/stunnel.key > /dev/null 2>&1
return 0
}
ssl_stunel_2 () {
echo -e "\033[1;32m $(fun_trans  "INSTALADOR SSL ")"
msg -bar
echo -e "\033[1;33m $(fun_trans  "Seleccione una puerta de redirección interna.")"
echo -e "\033[1;33m $(fun_trans  "Es decir, un puerto en su servidor para SSL")"
msg -bar
         while true; do
         echo -ne "\033[1;37m"
         read -p " Local-Port: " portx
         if [[ ! -z $portx ]]; then
             if [[ $(echo $portx|grep [0-9]) ]]; then
                [[ $(mportas|grep $portx|head -1) ]] && break || echo -e "\033[1;31m $(fun_trans  "Puerta invalida")"
             fi
         fi
         done
msg -bar
DPORT="$(mportas|grep $portx|awk '{print $2}'|head -1)"
echo -e "\033[1;33m $(fun_trans  "Ahora Prestamos Saber Que Puerta del SSL, Va a Escuchar")"
msg -bar
    while true; do
    read -p " Listen-SSL: " SSLPORT
    [[ $(mportas|grep -w "$SSLPORT") ]] || break
    echo -e "\033[1;33m $(fun_trans  "Esta puerta está en uso")"
    unset SSLPORT
    done
msg -bar
echo -e "\033[1;33m $(fun_trans  "Instalando SSL")"
msg -bar
fun_bar "apt-get install stunnel4 -y"
echo -e "client = no\n[SSL+]\ncert = /etc/stunnel/stunnel.pem\naccept = ${SSLPORT}\nconnect = 127.0.0.1:${DPORT}" >> /etc/stunnel/stunnel.conf
######-------
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
service stunnel4 restart > /dev/null 2>&1
msg -bar
echo -e "\033[1;33m $(fun_trans  "INSTALADO CON EXITO")"
msg -bar
rm -rf /etc/ger-frm/stunnel.crt > /dev/null 2>&1
rm -rf /etc/ger-frm/stunnel.key > /dev/null 2>&1
rm -rf /root/stunnel.crt > /dev/null 2>&1
rm -rf /root/stunnel.key > /dev/null 2>&1
return 0
}
# SSLWS
ssl_py () {
cd $HOME
tput cuu1 && tput dl1
msg -bar
msg -ama "HOLA! \033[1;32m[ EJECUTANDO ]  \033[1;33m[\033[1;34m WEBSOCKET \033[1;33m] \033[1;31m[\033[1;37m AUTOCONFIGURACION\033[1;31m]"
echo " "
msg -verm "Necesita tener libre el puerto 80 y el 443"
msg -verm "Cualquier error en él script Reportarlo"
msg -verm "Para hacer las correcciones: "
msg -verm "Adquiera este script en TG: @KeyVpspremium_bot"
msg -bar
while [[ $Key != @(s|S|y|Y|n|N) ]]; do
msg -ne "Continuar [S/N]: " && read Key
tput cuu1 && tput dl1
done
if [[ $Key = @(s|S|y|Y) ]]; then
msg -verm "Perfecto, Iniciando Configuracion: "
echo " "
echo -e " \033[1;32m[ Adquiera este Script en: ] "
echo -e " \033[1;32m[ Telegram: @KeyVpspremium_bot ] "
wget wget https://raw.githubusercontent.com/diesel09/AdminVPS2/main/gerador/payssl.sh; chmod 777 payssl.sh; ./payssl.sh
msg -bar
else
msg -verm "Procedimiento Cancelado: "
msg -bar
fi
}
certif(){
 [[ $(mportas|grep stunnel4|head -1) ]] && {
 echo -e "\\033[1;33m $(fun_trans  "Deteniendo Stunnel")"
 msg -bar
 service stunnel4 stop > /dev/null 2>&1
 apt-get purge stunnel4 -y &>/dev/null && echo -e "\\e[31m DETENIENDO SERVICIO SSL" | pv -qL10
 apt-get remove stunnel4 &>/dev/null
 rm -rf /etc/stunnel/stunnel.conf
 rm -rf /etc/stunnel/private.key
 rm -rf /etc/stunnel/certificate.crt
 rm -rf /etc/stunnel/ca_bundle.crt
 msg -bar
 echo -e "\\033[1;33m $(fun_trans  "Detenido Con Exito!")"
 msg -bar
 return 0
 }
 clear
 msg -bar
 echo -e "\\033[1;33m $(fun_trans  "Seleccione una puerta de redirección interna.")"
 echo -e "\\033[1;33m $(fun_trans  "Un puerto SSH/DROPBEAR/SQUID/OPENVPN/PYTHON")"
 msg -bar
          while true; do
          echo -ne "\\033[1;37m"
          read -p " Puerto Local: " redir
 		 echo ""
          if [[ ! -z $redir ]]; then
              if [[ $(echo $redir|grep [0-9]) ]]; then
                 [[ $(mportas|grep $redir|head -1) ]] && break || echo -e "\\033[1;31m $(fun_trans  "Puerto Invalido")"
              fi
          fi
          done
 msg -bar
 DPORT="$(mportas|grep $redir|awk '{print $2}'|head -1)"
 echo -e "\\033[1;33m $(fun_trans  "Ahora Que Puerto sera SSL")"
 msg -bar
     while true; do
 	echo -ne "\\033[1;37m"
     read -p " Puerto SSL: " SSLPORT
 	echo ""
     [[ $(mportas|grep -w "$SSLPORT") ]] || break
     echo -e "\\033[1;33m $(fun_trans  "Esta puerta está en uso")"
     unset SSLPORT
     done
 msg -bar
 echo -e "\\033[1;33m $(fun_trans  "Instalando SSL")"
 msg -bar
 apt-get install stunnel4 -y &>/dev/null && echo -e "\\e[32m INSTALANDO SSL" | pv -qL10
 clear
 echo -e "client = no\\n[SSL]\\ncert = /etc/stunnel/stunnel.pem\\naccept = ${SSLPORT}\\nconnect = 127.0.0.1:${DPORT}" > /etc/stunnel/stunnel.conf
 msg -bar
 echo -e "\\e[1;37m ACONTINUACION ES TENER LISTO EL LINK DEL CERTIFICADO.zip\\n VERIFICAR CERTIFICADO EN ZEROSSL, DESCARGALO Y SUBELO\\n EN TU GITHUB O DROPBOX"
 msg -bar
 read -p "enter para seguir..."
 clear
 ####Cerrificado ssl/tls#####
 msg -bar
 echo -e "\\e[1;33m👇 LINK DEL CERTIFICADO.zip 👇           \\n \\e[0m"
 echo -e "\\e[1;36m LINK \\e[37m: \\e[34m\\c "
 #extraer certificado.zip
 read linkd
 wget $linkd &>/dev/null -O /etc/stunnel/certificado.zip
 cd /etc/stunnel/
 unzip certificado.zip &>/dev/null
 cat private.key certificate.crt ca_bundle.crt > stunnel.pem
 rm -rf certificado.zip
 sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
 service stunnel restart > /dev/null 2>&1
 service stunnel4 restart &>/dev/null
 msg -bar
 echo -e "${cor[4]} CERTIFICADO INSTALADO CON EXITO \\e[0m" 
 msg -bar
 }
 
 certificadom(){
 if [ -f /etc/stunnel/stunnel.conf ]; then
 insapa2(){
 for pid in $(pgrep python);do
 kill $pid
 done
 for pid in $(pgrep apache2);do
 kill $pid
 done
 service dropbear stop
 apt install apache2 -y
 echo "Listen 80
 
 <IfModule ssl_module>
         Listen 443
 </IfModule>
 
 <IfModule mod_gnutls.c>
         Listen 443
 </IfModule> " > /etc/apache2/ports.conf
 service apache2 restart
 }
 clear
 msg -bar
 insapa2 &>/dev/null && echo -e " \\e[1;33mAGREGANDO RECURSOS " | pv -qL 10
 msg -bar
 echo -e "\\e[1;37m Verificar dominio \\e[0m"
 msg -bar
 read -p " LLAVE: " keyy
 msg -bar
 read -p " DATOS: " dat2w
 mkdir -p /var/www/html/.well-known/pki-validation/
 datfr1=$(echo "$dat2w"|awk '{print $1}')
 datfr2=$(echo "$dat2w"|awk '{print $2}')
 datfr3=$(echo "$dat2w"|awk '{print $3}')
 echo -ne "${datfr1}\\n${datfr2}\\n${datfr3}" >/var/www/html/.well-known/pki-validation/$keyy.txt
 msg -bar
 echo -e "\\e[1;37m VERIFIQUE EN LA PÁGINA ZEROSSL \\e[0m"
 msg -bar
 read -p " ENTER PARA CONTINUAR"
 clear
 msg -bar
 echo -e "\\e[1;33m👇 LINK DEL CERTIFICADO 👇\\n \\e[0m"
 echo -e "\\e[1;36m LINK \\e[37m: \\e[34m\\c"
 read link
 incertis(){
 wget $link -O /etc/stunnel/certificado.zip
 cd /etc/stunnel/
 unzip certificado.zip 
 cat private.key certificate.crt ca_bundle.crt > stunnel.pem
 service stunnel restart &>/dev/null
 service stunnel4 restart &>/dev/null
 }
 incertis &>/dev/null && echo -e " \\e[1;33mEXTRAYENDO CERTIFICADO " | pv -qL 10
 msg -bar
 echo -e "${cor[4]} CERTIFICADO INSTALADO \\e[0m" 
 msg -bar
 
 for pid in $(pgrep apache2);do
 kill $pid
 done
 apt install apache2 -y &>/dev/null
 echo "Listen 81
 
 <IfModule ssl_module>
         Listen 443
 </IfModule>
 
 <IfModule mod_gnutls.c>
         Listen 443
 </IfModule> " > /etc/apache2/ports.conf
 service apache2 restart &>/dev/null
 service dropbear start &>/dev/null
 service dropbear restart &>/dev/null
 for port in $(cat /etc/VPS-MX/PortPD.log| grep -v "nobody" |cut -d' ' -f1)
 do
 PIDVRF3="$(ps aux|grep pydic-"$port" |grep -v grep|awk '{print $2}')"
 if [[ -z $PIDVRF3 ]]; then
 screen -dmS pydic-"$port" python /etc/VPS-MX/protocolos/PDirect.py "$port"
 else
 for pid in $(echo $PIDVRF3); do
 echo ""
 done
 fi
 done
 else
 msg -bar
 echo -e "${cor[3]} SSL/TLS NO INSTALADO \\e[0m"
 msg -bar
 fi
 }
 clear
 if netstat -tnlp |grep 'stunnel4' &>/dev/null; then
 stunel="[ ON ]"
 else
 stunel="[ OFF ]"
 fi
clear
msg -bar
echo -e "${cor[3]}       INSTALADOR MONO Y MULTI SSL"
msg -bar
echo -e "${cor[1]} Escoja la opcion deseada."
msg -bar
echo "1).- INSTALAR | DETENER SSL $stunel "
echo "2).- AGREGAR OTRO PUERTO SSL   "
echo "3).- WEBSOCKET (AUTO CONFIGURACION)   "
echo "4).- CERTIFICADO SSL/TLS   "
msg -bar && echo -ne "$(msg -verd "[0]") $(msg -verm2 ">") "&& msg -bra "\033[1;41mREGRESAR AL MENU"
msg -bar
echo -n "Seleccione una opcion: "
read opcao
case $opcao in
1)
msg -bar
ssl_stunel
;;
2)
msg -bar
echo -e "\033[1;93m  AGREGAR PUERTO EXTRA  ..."
msg -bar
ssl_stunel_2
;;
3)
msg -bar
ssl_py
sleep 3
exit
;;
4)
 clear
 msg -bar
 msg -ama "	CERTIFICADO"
 msg -bar
 echo -e "${cor[4]} 1).-\\033[1;37m CERTIFICADO WEB ZIP "
 echo -e "${cor[4]} 2).-\\033[1;37m CERTIFICADO MANUAL ZEROSSL   "
 msg -bar
 echo -ne "\\033[1;37mSELECCIONE UN NÚMERO [0/2]: "
 read opc
 case $opc in
 1)
 certif
 exit
 ;;
 2)
 certificadom
 exit
 ;;
 esac
;;
esac
