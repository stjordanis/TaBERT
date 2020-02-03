#!/usr/bin/env bash

echo "----------------- Check Env -----------------"
nvidia-smi
nvcc -V
python -V
python -c 'import torch; print(torch.__version__)'

echo "----------------- Check File System -----------------"
echo "I am " $(whoami)
echo -n "CURRENT_DIRECTORY "
pwd

echo "---------------- Update Conda Environment ---------------"
echo "Updating conda environment"
conda env update --file scripts/env.yml

PWD_DIR=$(pwd)

echo "----------------- Install Apex -----------------"
mkdie -p third_party
git clone -q https://github.com/NVIDIA/apex.git third_party/apex
cd third_party/apex
# python setup.py install --cuda_ext --cpp_ext
pip install -v --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" --global-option="--deprecated_fused_adam" ./

cd ${PWD_DIR}