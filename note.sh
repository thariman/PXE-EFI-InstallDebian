#install docker on mac
brew install docker docker-machine

#start boot2docker using vmware fusion
docker-machine create -d vmwarefusion dev

--vmwarefusion-boot2docker-url: URL for boot2docker image.
--vmwarefusion-cpu-count: Number of CPUs for the machine (-1 to use the number of CPUs available)
--vmwarefusion-disk-size: Size of disk for host VM (in MB).
--vmwarefusion-memory-size: Size of memory for host VM (in MB).

/Applications/VMware Fusion.app/Contents/Library   vmnet-cli   vmnet-cfgcli  vmrun

/Library/Preferences/VMware Fusion/networking   #status of all fusion network
sudo "/Applications/VMware Fusion.app/Contents/Library/"vmnet-cfgcli exportconfig ~/network3.txt

*.vmx file

$HOME/.docker/machine/machines/dev/dev.vmx


try using jpetazzo/pxe
create a new machine under vmwarefusion
stop the vm
add bridge network of my thunderbolt ethernet that is connected to dell xps (eth1)
run pipework inside boot2docker vm
sudo ./pipework eth1 sad_feynman 192.168.1.2/24
able to ping from dell after asigning static ip.  The dhcp doesn't seems to work yet.

next going to try to create boot debian vm and try dhcp directly.

Using virtualbox is possible to pxe boot between vm to other vm. ( Running Mirantis Open Stack under vbox)

setup virtualbox using 2 ethernet
sudo dnsmasq --interface=eth1 --dhcp-range=192.168.1.101,192.168.1.199,255.255.255.0,1h --dhcp-boot=/tftp/pxelinux.0 --pxe-service=x86PC,"Install Linux",pxelinux --enable-tftp --tftp-root=/tftp --no-daemon

Dell able to get ip and load pxelinux but stuck with Could not locate boot server
Need to read up on uefi netboot




#Create new debian vm under vbox
#Change eth0 to bridge
#Add bridge network map to eth1

sudo mkdir -p /var/lib/tftpboot
sudo apt-get install di-netboot-assistant
sudo /etc/init.d/tftpd-hpa stop
sudo /etc/init.d/dnsmasq stop
sudo ifconfig eth1 192.168.1.2 netmask 255.255.255.0  # eth1 direct connect to dell
sudo di-netboot-assistant install jessie
cd /var/lib/tftpboot/debian-installer
sudo ln -s jessie/amd64/
sudo cp jessie/amd64/grub/grub.cfg jessie/amd64/grub/grub.cfg.bak
sudo cp jessie/amd64/grub/grub.cfg.ORIG jessie/amd64/grub/grub.cfg
sudo iptables -t nat -A POSTROUTING -j MASQUERADE  # So dell can go to the internet via eth1/mac

sudo dnsmasq --interface=eth1 \
             --dhcp-range=192.168.1.101,192.168.1.199,255.255.255.0,1h \
             --dhcp-boot=debian-installer/jessie/amd64/bootnetx64.efi \
             --pxe-service=x86PC,"Install Linux",pxelinux \
             --enable-tftp --tftp-root=/var/lib/tftpboot \
             --no-daemon
             
# Successfully net boot using uefi and install debian.
# Going to work on preseed cfg


