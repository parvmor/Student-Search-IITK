# NOTE:No #!/bin/bash as this should not spawn an extra shell.

name() {
    echo "Please Input Name:"
    read name
    cd ${scriptPath}/data/Students
        for year in `seq 11 16`
        do
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
        done
    cd ../..  
    output "$roll" "Y${year}" "$sProgram" "$bloodGroup" "$dept" "$email" "$gender" "$hall" "$name"
    cd "${PWD}"
    return
}
