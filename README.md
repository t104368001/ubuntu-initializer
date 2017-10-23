# Simple Install 
	sudo apt-get -y upgrade
	sudo apt-get -y update
	chmod +x ./Auto_install.sh
Run Auto_install.sh until finish
	
	./Auto_install.sh
	
	
# Step by Step

# Initial ubuntu 16.04
	sudo apt-get upgrade
	sudo apt-get update
	sudo apt-get install nvidia-375
	reboot
Do this step to get last nvidia driver version
	
	sudo add-apt-repository ppa:graphics-drivers/ppa
	sudo apt-get update

# Ros-Kinetic install
	sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
	sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
	sudo apt-get update
	sudo apt-get install ros-kinetic-desktop-full
	sudo rosdep init
	rosdep update
	echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
	source ~/.bashrc
	source /opt/ros/kinetic/setup.bash
	sudo apt-get install python-rosinstall
	sudo apt-get install python-pip
	pip install --upgrade pip

# Install cuda
https://developer.nvidia.com/cuda-downloads

	cd ~/Downloads
	wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb
	sudo apt-get install nvidia-cuda-toolkit
	sudo dpkg -i cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64.deb
	sudo apt-get update
	sudo apt-get install cuda
	echo "export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}" >> ~/.bashrc
	echo "export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}" >> ~/.bashrc
# Initial cudnn
https://developer.nvidia.com/rdp/cudnn-download

	cd ~/Download
	wget https://www.dropbox.com/s/onxtezymyo9fq2q/cudnn-8.0-linux-x64-v5.1.tgz
	tar -xvzf cudnn-8.0-linux-x64-v5.1.tgz 
	sudo cp -P cuda/include/cudnn.h /usr/local/cuda/include
	sudo cp -P cuda/lib64/libcudnn* /usr/local/cuda/lib64
	sudo chmod a+r /usr/local/cuda/lib64/libcudnn*
	reboot
# Initial opencv
	cd ~
	git clone https://github.com/daveselinger/opencv.git
	wget -O https://codeload.github.com/opencv/opencv_contrib/zip/3.1.0
	unzip opencv_contrib.zip
	cd opencv
	mkdir build
	sudo apt-get install cmake-gui
	cmake-gui
select opencv and opencv/build->configure->generate

	cd build
	cmake ..
	make -j8
	sudo make install
# Install bazel

	cd ~/Downloads
	echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
	curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add -
	sudo apt-get update && sudo apt-get install bazel
	sudo apt-get upgrade bazel
	sudo apt-get install openjdk-8-jdk
	sudo apt-get install pkg-config zip g++ zlib1g-dev unzip
	wget https://github.com/bazelbuild/bazel/releases/download/0.5.0/bazel-0.5.0-installer-linux-x86_64.sh
	chmod +x bazel-0.5.0-installer-linux-x86_64.sh
	./bazel-0.5.0-installer-linux-x86_64.sh --user
	echo "export PATH=\"$PATH:$HOME/bin\"" >> ~/.bashrc
	sudo apt-get install python-numpy python-dev python-pip python-wheel
	sudo apt-get install libcupti-dev 
# Initial tensorflow
https://www.tensorflow.org/install/install_sources
	
	cd ~
	sudo apt-get install python-pip python-dev build-essential 
	git clone https://github.com/tensorflow/tensorflow 
	cd tensorflow
	./configure
configure

	Please specify the location of python. [Default is /usr/bin/python]: 
	Found possible Python library paths:
	  /opt/ros/kinetic/lib/python2.7/dist-packages
	  /usr/local/lib/python2.7/dist-packages
	  /usr/lib/python2.7/dist-packages
	Please input the desired Python library path to use.  Default is [/opt/ros/kinetic/lib/python2.7/dist-packages]

	Using python library path: /opt/ros/kinetic/lib/python2.7/dist-packages
	Do you wish to build TensorFlow with MKL support? [y/N] 
	No MKL support will be enabled for TensorFlow
	Please specify optimization flags to use during compilation when bazel option "--config=opt" is specified [Default is -march=native]: 
	Do you wish to use jemalloc as the malloc implementation? [Y/n] 
	jemalloc enabled
	Do you wish to build TensorFlow with Google Cloud Platform support? [y/N] 
	No Google Cloud Platform support will be enabled for TensorFlow
	Do you wish to build TensorFlow with Hadoop File System support? [y/N] 
	No Hadoop File System support will be enabled for TensorFlow
	Do you wish to build TensorFlow with the XLA just-in-time compiler (experimental)? [y/N] 
	No XLA support will be enabled for TensorFlow
	Do you wish to build TensorFlow with VERBS support? [y/N] 
	No VERBS support will be enabled for TensorFlow
	Do you wish to build TensorFlow with OpenCL support? [y/N] 
	No OpenCL support will be enabled for TensorFlow
	Do you wish to build TensorFlow with CUDA support? [y/N] Y
	CUDA support will be enabled for TensorFlow
	Do you want to use clang as CUDA compiler? [y/N] N
	nvcc will be used as CUDA compiler
	Please specify the CUDA SDK version you want to use, e.g. 7.0. [Leave empty to use system default]: 8.0
	Please specify the location where CUDA 8.0 toolkit is installed. Refer to README.md for more details. [Default is /usr/local/cuda]: 
	Please specify which gcc should be used by nvcc as the host compiler. [Default is /usr/bin/gcc]: 
	Please specify the cuDNN version you want to use. [Leave empty to use system default]: 5.1.10
	Please specify the location where cuDNN 5.1.10 library is installed. Refer to README.md for more details. [Default is /usr/local/cuda]: 
	Please specify a list of comma-separated Cuda compute capabilities you want to build with.
	You can find the compute capability of your device at: https://developer.nvidia.com/cuda-gpus.
	Please note that each additional compute capability significantly increases your build time and binary size.
	[Default is: "3.5,5.2"]: 5.0
	Do you wish to build TensorFlow with MPI support? [y/N] 
	MPI support will not be enabled for TensorFlow
	INFO: Starting clean (this may take a while). Consider using --async if the clean takes more than several minutes.
	Configuration finished


	
Build the pip package

	bazel build --config=opt --config=cuda //tensorflow/tools/pip_package:build_pip_package 
	bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
	sudo pip install /tmp/tensorflow_pkg/tensorflow-1.2.0rc0-cp27-cp27mu-linux_x86_64.whl 
# Now try to use tensorflow
	
	cd ~
	python
		>>> import tensorflow as tf
		>>> hello = tf.constant('Hello, TensorFlow!')
		>>> sess = tf.Session()
		>>> print(sess.run(hello))
# Install chrome
https://www.google.com/chrome/

	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i google-chrome-stable_current_amd64.deb
	
# Install sublime
https://www.sublimetext.com/

	sudo add-apt-repository ppa:webupd8team/sublime-text-3
	sudo apt-get update
	sudo apt-get install sublime-text-installer
