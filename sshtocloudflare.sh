#!/bin/bash

ssh-keygen
cat /home/$USER/.ssh/id_rsa.pub >> /home/$USER/.ssh/authorized_keys
echo "public key has copied in /home/$USER/.ssh/authorized_keys"
sudo cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
echo "public key has copied in /root/.ssh/authorized_keys"
echo "ip iran ra vared konid"
read iranip
echo "ip kharej ra vared konid"
read kharejip
echo "port iran ra vared konid"
read iranport
echo "port kharej ra vared konid"
read kharejport

ssh -p 22 $USER@$iranip -f -N -L 0.0.0.0:$iranport:$kharejip:$kharejport

