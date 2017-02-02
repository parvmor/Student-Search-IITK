# NOTE:No #!/bin/bash as this should not spawn an extra shell.

rollno() {
    echo "Please Input The Roll Number:"
    read roll
    year="${roll:0:2}"
    if [ "${roll}" -eq "${roll}" ] 2>/dev/null; then
        :
    else
        echo "error: Not a Number"
        return
    fi
    if [ "${year}" -eq "${year}" ] 2>/dev/null; then
        :
    else
        echo "error: Not a Number"
        return
    fi
    if [ "${year}" -lt "11"  ]; then
        echo "Data for Y${year} not available."
        return
    else
        if [ "${year}" -gt "16"  ]; then
            echo "Stop looking in the future!!!."
            return
        fi
    fi
    touch "${scriptPath}/temp/rollno"
    cd ${scriptPath}/data/Students
        cd "Y${year}"
            for program in "${programs[@]}"
            do
                cd "${program}"
                    lines=`grep -Pn "${roll}" RollNo | cut -d: -f 1`
                    if [ "${lines}" = "" ]; then
                        cd ..
                        continue
                    fi
                    touch "../../../../temp/tempRoll"
                    echo "${lines}" > "../../../../temp/tempRoll"
                    while read line
                    do
                        Roll=`head -"${line}" RollNo | tail -1`
                        echo "${Roll}" >> "../../../../temp/rollno"
                    done < "../../../../temp/tempRoll"
                    rm "../../../../temp/tempRoll"
                cd ..
            done
        cd ..
    cd ../..  
    if [ ! -s "temp/rollno"  ]; then
        echo "No such student exists"
        rm "temp/rollno"
        cd "${PWD}"
        return
    fi
    while [ 1 -lt 2 ]
    do
        echo "Do you want to see the result(y) or add further filters(n)?[y/n](Ctrl-C to exit)"
        read ans
        if [ "${ans}" = "y"  ] || [ "${ans}" = "Y"  ]; then
            rollnoVAR "rollno"
            echo "Do you want to add further filters?(y/n)"
            read ans
            if [  "${ans}" = "n"  ] || [ "${ans}" = "N"  ]; then
                break
            fi
            ans="n"
        fi
         if [ "${ans}" = "n"  ] || [ "${ans}" = "N"  ]; then
             superFilter "rollno"
         fi
    done
    rm "temp/rollno"
    cd "${PWD}"
    return
}
