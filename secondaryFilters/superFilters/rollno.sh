
superRoll() {
    echo "Please Input the Roll Number:"
    read rollno
    if [ "$rollno" -eq "$rollno" ] 2>/dev/null; then
        :
    else 
        echo "error: Not a Number"
        cd "${PWD}"
        return
    fi
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
                        Roll=`head -${Line} RollNo | tail -1`
                        #lower case search
                        if [[ "${Roll,,}" = "${rollno,,}"*  ]]; then
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
