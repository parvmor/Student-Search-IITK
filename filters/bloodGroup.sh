# NOTE:No #!/bin/bash as this should not spawn an extra shell.

for files in `ls ${scriptPath}/secondaryFilters`
do
    chmod 744 "${scriptPath}/secondaryFilters/${files}"
    source "${scriptPath}/secondaryFilters/${files}"
done

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
        rm temp/bG
        cd "${PWD}"
        return
    fi
    while [ 1 -lt 2 ]
    do
        echo "Do you want to see the result(y) or add further filters(n)?[y/n]"
        read ans
        if [ "${ans}" = "y" ] || [ "${ans}" = "Y"  ]; then
            rollnoVAR "bG"           
            break
        else 
            if [ "${ans}" = "n" ] || [ "${ans}" = "N" ];then
                echo parv
            fi
        fi
    done
    rm temp/bG
    cd "${PWD}"
}
