# NOTE:No #!/bin/bash as this should not spawn an extra shell.

rollno() {
    echo "Please Input The Roll Number:"
    read roll
    year="${roll:0:2}"
    if [ "${year}" -eq "${year}" ] 2>/dev/null; then
        echo 
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
    cd ${scriptPath}/data/Students
        cd "Y${year}"
            for program in "${programs[@]}"
            do
                cd "${program}"
                    line=`grep -Pn "${roll}" RollNo | cut -d: -f 1`
                    if [ "${line}" != ""  ]; then
                        sProgram="${program}"
                        bloodGroup=`head -${line} BloodGroup | tail -1`
                        dept=`head -${line} Department | tail -1`
                        email=`head -${line} EmailID | tail -1`
                        gender=`head -${line} Gender | tail -1`
                        hall=`head  -${line} Hall | tail -1`
                        name=`head -${line} Name | tail -1`
                        cd ..
                        break
                    fi
                cd ..
            done
            if [ "${line}" = ""  ]; then
                echo "No such Roll No exists."
                return
            fi
        cd ..
    cd ../..  
    output "$roll" "Y${year}" "$sProgram" "$bloodGroup" "$dept" "$email" "$gender" "$hall" "$name"
    cd "${PWD}"
    return
}
