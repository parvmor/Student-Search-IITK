
superHall() {
    Hall=""
    PS3="Please choose the required hall:"
    select hall in "${halls[@]}"
    do
        flag="0"
        for temp in "${halls[@]}"
        do
            if [ "${temp}" = "${hall}" ]; then
                flag="1"
                break
            fi
        done
        if [ "$flag" = "0" ]; then
            echo "No such hall exists"
            cd "${PWD}"
            PS3="Pick an Option(Enter 9 or Ctrl-C to exit the search): "
            return
        fi
        Hall="${hall}"
        break
    done
    touch "${scriptPath}/temp/tempStor"
    while read line
    do
        year="${line:0:2}"
        if [ "$year" -eq "$year" ] 2>/dev/null; then
            :
        else
            echo "error: Not a Number" >> "temp/tempStor"
            continue
        fi
        cd "${scriptPath}/data/Students"
            cd "Y${year}"
                for program in "${programs[@]}"
                do
                    cd "${program}"
                        Line=`grep -Pn "${line}" RollNo | cut -d: -f1`
                        if [ "$Line" = ""  ]; then
                            cd ..
                            continue
                        fi
                        hall=`head -${Line} Hall | tail -1`
                        if [ "${hall}" = "${Hall}" ]; then
                            echo "${line}" >> "../../../../temp/tempStor"
                        fi
                    cd ..
                done
            cd ..
        cd ../..
    done < "temp/$1"
    cp "temp/tempStor" "temp/$1"
    rm "temp/tempStor"
    PS3="Pick an Option(Enter 9 or Ctrl-C to exit the search): "
    cd "${PWD}"
    return
}
