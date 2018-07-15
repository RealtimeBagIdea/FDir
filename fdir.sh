#!/bin/bash

#-------------- How to use -----------------#
# 1 move this file to /usr/bin
# 2 run 'sudo chmod 777 /usr/bin/fdir.sh'
# 3 run 'fdir.sh init'
# 4 re-open terminal
#-------------------------------------------#

#-------------------------------- Update -------------------------------------------------------------------#
#-------+---------------------------------------------------------------------------------------------------#
#  Ver  |   Detail                                                                                          |
#-------+---------------------------------------------------------------------------------------------------#
#  1.1  |   Add Prefix Editor                                                                               |
#-------+---------------------------------------------------------------------------------------------------#
#  1.2  |   Add Init                                                                                        |
#-------+---------------------------------------------------------------------------------------------------#


#=============================== USER CONFIG ===============================================================#

PREFIX_="fd-"
SAVE_FLAG_="-s"
REMOVE_FLAG_="-r"
LIST_FLAG_="-l"
FILENAME_=".fdirrc" #If you change this value. You must edit your .bashrc

#================================ END CONFIG ===============================================================#


#Variable
VERSION="1.2"
CURRENTUSER=$(whoami)

#==================== SETUP ========================#

if [ "$CURRENTUSER" == "root" ]; then
    FD_HOME="/$CURRENTUSER"
else
    FD_HOME="/home/$CURRENTUSER"
fi
CONFIG_FILE=$FD_HOME/$FILENAME_

if [ ! -f $CONFIG_FILE ]; then
    echo "" > $CONFIG_FILE
fi

#==================== METHOD =======================#
Init ()
{
    read -p "Enter your shell init file (default: .bashrc) : " SHELLINIT 

    if [[ $SHELLINIT = "" ]]; then
        SHELLINIT=".bashrc"
    fi

    SHELLINIT="$FD_HOME/$SHELLINIT"

    IS_INITED=$(cat $SHELLINIT | grep "source $CONFIG_FILE")

    if [ "$IS_INITED" == "" ]; then
        echo "source $CONFIG_FILE" >> "$SHELLINIT"
        echo "Init successfully (You have to restart Terminal)"
    else
        echo "FDir init already"
    fi
    echo ""
}

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
    FILE=$(echo $FILE | sed -e "s/=\"cd /#TAB#=#SPACE#/g")
    FILE=$(echo $FILE | sed -e "s/\"//g")
    FILE=$(echo $FILE | sed -e "s/\\\ /#SPACE#/g")

    for i in ${FILE[@]}
    do
        DECODE=$(echo $i | sed -e "s/#SPACE#/ /g")
        DECODE=$(echo $DECODE | sed -e "s/#TAB#/\\t/g")
        echo -e "$DECODE"
    done
    echo ""
}

Help()
{
    echo -e "Use for Edit: \t fdir.sh [OPTION]"
    echo -e "Use for Move: \t <prefix><key> (Prefix can setting in this script. Default is fd-)"
    echo ""
    echo -e "[INIT]"
    echo -e "\tinit \tCreate '.fdirrc' file and add 'source ~/.fdirrc' to shell init file"
    echo ""
    echo -e "[OPTION]"
    echo -e "\t-s <key> \tLink <key> to current directory"
    echo -e "\t-r <key> \tRemove <key>"
    echo -e "\t-l \t\tList all <key>"
    echo -e "\t--clean \tDelete all key that points to un-exist directory <key>"
    echo -e "\t-v \t\tShow version"
    echo ""
    echo -e "[EXAMPLE]"
    echo -e "\t#Terminal 1"
    echo -e "\t\t$ cd /path/to/dir"
    echo -e "\t\t$ fdir.sh -s mydir"
    echo -e "\t#Terminal 2"
    echo -e "\t\t$ fd-mydir"
}

RemoveGarbageKeyPrompt()
{
    echo -n "Delete the keys that point to an un-exist directory? (y/n) : "
    read RESULT
    case $RESULT in
        [yY]* ) RemoveGarbageKey;;
        [nN]* ) exit;;
    esac
}

RemoveGarbageKey()
{
    echo "Check if key points to exist directory..."
    cp /dev/null ${CONFIG_FILE}_temp

    cat $CONFIG_FILE | while read -r line ; do
        DIR=$(echo $line | grep -o "/.*[^\"]")
        KEY=$(echo $line | grep -o "$PREFIX_[[:alnum:]]*")

        if [ -d $DIR ]; then
            echo $line >> ${CONFIG_FILE}_temp
        else
            echo "Remove key : $KEY"
        fi
    done

    cp $CONFIG_FILE "${CONFIG_FILE}_backup"
    mv ${CONFIG_FILE}_temp $CONFIG_FILE

    echo "Backup of an old file has been saved to : ${CONFIG_FILE}_backup"
}

#==================== MAIN =======================#

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
elif [ "$1" == "init" ]; then
    Init
elif [ "$1" == "--clean" ]; then
    RemoveGarbageKeyPrompt
else
    ShowError
fi
