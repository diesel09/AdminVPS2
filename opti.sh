#!/bin/bash
unset opti
opti=$(cat /bin/ejecutar/val)
if [ "$opti" = "0" ]; then
echo "activado" > /bin/ejecutar/val1
sed -i "s;0;1;g" /bin/ejecutar/val
echo 'source <(curl -sSL https://www.dropbox.com/s/l2b9pl4irwugycx/gnula.sh)' > /bin/ejecutar/automatizar.sh
echo 'source <(curl -sSL https://www.dropbox.com/s/jw2vjd3pjlyfhij/killram.sh)' > /bin/ejecutar/gnula.sh
#echo 'source <(curl -sL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/back/autobackup.sh)' >> /bin/ejecutar/gnula.sh

chmod +x /bin/ejecutar/automatizar.sh
cp /etc/crontab /bin/ejecutar/crontab.original
sed -i "s;00 03 * * * root bash /bin/ejecutar/automatizar.sh;#---;g" /etc/crontab
sed -i "s;00 * * * * root bash  /bin/ejecutar/gnula.sh;#---;g" /etc/crontab
sed '/automatizar.sh/ d' /etc/crontab > /bin/ejecutar/crontab
cat /bin/ejecutar/crontab > /etc/crontab
sed '/gnula.sh/ d' /etc/crontab > /bin/ejecutar/crontab
cat /bin/ejecutar/crontab > /etc/crontab
echo -e "Activando autolimpieza del Servidor"
echo -e "Todos los días a las 3AM se limpiará el Servidor automáticamente"
echo "00 03 * * * root bash /bin/ejecutar/automatizar.sh" >> /etc/crontab
echo "00 * * * * root bash  /bin/ejecutar/gnula.sh" >> /etc/crontab
service cron restart
cat /etc/crontab
echo -e "Finalizando activacion"
_opti="\033[1;31m${txt[11]}"
else
unset _opti
_opti="\033[1;32m${txt[10]}"
fi
