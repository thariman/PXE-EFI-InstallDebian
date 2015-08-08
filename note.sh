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
