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


To find the executable build path - right mouse click on target - and find the binary
![alt text](https://user-images.githubusercontent.com/289994/45244355-6786f780-b2c5-11e8-9ed7-c379b70974b4.png)

Just drag the file into terminal to copy the path. now use source activate to configure python envronment

```
source activate gymai
/SwiftReinforce
```

(iterm2 / to see which python environment is activated / as well as which git branch you're on - I recommend using zsh / oh-my-zsh https://github.com/robbyrussell/oh-my-zsh)
![alt text](https://user-images.githubusercontent.com/289994/45244296-37d7ef80-b2c5-11e8-81c3-e8e59afe234f.png)


## Results
### FrozenLake
```
0 0.00 0.0
2000 0.01 1.1
4000 0.05 1.0
6000 0.03 1.0
8000 0.05 1.0
10000 0.07 1.0
12000 0.20 1.0
14000 0.36 1.0
16000 0.62 1.0
18000 0.78 1.0
20000 0.86 1.0
10.023599785
```
### Pong
Performance after 1e6 steps:
```
0 0.00 0.0
40000 -20.40 69.4
80000 -20.20 66.1
120000 -20.30 67.4
160000 -20.10 73.3
200000 -19.30 69.4
240000 -19.10 69.6
280000 -18.70 66.7
320000 -18.50 66.8
360000 -19.30 68.4
400000 -18.30 66.1
440000 -18.30 69.2
480000 -18.30 69.2
520000 -18.70 69.6
560000 -17.80 66.0
600000 -17.50 65.4
640000 -18.00 65.3
680000 -18.40 65.5
720000 -17.40 65.7
760000 -16.60 65.3
800000 -16.10 65.4
840000 -18.00 65.3
880000 -17.30 65.3
920000 -16.60 65.7
960000 -18.30 66.4
1000000 -17.30 69.0
```
