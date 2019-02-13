#!/bin/sh


echo Installing JAVA:

	sudo apt -y install default-jdk
	sudo apt -y install default-jre

echo Installing RStudio
	
	sudo echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" | sudo tee -a /etc/apt/sources.list
	gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
	gpg -a --export E084DAB9 | sudo apt-key add -
	sudo apt-get update
	sudo apt-get -y install r-base r-base-dev
	wget -c https://download1.rstudio.org/rstudio-xenial-1.1.456-amd64.deb
	sudo dpkg -i rstudio-xenial-1.1.456-amd64.deb
	rm rstudio-xenial-1.1.456-amd64.deb
	sudo apt-get -f install	

echo Installing via QIIME deploy packages

	sudo apt-get -y install python-dev libncurses5-dev libssl-dev libzmq-dev libgsl0-dev libxml2 libxslt1.1 libxslt1-dev ant git subversion build-essential zlib1g-dev libpng12-dev libfreetype6-dev mpich libreadline-dev gfortran unzip ghc sqlite3 libsqlite3-dev libc6-i386 libbz2-dev tcl-dev tk-dev r-base r-base-dev libatlas-dev libatlas-base-dev liblapack-dev swig libhdf5-serial-dev

echo Installing numpy, h5py and upgrade pip
 
	sudo apt-get -y install build-essential python-dev python-pip
	sudo pip install --upgrade pip
	sudo pip install numpy
	sudo pip install h5py

echo Installing STAMP, QIIME and matplotlib through pip

	sudo apt-get -y install libblas-dev liblapack-dev gfortran
	sudo apt-get -y install freetype* python-pip python-dev python-numpy python-scipy python-matplotlib
	sudo apt-get -y install python-qt4
	sudo pip install STAMP
	sudo pip install qiime
	sudo pip install matplotlib==1.4.3		# This is the required version for QIIME to run.
	sudo apt-get -y upgrade

echo Installing the QIIME deploy: FULL QIIME Version

	mkdir $HOME/QIIME
	cd $HOME/QIIME/
	git clone git://github.com/qiime/qiime-deploy.git
	git clone git://github.com/qiime/qiime-deploy-conf.git
	cd qiime-deploy/
	python qiime-deploy.py $HOME/QIIME/ -f $HOME/QIIME/qiime-deploy-conf/qiime-1.9.1/qiime.conf --force-remove-failed-dirs
	source $HOME/.bashrc
	cd $HOME/QIIME
	rm qiime-deploy
	rm qiime-deploy-conf

echo Instalando Complementos para QIIME:
	echo SeqPrep
	cd
	cd $HOME/QIIME/
	git clone https://github.com/jstjohn/SeqPrep
	cd SeqPrep
	make
	sudo echo 'export PATH=$HOME/QIIME/SeqPrep:$PATH' >> $HOME/.bashrc
	
	echo fastq-join		
	cd $HOME/QIIME/	
	git clone https://github.com/brwnj/fastq-join
	cd fastq-join
	make
	sudo echo 'export PATH=/$HOME/QIIME/fastq-join/:$PATH' >> $HOME/.bashrc

	echo PICRUSt:
	cd $HOME/QIIME/
	git clone git://github.com/picrust/picrust.git picrust
	cd picrust/picrust/data/
	wget -c http://kronos.pharmacology.dal.ca/public_files/picrust/picrust_precalculated_v1.1.1/13_5/16S_13_5_precalculated.tab.gz
	wget -c http://kronos.pharmacology.dal.ca/public_files/picrust/picrust_precalculated_v1.1.1/13_5/ko_13_5_precalculated.tab.gz
	wget -c http://kronos.pharmacology.dal.ca/public_files/picrust/picrust_precalculated_v1.1.1/13_5/rfam_13_5_precalculated.tab.gz
	wget -c http://kronos.pharmacology.dal.ca/public_files/picrust/picrust_precalculated_v1.1.1/13_5/ko_13_5_precalculated.tab.gz
	cd $HOME/QIIME/picrust
	sudo pip install .

echo Update and Clean the system:

	sudo apt-get -y update
	sudo apt-get -y upgrade
	sudo apt-get -y dist-upgrade
	sudo apt-get -f install
	sudo apt-get -y autoremove
	sudo apt-get autoclean
	
echo Manually install the USEARCH Binaries: move them to PATH.

	sudo mv usearch* /usr/local/bin/
	sudo chmod +x /usr/local/bin/usarch*
	
## Eliminating me:
#	rm $HOME/QIIME_from_Scratch.sh
	
exit
