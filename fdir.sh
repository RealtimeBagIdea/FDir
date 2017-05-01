#!/bin/bash

#-------------- How to use -----------------#
# 1 move this file to /usr/bin
# 2 sudo chmod 777 /usr/bin/rbin.sh
# 3 create ~/.fdirrc (touch ~/.fdirrc)
# 4 add source ~/.fdirrc to your bashrc
# 5 re-open terminal
#-------------------------------------------#

#-------------------------------- Update -------------------------------------------------------------------#
#-------+---------------------------------------------------------------------------------------------------#
#  Ver  |   Detail                                                                                          |
#-------+---------------------------------------------------------------------------------------------------#

VERSION="1.0"

#Get Logined User
CURRENTUSER=$(who | cut -d' ' -f1)

#Variable
CONFIG_FILE="/home/$CURRENTUSER/.fdirrc"

#==================== METHOD =======================#
ShowError() 
{
    echo "Command is not correct, see fdir.sh -h"
    echo ""
}

Save()
{
    if [ "$1" != "" ]; then
        #Check if exists
        IS_EXISTS=$(cat $CONFIG_FILE | grep "alias fd_$1=")
        if [ "$IS_EXISTS" == "" ]; then
            CORRECT_PATH=$(echo $PWD | sed "s/\s/\\\ /g")
            echo "alias fd_$1=\"cd $CORRECT_PATH\"" >> $CONFIG_FILE
            echo "Add $1 to $PWD"
            echo ""
        else
            echo "Key $1 is exist"
            echo ""
        fi
    else
        ShowError
    fi
}

Remove()
{
    if [ "$1" != "" ]; then
        sed -i "/alias fd_$1=.*$/d" $CONFIG_FILE
        echo "Remove $1 successfully"
        echo ""
    else
        ShowError
    fi
}

List()
{
    FILE=$(cat $CONFIG_FILE | sed -e "s/alias fd_//g")
    FILE=$(echo $FILE | sed -e "s/=\"cd /=/g")
    FILE=$(echo $FILE | sed -e "s/\"//g")
    FILE=$(echo $FILE | sed -e "s/\\\ /#SPACE#/g")

    for i in ${FILE[@]}
    do
        echo $(echo $i | sed -e "s/#SPACE#/ /g")
    done
    echo ""
}

Help()
{
    echo -e "Use for Edit: \t fdir.sh [OPTION]"
    echo -e "Use for Move: \t fd_<key>"
    echo -e "[OPTION]"
    echo -e "\t-s <key> \tLink <key> to current directory"
    echo -e "\t-r <key> \tRemove <key>"
    echo -e "\t-l \t\tList all <key>"
    echo -e "\t-v \t\tShow version"
    echo -e "[EXAMPLE]"
    echo -e "\t#Terminal 1"
    echo -e "\t\t$ cd /path/to/dir"
    echo -e "\t\t$ fdir.sh -s mydir"
    echo -e "\t#Terminal 2"
    echo -e "\t\t$ fd_mydir"
}


#==================== MAIN =======================#
#Check if no config, and generate it
if [ ! -f $CONFIG_FILE ]; then
    touch $CONFIG_FILE
fi
if [ "$1" == "-s" ]; then
    Save $2
elif [ "$1" == "-r" ]; then
    Remove $2
elif [ "$1" == "-l" ]; then
    List   
elif [ "$1" == "-h" ]; then
    Help
elif [ "$1" == "-v" ]; then
    echo "Version: $VERSION" 
    echo ""
else
    ShowError
fi
