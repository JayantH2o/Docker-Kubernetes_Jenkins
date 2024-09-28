#!/data/data/com.termux/files/usr/bin/bash
#pkg update && pkg upgrade;
#pkg install wget qemu-system-x86-64-headless qemu-utils;
pwd
ls
read -p "Enter name of VM:" name;
if [ ! -d ./$name ]; then
        mkdir ./$name;
else
        echo "Directory exists"
fi
if [ ! -e ./${name}/${name}.qcow2 ];then
read -p "Disk Size of VM:" disksize;
qemu-img create -f qcow2 ./${name}/${name}.qcow2 ${disksize}G;
else
        echo "${name}.qcow2 exists"
fi
if [ ! -e ./${name}/*.iso ];then
read -p "ISO Link:" linktoiso;
if [[ $linktoiso -eq "" ]]
then
        linktoiso="https://dl-cdn.alpinelinux.org/alpine/v3.20/releases/x86_64/alpine-virt-3.20.3-x86_64.iso"
fi

wget -P ./$name $linktoiso;
else
        echo "ISO file exists"
fi