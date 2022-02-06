#!/bin/sh
#Autor: Henry Chumo 
#Alias : ChumoGH
clear
config="/etc/v2ray/config.json"
temp="/etc/v2ray/temp.json"
v2rdir="/etc/v2r" && [[ ! -d $v2rdir ]] && mkdir $v2rdir
user_conf="/etc/v2r/user" && [[ ! -e $user_conf ]] && touch $user_conf
backdir="/etc/v2r/back" && [[ ! -d ${backdir} ]] && mkdir ${backdir}
tmpdir="$backdir/tmp"
[[ ! -e $v2rdir/conf ]] && echo "autBackup 0" > $v2rdir/conf
if [[ $(cat $v2rdir/conf | grep "autBackup") = "" ]]; then
	echo "autBackup 0" >> $v2rdir/conf
fi
barra="\033[0;31m=====================================================\033[0m"
numero='^[0-9]+$'
hora=$(printf '%(%H:%M:%S)T') 
fecha=$(printf '%(%D)T')

install_ini () {
add-apt-repository universe
apt update -y; apt upgrade -y
clear
echo -e "$BARRA"
echo -e "\033[92m        -- INSTALANDO PAQUETES NECESARIOS -- "
echo -e "$BARRA"
#bc
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || apt-get install bc -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install bc................... $ESTATUS "
#pip
[[ $(dpkg --get-selections|grep -w "pip"|head -1) ]] || apt-get install pip -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "pip"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "pip"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install pip.................. $ESTATUS "
#jq
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || apt-get install jq -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install jq................... $ESTATUS "
#curl
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt-get install curl -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install curl................. $ESTATUS "
#npm
[[ $(dpkg --get-selections|grep -w "npm"|head -1) ]] || apt-get install npm -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "npm"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "npm"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install npm.................. $ESTATUS "
#nodejs
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] || apt-get install nodejs -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install nodejs............... $ESTATUS "
#socat
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] || apt-get install socat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install socat................ $ESTATUS "
#netcat
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || apt-get install netcat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install netcat............... $ESTATUS "
#netcat-traditional
[[ $(dpkg --get-selections|grep -w "netcat-traditional"|head -1) ]] || apt-get install netcat-traditional -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat-traditional"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat-traditional"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install netcat-traditional... $ESTATUS "
#net-tools
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || apt-get net-tools -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install net-tools............ $ESTATUS "
#cowsay
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] || apt-get install cowsay -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install cowsay............... $ESTATUS "
#figlet
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || apt-get install figlet -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install figlet............... $ESTATUS "
#lolcat
apt-get install lolcat -y &>/dev/null
sudo gem install lolcat &>/dev/null
[[ $(dpkg --get-selections|grep -w "lolcat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "lolcat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install lolcat............... $ESTATUS "

echo -e "$BARRA"
echo -e "\033[92m La instalacion de paquetes necesarios a finalizado"
echo -e "$BARRA"
echo -e "\033[97m Si la instalacion de paquetes tiene fallas"
echo -ne "\033[97m Puede intentar de nuevo [s/n]: "
read inst
[[ $inst = @(s|S|y|Y) ]] && install_ini
}


autB(){
	if [[ ! $(cat $v2rdir/conf | grep "autBackup" | cut -d " " -f2) = "0" ]]; then
		autBackup
	fi
 }
 
restore(){
	clear

	unset num
	unset opcion
	unset _res

	if [[ -z $(ls $backdir) ]]; then
		title "	no se encontraron respaldos"
		sleep 0.5s
		return
	fi

	num=1
	title "	   Lista de Respaldos creados"
	blanco "	      nom  \033[0;31m| \033[1;37mfechas \033[0;31m|  \033[1;37mhora"
	echo -e $barra
	for i in $(ls $backdir); do
		col "$num)" "$i"
		_res[$num]=$i
		let num++
	done
	echo -e $barra
	col "0)" "VOLVER"
	echo -e $barra
	blanco " cual desea restaurar?" 0
	read opcion

	[[ $opcion = 0 ]] && return
	[[ -z $opcion ]] && blanco "\n deves seleccionar una opcion!" && sleep 0.5s && return
	[[ ! $opcion =~ $numero ]] && blanco "\n solo deves ingresar numeros!" && sleep 0.5s && return
	[[ $opcion -gt ${#_res[@]} ]] && blanco "\n solo numeros entre 0 y ${#_res[@]}" && sleep 0.5s && return

	mkdir $backdir/tmp
	tar xpf $backdir/${_res[$opcion]} -C $backdir/tmp/

	clear
	title "	Archivos que se restauran"

	if rm -rf $config && cp $tmpdir/config.json $temp; then
		sleep 1
		echo "cat $temp | jq '.inbounds[].streamSettings.tlsSettings += {certificates:[{certificateFile:\"/data/v2ray.crt\",keyFile:\"/data/v2ray.key\"}]}' >> $config" | bash
		chmod 777 $config
		rm $temp
		blanco " /etc/v2ray/config.json..." && verde "[ok]" 
	else
		blanco " /etc/v2ray/config.json..." && rojo "[fail]"	
	fi

	if rm -rf $user_conf && cp $tmpdir/user $user_conf; then
		blanco " /etc/v2r/user..." && verde "[ok]"
	else
		blanco " /etc/v2r/user..." && rojo "[fail]"
	fi
    [[ -e $tmpdir/fullchain.cer ]] && mv $tmpdir/fullchain.cer $tmpdir/fullchain.crt
	if rm -rf /data && mkdir /data && cp $tmpdir/*.crt /data/v2ray.crt && cp $tmpdir/*.key /data/v2ray.key; then
		blanco " /data/v2ray.crt..." && verde "[ok]"
		blanco " /data/v2ray.key..." && verde "[ok]"
	else
		blanco " /data/v2ray.crt..." && rojo "[fail]"
		blanco " /data/v2ray.key..." && rojo "[fail]"
		echo $barra
		echo -e "VALIDA TU CERTIFICADO SSL "
		v2ray tls 
	fi
	rm -rf $tmpdir
	echo -e $barra
	continuar
	read foo
}

server(){
	clear

	if [[ $(npm ls -g | grep "http-server") = "" ]]; then
		npm install --global http-server
		clear
	fi

	if [[ $(ps x | grep "http-server" | grep -v grep) = "" ]]; then
		screen -dmS online http-server /etc/v2r/back/ --port 95 -s
		title "	Respaldos en linea"
		col "su url:" "http://$(wget -qO- ipv4.icanhazip.com):95"
		echo -e $barra
		continuar
		read foo
	else
		killall http-server
		title "	servidor detenido..."
		sleep 0.5s
	fi
 }
 
autBackup(){
	unset fecha
	unset hora
	unset tmp
	unset back
	unset cer
	unset key
	#fecha=`date +%d-%m-%y-%R`
	fecha=`date +%d-%m-%y`
	hora=`date +%R`
	tmp="$backdir/tmp" && [[ ! -d ${tmp} ]] && mkdir ${tmp}
	back="$backdir/v2r___${fecha}___${hora}.tar"
	cer=$(cat /etc/v2ray/config.json | jq -r ".inbounds[].streamSettings.tlsSettings.certificates[].certificateFile")
	key=$(cat /etc/v2ray/config.json | jq -r ".inbounds[].streamSettings.tlsSettings.certificates[].keyFile")

	cp $user_conf $tmp
	cp $config $tmp
	[[ ! $cer = null ]] && [[ -e $cer ]] && cp $cer $tmp
	[[ ! $key = null ]] && [[ -e $cer ]] && cp $key $tmp

	cd $tmp
	tar -cpf $back *
	cp $back /var/www/html/v2rayBack.tar && echo -e "
 Descargarlo desde cualquier sitio con acceso WEB
  LINK : http://$(wget -qO- ifconfig.me):81/v2rayBack.tar \033[0m
-------------------------------------------------------"
read -p "ENTER PARA CONTINUAR"
	rm -rf $tmp
 }
 
on_off_res(){
	if [[ $(cat $v2rdir/conf | grep "autBackup" | cut -d " " -f2) = "0" ]]; then
		echo -e "\033[0;31m[off]"
	else
		echo -e "\033[1;92m[on]"
	fi
 }

blanco(){
	[[ !  $2 = 0 ]] && {
		echo -e "\033[1;37m$1\033[0m"
	} || {
		echo -ne " \033[1;37m$1:\033[0m "
	}
}

verde(){
	[[ !  $2 = 0 ]] && {
		echo -e "\033[1;32m$1\033[0m"
	} || {
		echo -ne " \033[1;32m$1:\033[0m "
	}
}

rojo(){
	[[ !  $2 = 0 ]] && {
		echo -e "\033[1;31m$1\033[0m"
	} || {
		echo -ne " \033[1;31m$1:\033[0m "
	}
}

col(){

	nom=$(printf '%-55s' "\033[0;92m${1} \033[0;31m>> \033[1;37m${2}")
	echo -e "	$nom\033[0;31m${3}   \033[0;92m${4}\033[0m"
}

col2(){

	echo -e " \033[1;91m$1\033[0m \033[1;37m$2\033[0m"
}

vacio(){

	blanco "\n no se puede ingresar campos vacios..."
}

cancelar(){

	echo -e "\n \033[3;49;31minstalacion cancelada...\033[0m"
}

continuar(){

	echo -e " \033[3;49;32mEnter para continuar...\033[0m"
}

title2(){
	v1=$(cat /etc/adm-lite/v-local.log)
	v2=$(cat /bin/ejecutar/v-new.log)
	echo -e $barra
	[[ $v1 = $v2 ]] && echo -e "   \e[97m\033[1;41m V2ray by @Rufu99 Remasterizado @ChumoGH [$v1] \033[0m" || echo -e " \e[97m\033[1;41m V2ray by @Rufu99 Remasterizado @ChumoGH [$v1] >> \033[1;92m[$v2] \033[0m"
}

title(){
	echo -e $barra
	blanco "$1"
	echo -e $barra
}

userDat(){
	blanco "	N°    Usuarios 		  fech exp   dias"
	echo -e $barra
}

#============================================
domain_check() {
	ssl_install_fun
    clear
    echo -e $barra
    echo -e "   \033[1;49;37mgenerador de certificado ssl/tls\033[0m"
    echo -e $barra
    echo -e " \033[1;49;37mingrese su dominio (ej: midominio.com.ar)\033[0m"
    echo -ne ' \033[3;49;31m>>>\033[0m '
    read domain

    echo -e "\n \033[1;49;36mOteniendo resolucion dns de su dominio...\033[0m"
    domain_ip=$(ping "${domain}" -c 1 | sed '1{s/[^(]*(//;s/).*//;q}')

    echo -e "\n \033[1;49;36mOteniendo IP local...\033[0m"
    local_ip=$(wget -qO- ipv4.icanhazip.com)
    sleep 0.5s

    while :
    do
    if [[ $(echo "${local_ip}" | tr '.' '+' | bc) -eq $(echo "${domain_ip}" | tr '.' '+' | bc) ]]; then
            clear
            echo -e $barra
            echo -e " \033[1;49;37mSu dominio: ${domain}\033[0m"
            echo -e $barra
            echo -e " \033[1;49;37mIP dominio:\033[0m  \033[1;49;32m${domain_ip}\033[0m"
            echo -e " \033[1;49;37mIP local:\033[0m    \033[1;49;32m${local_ip}\033[0m"
            echo -e $barra
            echo -e "      \033[1;49;32mComprovacion exitosa\033[0m"
            echo -e " \033[1;49;37mLa IP de su dominio coincide\n con la IP local, desea continuar?\033[0m"
            echo -e $barra
            echo -ne " \033[1;49;37msi o no [S/N]:\033[0m "
            read opcion
            case $opcion in
                [Yy]|[Ss]) port_exist_check;;
                [Nn]) cancelar && sleep 0.5s;;
                *) echo -e "\n \033[1;49;37mselecione (S) para si o (N) para no!\033[0m" && sleep 0.5s && continue;;
            esac
    else
            clear
            echo -e $barra
            echo -e " \033[1;49;37mSu dominio: ${domain}\033[0m"
            echo -e $barra
            echo -e " \033[1;49;37mIP dominio:\033[0m  \033[3;49;31m${domain_ip}\033[0m"
            echo -e " \033[1;49;37mIP local:\033[0m    \033[3;49;31m${local_ip}\033[0m"
            echo -e $barra
            echo -e "      \033[3;49;31mComprovacion fallida\033[0m"
            echo -e " \033[4;49;97mLa IP de su dominio no coincide\033[0m\n         \033[4;49;97mcon la IP local\033[0m"
            echo -e $barra
            echo -e " \033[1;49;36m> Asegúrese que se agrego el registro"
            echo -e "   (A) correcto al nombre de dominio."
            echo -e " > Asegurece que su registro (A)"
            echo -e "   no posea algun tipo de seguridad"
            echo -e "   adiccional y que solo resuelva DNS."
            echo -e " > De lo contrario, V2ray no se puede"
            echo -e "   utilizar normalmente...\033[0m"
            echo -e $barra
            echo -e " \033[1;49;37mdesea continuar?"
            echo -ne " si o no [S/N]:\033[0m "
            read opcion
            case $opcion in
                [Yy]|[Ss]) port_exist_check;;
                [Nn]) cancelar && sleep 0.5s;;
                *) echo -e "\n \033[1;49;37mselecione (S) para si o (N) para no!\033[0m" && sleep 0.5s && continue;;
            esac
        fi
        break
    done
}

port_exist_check() {
    while :
    do
    clear
    echo -e $barra
    echo -e " \033[1;49;37mPara la compilacion del certificado"
    echo -e " se requiere que los siguientes puerto"
    echo -e " esten libres."
    echo -e "        '80' '443'"
    echo -e " este script intentara detener"
    echo -e " cualquier proseso que este"
    echo -e " usando estos puertos\033[0m"
    echo -e $barra
    echo -e " \033[1;49;37mdesea continuar?"
    echo -ne " [S/N]:\033[0m "
    read opcion

    case $opcion in
        [Ss]|[Yy])         
                    ports=('80' '443')
                    clear
                        echo -e $barra
                        echo -e "      \033[1;49;37mcomprovando puertos...\033[0m"
                        echo -e $barra
                        sleep 0.5s
                        for i in ${ports[@]}; do
                            [[ 0 -eq $(lsof -i:$i | grep -i -c "listen") ]] && {
                                echo -e "    \033[3;49;32m$i [OK]\033[0m" 
                            } || {
                                echo -e "    \033[3;49;31m$i [fail]\033[0m"
                            }
                        done
                        echo -e $barra
                        for i in ${ports[@]}; do
                            [[ 0 -ne $(lsof -i:$i | grep -i -c "listen") ]] && {
                                echo -ne "       \033[1;49;37mliberando puerto $i...\033[1;49;37m "
                                lsof -i:$i | awk '{print $2}' | grep -v "PID" | xargs kill -9
                                echo -e "\033[1;49;32m[OK]\033[0m"
                            }
                        done
                        ;;
        [Nn]) cancelar && sleep 0.5s && break;;
        *) echo -e "\n \033[1;49;37mselecione (S) para si o (N) para no!\033[0m" && sleep 0.5s;;
    esac
    continuar
    read foo
    ssl_install
    break
    done
}

ssl_install() {
    while :
    do

    if [[ -f "/data/v2ray.key" || -f "/data/v2ray.crt" ]]; then
        clear
        echo -e $barra
        echo -e " \033[1;49;37mya existen archivos de certificados"
        echo -e " en el directorio asignado.\033[0m"
        echo -e $barra
        echo -e " \033[1;49;37mENTER para canselar la instacion."
        echo -e " 'S' para eliminar y continuar\033[0m"
        echo -e $barra
        echo -ne " opcion: "
        read ssl_delete
        case $ssl_delete in
        [Ss]|[Yy])
                    rm -rf /data/*
                    echo -e " \033[3;49;32marchivos removidos..!\033[0m"
                    sleep 0.5s
                    ;;
        *) cancelar && sleep 0.5s && break;;
        esac
    fi

    if [[ -f "$HOME/.acme.sh/${domain}_ecc/${domain}.key" || -f "$HOME/.acme.sh/${domain}_ecc/${domain}.cer" ]]; then
        echo -e $barra
        echo -e " \033[1;49;37mya existe un almacer de certificado"
        echo -e " bajo este nombre de dominio\033[0m"
        echo -e $barra
        echo -e " \033[1;49;37m'ENTER' cansela la instalacion"
        echo -e " 'D' para eliminar y continuar"
        echo -e " 'R' para restaurar el almacen crt\033[0m"
        echo -e $barra
        echo -ne " opcion: "
        read opcion
        case $opcion in
            [Dd])
                        echo -e " \033[1;49;92meliminando almacen cert...\033[0m"
                        sleep 0.5s
                        rm -rf $HOME/.acme.sh/${domain}_ecc
                        ;;
            [Rr])
                        echo -e " \033[1;49;92mrestaurando certificados...\033[0m"
                        sleep 0.5s
                        "$HOME"/.acme.sh/acme.sh --installcert -d "${domain}" --fullchainpath /data/v2ray.crt --keypath /data/v2ray.key --ecc
			            echo "cat $temp | jq '.inbounds[].streamSettings.tlsSettings += {certificates:[{certificateFile:\"/data/v2ray.crt\",keyFile:\"/data/v2ray.key\"}]}' | jq '.inbounds[] += {domain:\"$domi\"}' | jq '.inbounds[].streamSettings += {security:\"tls\"}' >> $config" | bash
			            restart_v2r
                        echo -e " \033[1;49;37mrestauracion completa...\033[0m\033[1;49;92m[ok]\033[0m"
                        break
                        ;;
            *) cancelar && sleep 0.5s && break;;
        esac
    fi
    acme
    break
    done 
}

ssl_install_fun() {
    apt install socat netcat -y
    curl https://get.acme.sh | sh
}

acme() {
    clear
    echo -e $barra
    echo -e " \033[1;49;37mcreando nuevos certificado ssl/tls\033[0m"
	echo -e $barra
	read -p " Ingrese correo Para Validar el acme SSL : " corrio
	echo -e $barra
	wget -O -  https://get.acme.sh | sh -s email=$corrio
    echo -e $barra
    if "$HOME"/.acme.sh/acme.sh --issue -d "${domain}" --standalone -k ec-256 --force --test; then
        echo -e "\n           \033[1;49;37mSSL La prueba del certificado\n se emite con éxito y comienza la emisión oficial\033[0m\n"
        rm -rf "$HOME/.acme.sh/${domain}_ecc"
        sleep 0.5s
    else
        echo -e "\n \033[4;49;31mError en la emisión de la prueba del certificado SSL\033[0m"
        echo -e $barra
        rm -rf "$HOME/.acme.sh/${domain}_ecc"
        stop=1
    fi

    if [[ 0 -eq $stop ]]; then

    if "$HOME"/.acme.sh/acme.sh --issue -d "${domain}" --standalone -k ec-256 --force; then
        echo -e "\n \033[1;49;37mSSL El certificado se genero con éxito\033[0m"
        echo -e $barra
        sleep 0.5s
        [[ ! -d /data ]] && mkdir /data
        if "$HOME"/.acme.sh/acme.sh --installcert -d "${domain}" --fullchainpath /data/v2ray.crt --keypath /data/v2ray.key --ecc --force; then
            echo -e $barra
            mv $config $temp
            echo "cat $temp | jq '.inbounds[].streamSettings.tlsSettings += {certificates:[{certificateFile:\"/data/v2ray.crt\",keyFile:\"/data/v2ray.key\"}]}' | jq '.inbounds[] += {domain:\"$domain\"}' | jq '.inbounds[].streamSettings += {security:\"tls\"}' >> $config" | bash
            chmod 777 $config
            rm $temp
            restart_v2r
            echo -e "\n \033[1;49;37mLa configuración del certificado es exitosa\033[0m"
            echo -e $barra
            echo -e "      /data/v2ray.crt"
            echo -e "      /data/v2ray.key"
            echo -e $barra
            sleep 0.5s
        fi
    else
        echo -e "\n \033[4;49;31mError al generar el certificado SSL\033[0m"
        echo -e $barra
        rm -rf "$HOME/.acme.sh/${domain}_ecc"
    fi
    fi
    continuar
    read foo
}

#============================================

restart_v2r(){
	v2ray restart
	#echo "reiniciando"
}

add_user(){
	unset seg
	seg=$(date +%s)
	while :
	do
	clear
	users="$(cat $config | jq -r .inbounds[].settings.clients[].email)"

	title "		CREAR USUARIO V2RAY"
	userDat

	n=0
	for i in $users
	do
		unset DateExp
		unset seg_exp
		unset exp

		[[ $i = null ]] && {
			i="default"
			a='*'
			DateExp=" unlimit"
			col "$a)" "$i" "$DateExp"
		} || {
			DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
			seg_exp=$(date +%s --date="$DateExp")
			exp="[$(($(($seg_exp - $seg)) / 86400))]"

			col "$n)" "$i" "$DateExp" "$exp"
		}
		let n++
	done
	echo -e $barra
	col "0)" "VOLVER"
	echo -e $barra
	blanco "NOMBRE DEL NUEVO USUARIO" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.5s && continue

	[[ $opcion = 0 ]] && break

	blanco "DURACION EN DIAS" 0
	read dias

	espacios=$(echo "$opcion" | tr -d '[[:space:]]')
	opcion=$espacios

	mv $config $temp
	num=$(jq '.inbounds[].settings.clients | length' $temp)
	new=".inbounds[].settings.clients[$num]"
	new_id=$(uuidgen)
	new_mail="email:\"$opcion\""
	aid=$(jq '.inbounds[].settings.clients[0].alterId' $temp)
	echo jq \'$new += \{alterId:${aid},id:\"$new_id\","$new_mail"\}\' $temp \> $config | bash
	echo "$opcion | $new_id | $(date '+%y-%m-%d' -d " +$dias days")" >> $user_conf
	chmod 777 $config
	rm $temp
	clear
	echo -e $barra
	blanco "	Usuario $opcion creado Exitosamente"
	echo -e $barra
	restart_v2r
	sleep 0.5s
    done
}

renew(){
	while :
	do
		unset user
		clear
		title "		RENOVAR USUARIOS"
		userDat
		userEpx=$(cut -d " " -f1 $user_conf)
		n=1
		for i in $userEpx
		do
			DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
			seg_exp=$(date +%s --date="$DateExp")
			[[ "$seg" -gt "$seg_exp" ]] && {
				col "$n)" "$i" "$DateExp" "\033[0;31m[Exp]"
				uid[$n]="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f2|tr -d '[[:space:]]')"
				user[$n]=$i
				let n++
			}
		done
		[[ -z ${user[1]} ]] && blanco "		No hay expirados"
		echo -e $barra
		col "0)" "VOLVER"
		echo -e $barra
		blanco "NUMERO DE USUARIO A RENOVAR" 0
		read opcion

		[[ -z $opcion ]] && vacio && sleep 0.5s && continue
		[[ $opcion = 0 ]] && break

		[[ ! $opcion =~ $numero ]] && {
			blanco " solo numeros apartir de 1"
			sleep 0.5s
		} || {
			[[ $opcion>=${n} ]] && {
				let n--
				blanco "solo numero entre 1 y $n"
				sleep 0.5s
		} || {
			blanco "DURACION EN DIAS" 0
			read dias

			mv $config $temp
			num=$(jq '.inbounds[].settings.clients | length' $temp)
			aid=$(jq '.inbounds[].settings.clients[0].alterId' $temp)
			echo "cat $temp | jq '.inbounds[].settings.clients[$num] += {alterId:${aid},id:\"${uid[$opcion]}\",email:\"${user[$opcion]}\"}' >> $config" | bash
			sed -i "/${user[$opcion]}/d" $user_conf
			echo "${user[$opcion]} | ${uid[$opcion]} | $(date '+%y-%m-%d' -d " +$dias days")" >> $user_conf
			chmod 777 $config
			rm $temp
			clear
			echo -e $barra
			blanco "	Usuario ${user[$opcion]} renovado Exitosamente"
			echo -e $barra
			restart_v2r
			sleep 0.5s
		  }
		}
	done
}

autoDel(){
	seg=$(date +%s)
	while :
	do
		unset users
		users=$(cat $config | jq .inbounds[].settings.clients[] | jq -r .email)
		n=0
		for i in $users
		do
			[[ ! $i = null ]] && {
				DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
				seg_exp=$(date +%s --date="$DateExp")
				[[ "$seg" -gt "$seg_exp" ]] && {
					mv $config $temp
					echo jq \'del\(.inbounds[].settings.clients[$n]\)\' $temp \> $config | bash
					chmod 777 $config
					rm $temp
					continue
				}
			}
			let n++
			done
			break
		done
		restart_v2r
	}

dell_user(){
	unset seg
	seg=$(date +%s)
	while :
	do
	clear
	users=$(cat $config | jq .inbounds[].settings.clients[] | jq -r .email)

	title "	ELIMINAR USUARIO V2RAY"
	userDat
	n=0
	for i in $users
	do
		userd[$n]=$i
		unset DateExp
		unset seg_exp
		unset exp

		[[ $i = null ]] && {
			i="default"
			a='*'
			DateExp=" unlimit"
			col "$a)" "$i" "$DateExp"
		} || {
			DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
			seg_exp=$(date +%s --date="$DateExp")
			exp="[$(($(($seg_exp - $seg)) / 86400))]"
			col "$n)" "$i" "$DateExp" "$exp"
		}
		p=$n
		let n++
	done
	userEpx=$(cut -d " " -f 1 $user_conf)
	for i in $userEpx
	do	
		DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
		seg_exp=$(date +%s --date="$DateExp")
		[[ "$seg" -gt "$seg_exp" ]] && {
			col "$n)" "$i" "$DateExp" "\033[0;31m[Exp]"
			expUser[$n]=$i
		}
		let n++
	done
	echo -e $barra
	col "0)" "VOLVER"
	echo -e $barra
	blanco "NUMERO DE USUARIO A ELIMINAR" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.5s && continue
	[[ $opcion = 0 ]] && break

	[[ ! $opcion =~ $numero ]] && {
		blanco " solo numeros apartir de 1"
		sleep 0.5s
	} || {
		let n--
		[[ $opcion>=${n} ]] && {
			blanco "solo numero entre 1 y $n"
			sleep 0.5s
		} || {
			[[ $opcion>=${p} ]] && {
				sed -i "/${expUser[$opcion]}/d" $user_conf
			} || {
			sed -i "/${userd[$opcion]}/d" $user_conf
			mv $config $temp
			echo jq \'del\(.inbounds[].settings.clients[$opcion]\)\' $temp \> $config | bash
			chmod 777 $config
			rm $temp
			clear
			echo -e $barra
			blanco "	Usuario eliminado"
			echo -e $barra
			restart_v2r
			}
			sleep 0.5s
		}
	}
	done
}

view_user(){
	unset seg
	seg=$(date +%s)
	while :
	do

		clear
		users=$(cat $config | jq .inbounds[].settings.clients[] | jq -r .email)

		title "	VER USUARIO V2RAY"
		userDat

		n=1
		for i in $users
		do
			unset DateExp
			unset seg_exp
			unset exp

			[[ $i = null ]] && {
				i="Admin"
				DateExp=" Ilimitado"
			} || {
				DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
				seg_exp=$(date +%s --date="$DateExp")
				exp="[$(($(($seg_exp - $seg)) / 86400))]"
			}

			col "$n)" "$i" "$DateExp" "$exp"
			let n++
		done

		echo -e $barra
		col "0)" "VOLVER"
		echo -e $barra
		blanco "VER DATOS DEL USUARIO" 0
		read opcion

		[[ -z $opcion ]] && vacio && sleep 0.5 && continue
		[[ $opcion = 0 ]] && break

		let opcion--

		ps=$(jq .inbounds[].settings.clients[$opcion].email $config) && [[ $ps = null ]] && ps="default"
		id=$(jq .inbounds[].settings.clients[$opcion].id $config)
		aid=$(jq .inbounds[].settings.clients[$opcion].alterId $config)
		add=$(jq '.inbounds[].domain' $config) && [[ $add = null ]] && add=$(wget -qO- ipv4.icanhazip.com)
		host=$(jq '.inbounds[].streamSettings.wsSettings.headers.Host' $config) && [[ $host = null ]] && host=''
		net=$(jq '.inbounds[].streamSettings.network' $config)
		path=$(jq '.inbounds[].streamSettings.wsSettings.path' $config) && [[ $path = null ]] && path=''
		port=$(jq '.inbounds[].port' $config)
		tls=$(jq '.inbounds[].streamSettings.security' $config)
		addip=$(wget -qO- ifconfig.me)
		clear
		echo -e $barra
		blanco " Usuario: $ps OPCION $opcion"
		echo -e $barra
		col2 "Remarks:" "$ps"
		col2 "Domain:" "$add" 
		col2 "IP-Address:" "$addip"
		col2 "Port:" "$port"
		col2 "id:" "$id"
		col2 "alterId:" "$aid"
		col2 "security:" "none"
		col2 "network:" "$net"
		col2 "Head Type:" "none"
		[[ ! $host = '' ]] && col2 "Host/SNI:" "$host"
		[[ ! $path = '' ]] && col2 "Path:" "$path"
		col2 "TLS:" "$tls"
		blanco $barra
		blanco "              VMESS LINK CONFIG"
		blanco $barra
		vmess
		blanco $barra
		continuar
		read foo
	done
}

vmess() {

	echo -e "\033[3;32mvmess://$(echo {\"v\": \"2\", \"ps\": $ps, \"add\": $addip, \"port\": $port, \"aid\": $aid, \"type\": \"none\", \"net\": $net, \"path\": $path, \"host\": $host, \"id\": $id, \"tls\": $tls} | base64 -w 0)\033[3;32m"
}

alterid(){
	while :
	do
		aid=$(jq '.inbounds[].settings.clients[0].alterId' $config)
	clear
	echo -e $barra
	blanco "        configuracion alterId"
	echo -e $barra
	col2 "	alterid:" "$aid"
	echo -e $barra
	col "x)" "VOLVER"
	echo -e $barra
	blanco "NUEVO VALOR" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.5s && break
	[[ $opcion = x ]] && break

	mv $config $temp
	new=".inbounds[].settings.clients[0]"
	echo jq \'$new += \{alterId:${opcion}\}\' $temp \> $config | bash
	chmod 777 $config
	rm $temp
	clear
	echo -e $barra
	blanco "Nuevo AlterId fijado"
	echo -e $barra
	restart_v2r
	sleep 0.5s
	done
}

port(){
	while :
	do
	port=$(jq '.inbounds[].port' $config)
	clear
	echo -e $barra
	blanco "       configuracion de puerto"
	echo -e $barra
	col2 " Puerto:" "$port"
	echo -e $barra
	col "0)" "VOLVER"
	echo -e $barra
	blanco "NUEVO PUERTO" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.5s && break
	[[ $opcion = 0 ]] && break

	mv $config $temp
	new=".inbounds[]"
	echo jq \'$new += \{port:${opcion}\}\' $temp \> $config | bash
	chmod 777 $config
	rm $temp
	clear
	echo -e $barra
	blanco "	Nuevo Puerto fijado"
	echo -e $barra
	sleep 0.5s
	restart_v2r
	done
}

address(){
	while :
	do
	add=$(jq '.inbounds[].domain' $config) && [[ $add = null ]] && add=$(wget -qO- ipv4.icanhazip.com)
	clear
	echo -e $barra
	blanco "       configuracion address"
	echo -e $barra
	col2 "address:" "$add"
	echo -e $barra
	col "0)" "VOLVER"
	echo -e $barra
	blanco "NUEVO ADDRESS" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.5s && break
	[[ $opcion = 0 ]] && break

	mv $config $temp
	echo "cat $temp | jq '.inbounds[] += {domain:\"$opcion\"}' >> $config" | bash
	chmod 777 $config
	rm $temp
	clear
	echo -e $barra
	blanco "Nuevo address fijado"
	echo -e $barra
	restart_v2r
	sleep 0.5s
	done
}

host(){
	while :
	do
	host=$(jq '.inbounds[].streamSettings.wsSettings.headers.Host' $config) && [[ $host = null ]] && host='sin host'
	clear
	echo -e $barra
	blanco "       configuracion Host"
	echo -e $barra
	col2 "Host:" "$host"
	echo -e $barra
	col "0)" "VOLVER"
	echo -e $barra
	blanco "NUEVO HOST" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.5s && break
	[[ $opcion = 0 ]] && break
	mv $config $temp
	echo "cat $temp | jq '.inbounds[].streamSettings.wsSettings.headers += {Host:\"$opcion\"}' >> $config" | bash
	chmod 777 $config
	rm $temp
	clear
	echo -e $barra
	blanco "Nuevo Host fijado"
	echo -e $barra
	restart_v2r
	sleep 0.5s
	done
}

path(){
	while :
	do
	path=$(jq '.inbounds[].streamSettings.wsSettings.path' $config) && [[ $path = null ]] && path=''
	clear
	echo -e $barra
	blanco "       configuracion Path"
	echo -e $barra
	col2 "path:" "$path"
	echo -e $barra
	col "0)" "VOLVER"
	echo -e $barra
	blanco "NUEVO Path" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.5s && break
	[[ $opcion = 0 ]] && break

	mv $config $temp
	echo "cat $temp | jq '.inbounds[].streamSettings.wsSettings += {path:\"$opcion\"}' >> $config" | bash
	chmod 777 $config
	rm $temp
	clear
	echo -e $barra
	blanco "Nuevo path fijado"
	echo -e $barra
	sleep 0.5s
	restart_v2r
	done
}

crt_man(){
	while :
	do
		clear
		echo -e $barra
		blanco "configuracion de certificado manual"
		echo -e $barra

		chek=$(jq '.inbounds[].streamSettings.tlsSettings' $config)
		[[ ! $chek = {} ]] && {
			crt=$(jq '.inbounds[].streamSettings.tlsSettings.certificates[].certificateFile' $config)
			key=$(jq '.inbounds[].streamSettings.tlsSettings.certificates[].keyFile' $config)
			dom=$(jq '.inbounds[].domain' $config)
			echo -e "		\033[4;49minstalado\033[0m"
			col2 "crt:" "$crt"
			col2 "key:" "$key"
			col2 "dominio:" "$dom"
		} || {
			blanco "	certificado no instalado"
		}

		echo -e $barra
		col "1)" "ingresar nuevo crt"
		echo -e $barra
		col "0)" "VOLVER"
		echo -e $barra
		blanco "opcion" 0
		read opcion

		[[ -z $opcion ]] && vacio && sleep 0.5s && break
		[[ $opcion = 0 ]] && break

		clear
		echo -e $barra
		blanco "ingrese su archivo de certificado\n ej: /root/crt/certif.crt"
		echo -e $barra
		blanco "crt" 0
		read crts

		clear
		echo -e $barra
		blanco "	nuevo certificado"
		echo -e $barra
		blanco "	$crts"
		echo -e $barra
		blanco "ingrese su archivo key\n ej: /root/crt/certif.key"
		echo -e $barra
		blanco "key" 0
		read keys

		clear
		echo -e $barra
		blanco "	nuevo certificado"
		echo -e $barra
		blanco "	$crts"
		blanco "	$keys"
		echo -e $barra
		blanco "ingrese su dominio\n ej: netfree.xyz"
		echo -e $barra
		blanco "dominio" 0
		read domi

		clear
		echo -e $barra
		blanco "verifique sus datos sean correctos!"
		echo -e $barra
		blanco "	$crts"
		blanco "	$keys"
		blanco "	$domi"
		echo -e $barra
		continuar
		read foo

		mv $config $temp
		echo "cat $temp | jq '.inbounds[].streamSettings.tlsSettings += {certificates:[{certificateFile:\"$crts\",keyFile:\"$keys\"}]}' | jq '.inbounds[] += {domain:\"$domi\"}' | jq '.inbounds[].streamSettings += {security:\"tls\"}' >> $config" | bash
		chmod 777 $config
		rm $temp
		clear
		echo -e $barra
		blanco "nuevo certificado agregado"
		echo -e $barra
		restart_v2r
		sleep 0.5s
	done
}

install(){
	clear
	install_ini
	echo -e $barra
	blanco "	Esta por intalar v2ray!"
	echo -e $barra
	blanco " La instalacion puede tener\n alguna fallas!\n por favor observe atentamente\n el log de intalacion,\n este podria contener informacion\n sobre algunos errores!\n estos deveras ser corregidos de\n forma manual antes de continual\n usando el script"
	echo -e $barra
	blanco "Enter para continuar..."
	read foo
	source <(curl -sL https://multi.netlify.app/v2ray.sh)
	echo -e $barra
	blanco "instalcion finalizada"
	blanco "Por favor verifique el log"
	echo -e $barra
	continuar
	read foo
	clear

	mv $config $temp
	echo "cat $temp | jq 'del(.inbounds[].streamSettings.kcpSettings[])' >> $config" | bash
	chmod 777 $config
	rm $temp
	restart_v2r
}

v2ray_tls(){
	clear
	echo -e $barra
	blanco "		certificado tls v2ray"
	echo -e "Ingrese Correo Temporal o Fijo \n  Para Validar su Cerficicado SSL " 
	read -p " Ejemplo > email=my@example.com : " -e -i $(date | md5sum | head -c15)@gmail.com crreo
	echo -e $barra
	wget -O -  https://get.acme.sh | sh -s email=$crreo
	v2ray tls
	echo -e $barra
	continuar
	read foo
}

v2ray_stream(){
	clear
	echo -e $barra
	blanco "	instalacion de protocolos v2ray"
	echo -e $barra
	v2ray stream
	echo -e $barra
	continuar
	read foo
}

v2ray_menu(){
	clear
	echo -e $barra
	blanco "		MENU V2RAY"
	echo -e $barra
	v2ray
}

backups(){
	while :
	do
		unset opcion
		unset PID
		if [[ $(ps x | grep "http-server" | grep -v grep) = "" ]]; then
			PID="\033[0;31m[offline]"
		else
			PID="\033[1;92m[online]"
		fi

	clear
	title "	Config de Respaldos"
	col "1)" "Respaldar Ahora"
	col "2)" "\033[1;92mRestaurar Respaldo"
	col "3)" "\033[0;31mEliminiar Respaldos"
	col "4)" "\033[1;34mRespaldo en linea $PID"
	col "5)" "\033[1;33mRespaldos automatico $(on_off_res)"
	echo -e $barra
	
	col "6)" "\033[1;33m RESTAURAR Online PORT :81 "
	echo -e $barra
	col "0)" "VOLVER"
	echo -e $barra
	blanco "opcion" 0
	read opcion

	case $opcion in
		1)	autBackup
			clear
			title "	Nuevo Respaldo Creado..."
			sleep 0.5s;;
		2)	restore;;
		3)	rm -rf $backdir/*.tar
			clear
			title "	Almacer de Respaldo limpia..."
			sleep 0.5s;;
		4)	server;;


		5)	if [[ $(cat $v2rdir/conf | grep "autBackup" | cut -d " " -f2) = "0" ]]; then
				sed -i 's/autBackup 0/autBackup 1/' $v2rdir/conf
			else
				sed -i 's/autBackup 1/autBackup 0/' $v2rdir/conf
			fi;;
		6)
		clear
		echo -e "\033[0;33m
         ESTA FUNCION EXPERIMENTAL 
Una vez que se descarge tu Fichero, Escoje el BackOnline
	
				  + OJO +
				 
   Luego de Restaurarlo, Vuelve Activar el TLS 
 Para Validar la Configuracion de tu certificao"
echo -e $barra
echo -n "INGRESE LINK Que Mantienes Online en GitHub, o VPS \n" 
read -p "Pega tu Link : " url1
wget -q -O $backdir/BakcOnline.tar $url1 && echo -e "\033[1;31m- \033[1;32mFile Exito!"  && restore || echo -e "\033[1;31m- \033[1;31mFile Fallo" && sleep 0.5s
		;;
		0)	break;;
		*)	blanco "opcion incorrecta..." && sleep 0.5s;;
	esac
	done
}


restablecer_v2r(){
	clear
	title "   restablecer ajustes v2ray"
	echo -e " \033[0;31mEsto va a restablecer los\n ajustes predeterminados de v2ray"
	echo -e " Se perdera ajuste previos,\n incluido los Usuarios\033[0m"
	echo -e $barra
	blanco "quiere continuar? [S/N]" 0
	read opcion
	echo -e $barra
	case $opcion in
		[Ss]|[Yy]) v2ray new;;
		[Nn]) continuar && read foo;;
	esac
}

remove_all(){
	sed -i '/net.core.default_qdisc/d' /etc/sysctl.conf
    sed -i '/net.ipv4.tcp_congestion_control/d' /etc/sysctl.conf
    sed -i '/fs.file-max/d' /etc/sysctl.conf
	sed -i '/net.core.rmem_max/d' /etc/sysctl.conf
	sed -i '/net.core.wmem_max/d' /etc/sysctl.conf
	sed -i '/net.core.rmem_default/d' /etc/sysctl.conf
	sed -i '/net.core.wmem_default/d' /etc/sysctl.conf
	sed -i '/net.core.netdev_max_backlog/d' /etc/sysctl.conf
	sed -i '/net.core.somaxconn/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_syncookies/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_tw_reuse/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_tw_recycle/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_fin_timeout/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_keepalive_time/d' /etc/sysctl.conf
	sed -i '/net.ipv4.ip_local_port_range/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_max_syn_backlog/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_max_tw_buckets/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_rmem/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_wmem/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_mtu_probing/d' /etc/sysctl.conf
	sed -i '/net.ipv4.ip_forward/d' /etc/sysctl.conf
	sed -i '/fs.inotify.max_user_instances/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_syncookies/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_fin_timeout/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_tw_reuse/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_max_syn_backlog/d' /etc/sysctl.conf
	sed -i '/net.ipv4.ip_local_port_range/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_max_tw_buckets/d' /etc/sysctl.conf
	sed -i '/net.ipv4.route.gc_timeout/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_synack_retries/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_syn_retries/d' /etc/sysctl.conf
	sed -i '/net.core.somaxconn/d' /etc/sysctl.conf
	sed -i '/net.core.netdev_max_backlog/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_timestamps/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_max_orphans/d' /etc/sysctl.conf
	clear
	echo -e "  \033[0;92mLa aceleración está Desinstalada."
	sleep 1
}

bbr(){
	while :
	do
	clear
	title "		ACELERACION BBR"
	blanco "	Esto activara la aceleracion\n	por defecto de su kernel.\n	no se modoficar nada del sistema."
	echo -e $barra
	col "1)" "Acivar aceleracion"
	col "2)" "quitar toda aceleracion"
	echo -e $barra
	col "0)" "volver"
	echo -e $barra
	blanco "opcion" 0
	read opcion
	case $opcion in
		1)
			remove_all
			echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
			echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
			sysctl -p
			echo -e "  \033[0;92m¡BBR comenzó con éxito!";;
		2)remove_all;;
		0)break;;
		*)blanco " seleccione una opcion" && sleep 0.5s;;
	esac
	done
}

settings(){
	while :
	do
	clear
	echo -e $barra
	blanco "	  Ajustes e instalacion v2ray"
	echo -e $barra
	col "1)" "address"
	col "2)" "puerto"
	col "3)" "alterId"
	col "4)" "Host"
	col "5)" "Path"
	echo -e $barra
	col "6)" "certif ssl/tls (script)"
	col "7)" "certif menu nativo"
	col "8)" "certif ingreso manual"
	echo -e $barra
	col "9)" "protocolo menu nativo"
	col "10)" "conf v2ray menu nativo"
	col "11)" "restablecer ajustes"
	echo -e $barra
	col "12)" "BBR nativo del sistema"
	col "13)" "install/re-install v2ray"
	echo -e $barra
	col "14)" "Conf. Copias de Respaldos"
	echo -e $barra
	col "0)" "Volver"
	echo -e $barra
	blanco "opcion" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.5s && break
	[[ $opcion = 0 ]] && break

	case $opcion in
		1)address;;
		2)port;;
		3)alterid;;
		4)host;;
		5)path;;
		6)domain_check && clear ;;
		7)v2ray_tls;;
		8)crt_man;;
		9)v2ray_stream;;
		10)v2ray_menu;;
		11)restablecer_v2r;;
		12)bbr;;
		13)install;;
		14)backups;;
		*) blanco " solo numeros de 0 a 10" && sleep 0.5s;;
	esac
    done
}
enon(){
echo "source <(curl -sSL  https://www.dropbox.com/s/fjfc7aslg9gx8vt/v2ray_manager.sh)" > /bin/v2r.sh
chmod +x /bin/v2r.sh
		clear
		echo -e $barra
		blanco " Se ha agregado un autoejecutor en el Sector de Inicios Rapidos"
		echo -e $barra
		blanco "	  Para Acceder al menu Rapido \n	     Utilize * v2r.sh * !!!"
		echo -e $barra
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSi deseas desabilitar esta opcion, apagala"
		echo -e " Y te recomiendo, no alterar nada en este menu, para"
		echo -e "             Evitar Errores Futuros"
		echo -e " y causar problemas en futuras instalaciones.\033[0m"
		echo -e $barra
		continuar
		read foo
}
enoff(){
rm -f /bin/v2r.sh
		echo -e $barra
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSe ha Desabilitado el menu Rapido de v2r.sh"
		echo -e " Y te recomiendo, no alterar nada en este menu, para"
		echo -e "             Evitar Errores Futuros"
		echo -e " y causar problemas en futuras instalaciones.\033[0m"
		echo -e $barra
		continuar
		read foo
}

enttrada () {

	while :
	do
	clear
	echo -e $barra
	blanco "	  Ajustes e Entrasda Rapida de Menu v2ray"
	echo -e $barra
	col "1)" "Habilitar v2ru, Como entrada Rapida"
	col "2)" "Eliminar v2ru, Como entrada Rapida"
	echo -e $barra
	col "0)" "Volver"
	echo -e $barra
	blanco "opcion" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 0.5s && break
	[[ $opcion = 0 ]] && break

	case $opcion in
		1)enon;;
		2)enoff;;
		*) blanco " solo numeros de 0 a 2" && sleep 1;;
	esac
    done

}


main(){
	[[ ! -e $config ]] && {
		clear
		echo -e $barra
		blanco " No se encontro ningun archovo de configracion v2ray"
		echo -e $barra
		blanco "	  No instalo v2ray o esta usando\n	     una vercion diferente!!!"
		echo -e $barra
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSi esta usando una vercion v2ray diferente"
		echo -e " y opta por cuntinuar usando este script."
		echo -e " Este puede; no funcionar correctamente"
		echo -e " y causar problemas en futuras instalaciones.\033[0m"
		echo -e $barra
		continuar
		read foo
	}
	while :
	do
		_usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
		_usop=$(printf '%-1s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")
		[[ -e /bin/v2r.sh ]] && enrap="\033[1;92m[Encendido]" || enrap="\033[0;31m[Apagado]"
		clear
		title2
		title "   Ram: \033[1;32m$_usor  \033[0;31m<<< \033[1;37mMENU V2RAY \033[0;31m>>>  \033[1;37mCPU: \033[1;32m$_usop"
		col "1)" "CREAR USUARIO"
		col "2)" "\033[0;92mRENOVAR USUARIO"
		col "3)" "\033[0;31mREMOVER USUARIO"
		col "4)" "VER DATOS DE USUARIOS"
		col "5)" "\033[1;33mCONFIGURAR V2RAY"
		echo -e $barra
		col "6)" "\033[1;33mEntrada Rapida $enrap"
		echo -e $barra
		col "0)" "SALIR \033[0;31m|| $(blanco "Respaldos automaticos") $(on_off_res)"
		echo -e $barra
		blanco "opcion" 0
		read opcion

		case $opcion in
			1)add_user;;
			2)renew;;
			3)dell_user;;
			4)view_user;;
			5)settings;;
			6)enttrada;;
			0) break;;
			*) blanco "\n selecione una opcion del 0 al 4" && sleep 0.5s;;
		esac
	done
}

[[ $1 = "autoDel" ]] && {
	autoDel
} || {
	autoDel
	main
}
