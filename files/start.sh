#!/bin/bash

XORG_USER="ivideon"

## --- preconfig

[ ! -f /etc/xrdp/rsakeys.ini ] && { xrdp-keygen xrdp /etc/xrdp/rsakeys.ini > /etc/xrdp/keygen.log 2>&1; }

sed -i s@.*/etc/X11/Xsession.*@startxfce4@g /etc/xrdp/startwm.sh
sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini
sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini
cp -f /opt/xrdp-template.ini /etc/xrdp/xrdp.ini

echo "startxfce4" > /etc/skel/.Xsession

## --- create user

if [ ! -f /root/.xuser ]
then
  useradd -s /bin/bash -g users $XORG_USER
  rsync -a /etc/skel/ /home/$XORG_USER/ 
  XORG_PASSWD=$( pwgen --ambiguous 8 1 )
  echo -e "$XORG_PASSWD\n$XORG_PASSWD\n" | passwd -q $XORG_USER
  echo "$XORG_PASSWD" > /root/.xuser
fi

## --- information

echo -e "\n\nRDP user: $XORG_USER\n    pass: $( cat /root/.xuser )"
echo -e "\nConnect with a Remote Desktop Client and use 'ivideon-server' program.\n   Do not forget, the GUI uses EN keyboard layout.\n"


## --- run stuff

echo "Running data dir permission fix..."
#mkdir -p /ivideon-data
#ln -f /ivideon-data /home/$XORG_USER/.IvideonServer
#chown -R $XORG_USER:users /home/$XORG_USER/.IvideonServer
chown -R $XORG_USER:users /home/$XORG_USER
#[ -d /home/$XORG_USER/.IvideonServer ] && { chown -R $XORG_USER:users /home/$XORG_USER/.IvideonServer; }


echo "Starting remote desktop service..."
rm -rf /var/run/xrdp/*.pid

sleep 3
xrdp || { echo "Failed to start xrdp"; exit 1; }
sleep 2
xrdp-sesman || { echo "Failed to start xrdp-sesman"; exit 1; }
sleep 2
if [ $( ps -ef | grep -i xrdp | grep -iv grep | wc -l ) -ge 2 ] && [ $( ss -lntp | grep -i xrdp | wc -l ) -ge 2 ]
then
  echo "RDP service is running."
else
  echo "Problem with RDP service. Exiting..."
  exit 1
fi

### keep the container running stuff
touch /tmp/null.txt
tail -f /tmp/null.txt
