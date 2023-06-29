#!/bin/bash
clear

# INSTALA PYTHON AO PYTHON2
apt-get install python -y >/dev/null 2>&1
apt-get install python2 -y >/dev/null 2>&1

# INSTALA PYTHON3.6 AO PYTHON3.9
apt-get install python3.6 -y >/dev/null 2>&1
apt-get install python3.7 -y >/dev/null 2>&1
apt-get install python3.8 -y >/dev/null 2>&1
apt-get install python3.9 -y >/dev/null 2>&1

# CRIA ALTERNATIVAS PYTHON
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1 >/dev/null 2>&1
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 3 >/dev/null 2>&1
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 2 >/dev/null 2>&1
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 4 >/dev/null 2>&1

# INSTALA PIP
apt install pip -y
apt install python3-pip -y

# INSTALA SOCAT
apt install socat -y

#SETAR PYTHON3
update-alternatives --set python3 /usr/bin/python3.6