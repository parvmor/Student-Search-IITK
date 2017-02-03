
superGen() {
    gender=""
    PS3="Please choose the required gender:"
    select gen in "M" "F"
    do
        flag="0"
        for temp in "M" "F"
        do
            if [ "${temp}" = "${gen}" ]; then
                flag="1"
                break
            fi
        done
        if [ "$flag" = "0" ]; then
            echo "No such gender exists"
            cd "${PWD}"
            PS3="Pick an Option(Enter 9 or Ctrl-C to exit the search): "
            return
        fi
        gender="${gen}"
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
                    gen=`cat Gender`
                    if [ "$gen" = "$gender" ]; then
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
