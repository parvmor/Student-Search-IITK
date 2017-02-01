# NOTE:No #!/bin/bash as this should not spawn an extra shell.

emailID() {
    echo "Please Input The Email-ID:"
    read email
    cd ${scriptPath}/data/Students
        for year in `seq 11 16`
        do
            cd "Y${year}"
                for program in "${programs[@]}"
                do
                    cd "${program}"
                        lines=`grep -Pn "${email}" EmailID | cut -d: -f 1`
                        if [ "${lines}" != "" ]; then
                            touch "../../../../temp/tempEID"
                            echo "${lines}" > "../../../../temp/tempEID"
                            while read line
                            do
                                bloodGroup=`head -${line} BloodGroup | tail -1`
                                dept=`head -${line} Department | tail -1`
                                Email=`head -${line} EmailID | tail -1`
                                gender=`head  -${line} Gender | tail -1`
                                hall=`head -${line} Hall | tail -1`
                                name=`head -${line} Name | tail -1`
                                rollno=`head -${line} RollNo | tail -1`
                                output "$rollno" "Y${year}" "${program}" "$bloodGroup" "$dept" "$Email" "$gender" "$hall" "$name"
                            done < "../../../../temp/tempEID"
                            rm "../../../../temp/tempEID"
                        fi
                    cd ..
                done
            cd ..
        done
    cd ../..
    cd "${PWD}"
    return
}
