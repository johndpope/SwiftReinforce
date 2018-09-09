#  SwiftReinforce

## Introduction
Implementation of the Reinforce algorithm using Swift for Tensorflow.

## Install Swift for Tensorflow
This project is based on Swift for Tensorflow. To install Swift for Tensorflow visit [https://github.com/tensorflow/swift/](https://github.com/tensorflow/swift/blob/master/Installation.md).

The Tensorflow library for Swift is published in the [stdlib/public/TensorFlow](https://github.com/apple/swift/tree/tensorflow/stdlib/public/TensorFlow) directory.

Make sure to change the Xcode build system to legacy (File > Project Settings > Build System).

## Install OpenAI Gym
Take the following steps to install OpenAI Gym using Virtualenv:

      
     
## Install these for gymai
(if sdl2 fails / try proceeding without it)
```
brew install cmake boost boost-python sdl2 swig wget
```


## CONDA     - critical use 2.7.9 to avoid missing python symbols  (__PyCodecInfo_GetIncrementalDecoder)     
https://conda.io/docs/_downloads/conda-cheatsheet.pdf     
      
```
conda create -n gymai  python=2.7.9
source activate gymai
pip install --upgrade pip
pip install "gym[atari]"

```
     
     
     
To connect the conda environment / (which has been activated) - we need to configure  
         
schema >  wait for executable to be launched.     
## (Cmd+R - will NOW wait for you to drop into terminal)   
    
![alt text](https://user-images.githubusercontent.com/289994/45244356-6786f780-b2c5-11e8-883a-17c02bf22d91.png)    
![alt text](https://user-images.githubusercontent.com/289994/45247646-fd774e00-b2d6-11e8-8058-b96a1ff6f270.png)


To find the executable build path - right mouse click on target - and find the binary
![alt text](https://user-images.githubusercontent.com/289994/45244355-6786f780-b2c5-11e8-9ed7-c379b70974b4.png)   <!-- .element height="50%" width="50%" -->  

Just drag the file into terminal to copy the path. now use source activate to configure python envronment

```
source activate gymai
./SwiftReinforce
```


(iterm2 / to see which python environment is activated / as well as which git branch you're on - I recommend using zsh / oh-my-zsh https://github.com/robbyrussell/oh-my-zsh)
![alt text](https://user-images.githubusercontent.com/289994/45244296-37d7ef80-b2c5-11e8-81c3-e8e59afe234f.png)

=======
## Requirements
* Xcode 10.0 beta or later
* Swift for TensorFlow 2018-09-05

## Results
### FrozenLake
```
0 0.00 0.0
2000 0.01 1.1
4000 0.05 0.7
6000 0.03 0.7
8000 0.05 0.7
10000 0.07 0.8
12000 0.20 0.8
14000 0.36 0.8
16000 0.62 0.8
18000 0.78 0.8
20000 0.86 0.8
8.073721319
```
### Pong
Performance after 1e6 steps:
```
0 0.00 0.0
40000 -20.40 65.4
80000 -20.20 64.4
120000 -20.30 64.4
160000 -20.10 66.8
200000 -19.30 68.0
240000 -19.10 72.4
280000 -18.70 71.1
320000 -18.50 72.4
360000 -19.30 71.9
400000 -18.30 67.1
440000 -18.30 68.6
480000 -18.30 74.1
520000 -18.70 68.2
560000 -17.80 66.1
600000 -17.50 67.4
640000 -18.00 65.4
680000 -18.40 66.7
720000 -17.40 68.2
760000 -16.60 65.7
800000 -16.10 66.4
840000 -18.00 66.4
880000 -17.30 67.8
920000 -16.60 68.1
960000 -18.30 68.6
1000000 -17.30 66.1
```
