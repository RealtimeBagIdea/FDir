#!/bin/bash

#-------------- How to use -----------------#
# 1 move this file to /usr/bin
# 2 sudo chmod 777 /usr/bin/fdir.sh
# 3 create ~/.fdirrc (touch ~/.fdirrc)
# 4 add source ~/.fdirrc to your bashrc
# 5 re-open terminal
#-------------------------------------------#

#-------------------------------- Update -------------------------------------------------------------------#
#-------+---------------------------------------------------------------------------------------------------#
#  Ver  |   Detail                                                                                          |
#-------+---------------------------------------------------------------------------------------------------#
#  1.1  |   Add Prefix Editor
#-------+---------------------------------------------------------------------------------------------------#



#------------------------------- USER CONFIG ---------------------------------------------------------------#

PREFIX_="fd-"
FILENAME_=".fdirrc"
SAVE_FLAG_="-s"
REMOVE_FLAG_="-r"
LIST_FLAG_="-l"

#-------------------------------- END CONFIG ---------------------------------------------------------------#


VERSION="1.1"

#Variable
CURRENTUSER=$(whoami)

if [ "$CURRENTUSER" == "root" ]; then
    CONFIG_FILE="/$CURRENTUSER/$FILENAME_"
else
    CONFIG_FILE="/home/$CURRENTUSER/$FILENAME_"
fi

#==================== METHOD =======================#
ShowError() 
{
    echo "Command is not correct, see fdir.sh -h"
    echo ""
}

Save()
{
    if [ "$1" != "" ]; then
        IS_EXISTS=$(cat $CONFIG_FILE | grep "alias $PREFIX_$1=")
        if [ "$IS_EXISTS" == "" ]; then
            CORRECT_PATH=$(echo $PWD | sed "s/\s/\\\ /g")
            echo "alias $PREFIX_$1=\"cd $CORRECT_PATH\"" >> $CONFIG_FILE
            echo "Add '$1' to $PWD"
            echo ""
        else
            echo "Key '$1' is exist"
            echo ""
        fi
    else
        ShowError
    fi
}

Remove()
{
    if [ "$1" != "" ]; then
        IS_EXISTS=$(cat $CONFIG_FILE | grep "alias $PREFIX_$1=")
        if [ "$IS_EXISTS" == "" ]; then
            echo "Key '$1' not found"
            echo ""
        else
            sed -i "/alias $PREFIX_$1=.*$/d" $CONFIG_FILE
            echo "Remove '$1' successfully"
            echo ""
        fi
    else
        ShowError
    fi
}

List()
{
    FILE=$(cat $CONFIG_FILE | sed -e "s/alias $PREFIX_//g")
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
    echo -e "Use for Move: \t <prefix><key> (Prefix can setting in this script. Default is fe-)"
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
    echo -e "\t\t$ fd-mydir"
}


#==================== MAIN =======================#
#Check if no config file, and generate it
if [ ! -f $CONFIG_FILE ]; then
    echo "" > $CONFIG_FILE
fi

if [ "$1" == "$SAVE_FLAG_" ]; then
    Save $2
elif [ "$1" == "$REMOVE_FLAG_" ]; then
    Remove $2
elif [ "$1" == "$LIST_FLAG_" ]; then
    List   
elif [ "$1" == "-h" ]; then
    Help
elif [ "$1" == "-v" ]; then
    echo "Version: $VERSION" 
    echo ""
else
    ShowError
fi

