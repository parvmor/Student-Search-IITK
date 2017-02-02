
superBG() {
    echo "Please provide the blood group:"
    read bG
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
                        bloodGroup="`head -${Line} BloodGroup | tail -1`"
                        if [ "${bloodGroup,,}" = "${bG,,}" ]; then
                            echo "${line}" >> "../../../../temp/tempStor"
                        fi
                    cd ..
                done
            cd ..
        cd ../..
    done < "temp/$1"
    cp "temp/tempStor" "temp/$1"
    rm "temp/tempStor"
    cd "${PWD}"
    return
}
