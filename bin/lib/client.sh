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
    eval $(~/bin/lib/parse_client_data ~/.client_data.yml $CLIENT CLIENT_DATA | tr '\n' ';')
}
