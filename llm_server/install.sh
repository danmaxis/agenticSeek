#!/bin/bash

pip3 install --upgrade packaging
pip3 install --upgrade pip setuptools
curl -fsSL https://ollama.com/install.sh | sh
pip3 install --no-cache-dir -r requirements.txt -r requirements_extra.txt -r requirements_ai.txt
