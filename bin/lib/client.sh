. ~/bin/lib/yaml.sh

check_client() {
    if [[ -z "$CLIENT" && -z "$1" ]]
    then
        echo No client specified and CLIENT not set!
        unset
        unset LOWER_CLIENT
        exit -1
    elif [ -z "$CLIENT" ]
    then
        CLIENT=$1
    fi

    if [ -n "$CLIENT" ]
    then
        LOWER_CLIENT=${CLIENT,,}
    fi
}

read_client_data() {
    check_client $1
    eval $(parse_yaml ~/.client_data.yml CLIENT_DATA)
}

client_value() {
    if [ -z ${CLIENT_DATA[${CLIENT}[$2]]} ]
    then
        echo "No such client ($CLIENT) or key ($2)!"
        exit -1
    fi

    local result="${CLIENT_DATA[${CLIENT}[$2]]}"
    eval $1="'$result'"
}
