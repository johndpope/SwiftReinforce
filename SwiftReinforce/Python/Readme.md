
**setting up miniconda**
brew install wget
wget https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
chmod +x Miniconda3-latest-MacOSX-x86_64.sh
./Miniconda3-latest-MacOSX-x86_64.sh


**Add conda to user path**
for zsh 
code ~/.zshrc
export PATH="/Users/jpope/miniconda3/bin:$PATH"
RESTART TERMINAL!!

//nn.Module

// if you see - Thread 1: Fatal error: 'try!' expression unexpectedly raised an error: Python exception: Env Pong-v4 not found (valid versions include ['Pong-v3', 'Pong-v0'])
/*
conda create -n gymai  python=2.7.9
source activate gymai
pip install --upgrade pip
pip install "gym[atari]"


pip install sympy
pip install antlr4-python2-runtime
pip install sklearn

*/


WIP - work in progress
pip install Cython
conda install -c soumith pytorch // goal is to get let torch = Python.load("torch") working

