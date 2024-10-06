#!/data/data/com.termux/files/usr/bin/bash                                                                                           pkg update && pkg upgrade;
pkg install wget qemu-system-x86-64-headless qemu-utils;
pwd
ls
read -p "Enter name of VM:" name;
if [ ! -d ./$name ]; then
        mkdir ./$name;
else
        echo "Directory exists"
fi                                                                                                                                   if [ ! -e ./${name}/${name}.qcow2 ];then
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
iso=$(ls ./$name | grep .iso)
echo "${iso} file downloaded..."
else
        iso=$(ls ./$name | grep .iso)
        echo "${iso} file exists"
fi                                                                                                                                   
read -p "Enter Port number:" port;
read -p "Enter RAM value:" ram;

echo "qemu-system-x86_64 -m ${ram} -netdev user,id=n1,hostfwd=tcp::${port}-:22 -device virtio-net,netdev=n1 -nographic -drive file=${name}.qcow2,format=qcow2" > ./${name}/${name}.sh

read -p "Start the VM boot?(y/n):" ans;                                                                                              if [[ $ans = "y" ]]
then
        qemu-system-x86_64 -m ${ram} -netdev user,id=n1,hostfwd=tcp::${port}-:22 -device virtio-net,netdev=n1 -cdrom ./${name}/${iso} -nographic -drive file=./${name}/${name}.qcow2,format=qcow2
else
echo -e "qemu-system-x86_64 -m ${ram}\n -netdev user,id=n1,hostfwd=tcp::${port}-:22 \n-device virtio-net,netdev=n1 \n-cdrom ./${name}/${iso} \n-nographic -drive file=./${name}/${name}.qcow2,format=qcow2"
fi