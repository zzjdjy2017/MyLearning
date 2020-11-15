#!/bin/bash 
# ostype(): Define OSTYPE variable to current operating system
ostype()
{
    osname=`uname -s`
    #Assume we do not know what this is
    OSTYPE=UNKNOWN
    case $osname in
        "FreeBSD") OSTYPE="FREEBSD"
        ;;
        "SunOS") OSTYPE="SOLARIS"
        ;;
        "Linux") OSTYPE="LINUX"
        ;;
    esac
    return 0
}

# evenodd(): Check a number is even or odd
evenodd()
{
    # Determine odd/even status by last digit
    LAST_DIGIT=`echo $1 | sed 's/\(.*\)\(.\)$/\2/'`
    case $LAST_DIGIT in
        0|2|4|6|8 )
            return 1
        ;;
        *)
            return 0
        ;; 
    esac
}

# isalive(): Determine whether a remote system is running and connected to the network
isalive()
{
    NODE=$1
    ping -c 3 $NODE >/dev/null 2>&1
    if [ $? -eq 0 ]
    then
        return 1
    else
        return 0
    fi
}

# checkportinuse(): Check if port is in use
checkportinuse()
{
    PORT=$1
    sudo lsof -i -P -n | grep $PORT >/dev/null 2>&1
    if [ $? -eq 0 ]
    then
        echo "$PORT is in use"
        return 0
    else
        echo "$PORT isn't in use"
        return 1
    fi
}
