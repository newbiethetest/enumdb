#!/usr/bin/env bash

# Author: m8r0wn
# Script: setup.sh

# Description:
# enumdb setup script to verify all required packages
# are installed on the system.

#Check if Script run as root
if [[ $(id -u) != 0 ]]; then
	echo -e "\n[!] Setup script needs to run as root\n\n"
	exit 0
fi

echo -e "\n[*] Starting enumdb setup script"
echo -e "[*] Checking for Python 3"
if [[ $(python3 -V 2>&1) == *"not found"* ]]
then
    echo -e "[*] Installing Python3"
    apt-get install python3 -y
else
    echo "[+] Python3 installed"
fi

echo -e "[*] Checking for required enumdb libraries"
if [[ $(python3 -c "import MySQLdb" 2>&1) == *"No module"* ]]
then
    echo -e "[*] Installing python3-MySQLdb"
    apt-get install python3-pip
    apt-get install libmysqlclient-dev
    pip3 install mysqlclient
else
    echo "[+] MySQLdb installed"
fi

if [[ $(python3 -c "import pymssql" 2>&1) == *"No module"* ]]
then
    echo -e "[*] Installing python3-pymssql"
    apt-get install unixodbc unixodbc-dev freetds-dev freetds-bin tdsodbc
    pip3 install pymssql
    
else
    echo "[+] pymssql installed"
fi

if [[ $(python3 -c "import openpyxl" 2>&1) == *"No module"* ]]
then
    echo -e "[*] Installing python3-openpyxl"
    pip3 install openpyxl
else
    echo "[+] openpyxl installed"
fi

echo -e "\n[*] enumdb setup complete\n\n"
