# NOTE:No #!/bin/bash as this should not spawn an extra shell.

name() {
    echo "Please Input the Name:"
    read name
    touch "${scriptPath}/temp/name"
    cd "${scriptPath}/data/Students"
        for year in `seq 11 16`
        do
            cd "Y${year}"
                for program in "${programs[@]}"
                do
                    cd "${program}"
                        lines=`grep -Pin "${name}" Name | cut -d: -f 1`
                        if [ "${lines}" = ""  ]; then
                            cd ..
                            continue
                        fi
                        touch "../../../../temp/tempName"
                        echo "${lines}" > "../../../../temp/tempName"
                        while read line
                        do
                            roll=`head -${line} RollNo | tail -1`
                            echo "${roll}" >> "../../../../temp/name" 
                        done < "../../../../temp/tempName"
                    cd ..
                done
            cd ..
        done
    cd ../..  
    if [ ! -s "temp/name" ]; then
        echo "No such student exists"
        rm "temp/name"
        cd "${PWD}"
        return    
    fi
    while [ 1 -lt 2 ]
    do
        echo "Do you want to see the result(y) or add further filters(n)?[y/n](Ctrl-C to exit)"
        read ans
        if [ "${ans}" = "y" ] || [ "${ans}" = "Y" ]; then
            rollnoVAR "name"
            echo "Do you want to add further filters?(y/n)"
            read ans
            if [  "${ans}" = "n" ] || [ "${ans}" = "N" ]; then
                break
            fi
            ans="n"
        fi
        if [ "${ans}" = "n" ] || [ "${ans}" = "N" ]; then
            superFilter "name"
        fi
    done
    rm "temp/name"
    cd "${PWD}"
    return
}
