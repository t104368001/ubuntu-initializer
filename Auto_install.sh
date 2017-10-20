#!/bin/bash 
filename=~/Downloads/step.txt #
flag=0 #
if [ -f "$filename" ];then #
	while IFS='' read -r line || [[ -n "$line" ]]; do #
		if [[ $line == 0 ]]; then #
			echo "Ubuntu Initial" #
			echo "Just use Auto_install.sh until finish" #
			sudo apt-get -y upgrade #
			sudo apt-get -y update #
			sudo apt-get -y install nvidia-375 #
			cd ~/Downloads #
			wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb #
			sudo add-apt-repository ppa:webupd8team/sublime-text-3 #
			sudo apt-get update #
			sudo apt-get install sublime-text-installer #
			sudo dpkg -i google-chrome-stable_current_amd64.deb #
			echo '1' > ~/Downloads/step.txt #
			reboot #
		fi #
		if [ $line == 1 ]; then #
			echo "Ros-Kinetic install" #
			sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' #
			sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116 #
			sudo apt-get -y update #
			sudo apt-get -f -y install #
			sudo apt-get -y install ros-kinetic-desktop-full #
			sudo rosdep init #
			rosdep update #
			echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc #
			source ~/.bashrc #
			source /opt/ros/kinetic/setup.bash #
			sudo apt-get -y install python-rosinstall #
			sudo apt-get -y install python-pip #
			pip install --upgrade pip #
			echo '2' >> ~/Downloads/step.txt #
		fi #
		if [ $line == 2 ]; then #
			echo "Install cuda" #
			cd ~/Downloads #
			wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb #
			sudo apt-get -y install nvidia-cuda-toolkit #
			sudo dpkg -i cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb #
			sudo apt-get -y update #
			sudo apt-get -y install cuda #
			echo "export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}" >> ~/.bashrc #
			echo "export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}" >> ~/.bashrc #
			source ~/.bashrc #
			echo '3' >> ~/Downloads/step.txt #
		fi #
		if [ $line == 3 ]; then #
			echo "Install cudnn" #
			cd ~/Download #
			wget https://www.dropbox.com/s/onxtezymyo9fq2q/cudnn-8.0-linux-x64-v5.1.tgz #
			tar -xvzf cudnn-8.0-linux-x64-v5.1.tgz #
			sudo cp -P cuda/include/cudnn.h /usr/local/cuda/include #
			sudo cp -P cuda/lib64/libcudnn* /usr/local/cuda/lib64 #
			sudo chmod a+r /usr/local/cuda/lib64/libcudnn* #
			echo '4' >> ~/Downloads/step.txt #
			reboot #
		fi #
		if [ $line == 4 ]; then #
			echo "Install opencv" #
			cd ~ #
			git clone https://github.com/daveselinger/opencv.git #
			cd opencv #
			mkdir build #
			sudo apt-get -y install cmake-gui #
			echo "Step 1 : Select opencv and opencv/build" #
			echo "Step 2 : Press configure" #
			echo "Step 3 : Press generate" #
			echo "Step 4 : Exit and run \"Auto_install.sh\" again" #
			cmake-gui #
			cd ~/opencv/build #
			cmake .. #
			make -j8 #
			sudo make install #
			echo '5' >> ~/Downloads/step.txt #
		fi #
		if [ $line == 5 ]; then #
			echo "Install bazel" #
			cd ~/Downloads #
			echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list #
			curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add - #
			sudo apt-get -y update && sudo apt-get -y install bazel #
			sudo apt-get -y upgrade bazel #
			sudo apt-get -y install openjdk-8-jdk #
			sudo apt-get -y install pkg-config zip g++ zlib1g-dev unzip #
			wget https://github.com/bazelbuild/bazel/releases/download/0.5.0/bazel-0.5.0-installer-linux-x86_64.sh #
			chmod +x bazel-0.5.0-installer-linux-x86_64.sh #
			./bazel-0.5.0-installer-linux-x86_64.sh --user #
			echo "export PATH=\"$PATH:$HOME/bin\"" >> ~/.bashrc #
			source ~/.bashrc #
			sudo apt-get -y install python-numpy python-dev python-pip python-wheel #
			sudo apt-get -y install libcupti-dev #
			echo '6' >> ~/Downloads/step.txt #
		fi #
		if [ $line == 6 ]; then #
			echo "Install tensorflow" #
			cd ~ #
			sudo apt-get -y install python-pip python-dev build-essential #
			git clone https://github.com/tensorflow/tensorflow #
			flag=1 #
			echo '7' >> ~/Downloads/step.txt #
		fi #
		if [ $line == 7 ]; then #
			echo "Already Finished !" #
		fi #
	done < "$filename" #
	if [ $flag = 1 ]; then #
		cd ~/tensorflow #
		./configure #
		bazel build --config=opt --config=cuda //tensorflow/tools/pip_package:build_pip_package #
		bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg #
		sudo pip install /tmp/tensorflow_pkg/tensorflow-1.2.0rc1-cp27-cp27mu-linux_x86_64.whl #
		echo "Finish !Congratulation ! And enjoy your system ^_^" #
	fi #
else #
	echo "Reset finish !" #
	echo '0' > ~/Downloads/step.txt #
fi #
