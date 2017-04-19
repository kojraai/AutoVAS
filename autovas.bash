# Create the target
TARGET_RETURN=$(omp -h 127.0.0.1 -u $USER -w $OPASS -p 9390 --xml="\
TARGET_RETURN=$(omp -h 127.0.0.1 -u $USER -w $OPASS -p 9390 --xml="\
    <create_target>\
        <name>$1</name>\
        <hosts>$2</hosts>\
    </create_target>")

echo "$TARGET_RETURN" | grep -m1 'resource created' || exit 1 

function sindex {
    x="${1%%$2*}"
    [[ $x = $1 ]] && echo -1 || echo ${#x}
}

# Get the target ID
T_ID_INDEX=$(sindex "$TARGET_RETURN" "id=") 
T_ID_INDEX=$((T_ID_INDEX + 4)) 
T_ID=${TARGET_RETURN:T_ID_INDEX:36}

# Get the config ID
#C_ID=$(omp -h 127.0.0.1 -u $USER -w $OPASS -p 9390 -g | grep -i "Full and fast") 
#C_ID=${C_ID:0:36}

if [ "$3" == "dis" ]
        then
                C_ID=$(omp -h 127.0.0.1 -u $USER -w $OPASS -p 9390 -g | cut -d  " " -f 1  | sed '1!d')
                echo $C_ID
        else
                echo "Unknow scan type"
fi

if [ "$3" == "faf" ]
        then
                C_ID=$(omp -h 127.0.0.1 -u $USER -w $OPASS -p 9390 -g | cut -d  " " -f 1  | sed '3!d')
echo $C_ID
fi

if [ "$3" == "fafu" ];
        then
                C_ID=$(omp -h 127.0.0.1 -u $USER -w $OPASS -p 9390 -g | cut -d  " " -f 1  | sed '4!d')
echo $C_ID
fi

if [ "$3" == "favd" ];
        then
                C_ID=$(omp -h 127.0.0.1 -u $USER -w $OPASS -p 9390 -g | cut -d  " " -f 1  | sed '5!d')
echo $C_ID
fi

if [ "$3" == "favdu" ];
        then
                C_ID=$(omp -h 127.0.0.1 -u $USER -w $OPASS -p 9390 -g | cut -d  " " -f 1  | sed '6!d')
echo $C_ID
fi

if [ "$3" == "hd" ];
        then
                C_ID=$(omp -h 127.0.0.1 -u $USER -w $OPASS -p 9390 -g | cut -d  " " -f 1  | sed '7!d')
echo $C_ID
fi

if [ "$3" == "sd" ];
        then
                C_ID=$(omp -h 127.0.0.1 -u $USER -w $OPASS -p 9390 -g | cut -d  " " -f 1  | sed '8!d')
echo $C_ID
fi


# Create task
T_ID=$(omp -h 127.0.0.1 -u $USER -w $OPASS -p 9390 -C -n "$4" --target="$T_ID" --config="$C_ID")
echo "scan started please wait ..."
# Start task
R_ID=$(omp -h 127.0.0.1 -u $USER -w $OPASS -p 9390 -S "$T_ID")
>&2 echo "Scan started check "
#echo " $R_ID"
>&2 echo "https://YOURSERVERIP/omp?cmd=get_report&report_id=$R_ID&notes=1&overrides=&apply_min_qod=0&min_qod=&result_hosts_only=1&token=3a99c5bc-5907-471c-9ee2-f19a06ce73b0"

