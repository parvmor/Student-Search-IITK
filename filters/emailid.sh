# NOTE:No #!/bin/bash as this should not spawn an extra shell.

emailID() {
    echo "Please Input The Email-ID:"
    read email
    touch "${scriptPath}/temp/email"
    cd "${scriptPath}/data/Students"
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
                                roll=`head -${line} RollNo | tail -1` 
                                echo "${roll}" >> "../../../../temp/email"
                            done < "../../../../temp/tempEID"
                            rm "../../../../temp/tempEID"
                        fi
                    cd ..
                done
            cd ..
        done
    cd ../..
    if [ ! -s "temp/email" ]; then
        echo "No such student exists"
        rm "temp/email"
        cd "${PWD}"
        return    
    fi
    while [ 1 -lt 2 ]
    do
        echo "Do you want to see the result(y) or add further filters(n)?[y/n](Ctrl-C to exit)"
        read ans
        if [ "${ans}" = "y" ] || [ "${ans}" = "Y" ]; then
            rollnoVAR "email"
            echo "Do you want to add further filters?(y/n)"
            read ans
            if [  "${ans}" = "n" ] || [ "${ans}" = "N" ]; then
                break
            fi
            ans ="n"
        fi
        if [ "${ans}" = "n" ] || [ "${ans}" = "N" ]; then
            superFilter "email"
        fi
    done
    rm "temp/email"
    cd "${PWD}"
    return
}
