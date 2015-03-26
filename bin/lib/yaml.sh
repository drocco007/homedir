# modified from https://gist.github.com/pkuczynski/8665367
parse_yaml() {
    local array_name=$2

    echo declare -Ag $array_name \;

    local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
    sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
    awk -F$fs '{
        indent = length($1)/2;
        vname[indent] = $2;

        for (i in vname) {if (i > indent) {delete vname[i]}}

        if (length($3) > 0) {
            vn=""; for (i=1; i<indent; i++) {vn=(vn)(vname[i])("_")}
            printf("'$array_name'[%s[%s%s]]=\"%s\";\n", vname[0], vn, $2, $3);
      }
    }'
}
