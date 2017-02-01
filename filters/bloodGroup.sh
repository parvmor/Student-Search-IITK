# NOTE:No #!/bin/bash as this should not spawn an extra shell.

bloodGroup() {
    echo "Please Input the Blood Group:"
    read bG
    touch "${scriptPath}/temp/bG"
    cd "${scriptPath}/data/Students"
        for year in `seq 11 16`
        do
            cd "Y${year}"
                for program in "${programs[@]}"
                do
                    cd "${program}"
                        lines="`grep -Pn "${bG}" BloodGroup | cut -d: -f 1`"
                        if [ "${lines}" = ""  ]; then
                            cd ..
                            continue
                        fi
                        touch "../../../../temp/tempbG"
                        echo "${lines}" > "../../../../temp/tempbG"
                        while read line
                        do
                            roll=`head -${line} RollNo | tail -1`
                            echo "${roll}" >> "../../../../temp/bG"
                        done < "../../../../temp/tempbG"
                        rm "../../../../temp/tempbG"
                    cd ..
                done
            cd ..
        done
    cd ../..
    if [ ! -s "temp/bG"  ]; then
        echo "No such blood group exists"
    fi
    rm temp/bG
    cd "${PWD}"
}
