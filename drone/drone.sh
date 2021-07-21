yum update
yum install -y yum-utils device-mapper-persistent-data lvm2 gcc zlib-devel openssl-devel squashfs-tools mesa-libGL-devel make iproute-tc kernel-modules-extra kernel-debug-modules-extra
yum remove -y python3
adduser -d /home/drone -m drone
echo 'drone ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
#Install Singularity
SINGULARITY_VERSION=2.6.0
parent_dir=`pwd`
wget https://github.com/sylabs/singularity/releases/download/${SINGULARITY_VERSION}/singularity-${SINGULARITY_VERSION}.tar.gz
tar xvf singularity-${SINGULARITY_VERSION}.tar.gz
cd singularity-${SINGULARITY_VERSION}
./configure --prefix=/usr/local
make && make install
cd $parent_dir
rm -r singularity-${SINGULARITY_VERSION}
rm singularity-${SINGULARITY_VERSION}.tar.gz

cd /root
/usr/bin/wget https://www.python.org/ftp/python/3.7.9/Python-3.7.9.tgz
/usr/bin/tar -xzf Python-3.7.9.tgz
cd /root/Python-3.7.9
./configure 
make altinstall
/usr/local/bin/pip3.7 install pika
/usr/local/bin/pip3.7 install requests
/usr/local/bin/pip3.7 install geojson
/usr/local/bin/pip3.7 install geopy
/usr/local/bin/pip3.7 install opencv-python

/bin/su - drone -c "/usr/bin/wget https://emmy8.casa.umass.edu/flynetDemo/ffmpeg.simg"
/bin/su - drone -c "/usr/bin/wget https://emmy8.casa.umass.edu/flynetDemo/drone/video_data.tar; /bin/tar -xf video_data.tar"
/bin/mv /root/flynetDemo/drone/* /home/drone
chown -R drone /home/drone
chgrp -R drone /home/drone
reboot


