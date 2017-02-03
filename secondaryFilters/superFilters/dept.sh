
superDept() {
    department=""
    PS3="Please choose the required department:"
    select dept in "${departments[@]}"
    do
        flag="0"
        for temp in "${departments[@]}"
        do
            if [ "${temp}" = "${dept}" ]; then
                flag="1"
                break
            fi
        done
        if [ "$flag" = "0" ]; then
            echo "No such department exists"
            cd "${PWD}"
            PS3="Pick an Option(Enter 9 or Ctrl-C to exit the search): "
            return
        fi
        department="${dept}"
        break
    done
    touch "${scriptPath}/temp/tempStor"
    while read line
    do
        year="${line:0:2}"
        if [ "$line" -eq "$line" ] 2>/dev/null; then
            :
        else
            echo "error: Not a Number" >> "temp/tempStor"
            continue
        fi
        cd "${scriptPath}/data/Students"
            cd "Y${year}"
                cd "${line}"
                    dept=`cat Department`
                    if [ "${dept}" = "${department}" ]; then
                        echo "${line}" >> "../../../../temp/tempStor"
                    fi
                cd ..
            cd ..
        cd ../..
    done < "temp/$1"
    cp "temp/tempStor" "temp/$1"
    rm "temp/tempStor"
    PS3="Pick an Option(Enter 9 or Ctrl-C to exit the search): "
    cd "${PWD}"
    return
}
