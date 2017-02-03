# NOTE:No #!/bin/bash as this should not spawn an extra shell.

bloodGroup() {
    echo "Please Input the Blood Group:"
    read bG
    touch "${scriptPath}/temp/bG"
    cd "${scriptPath}/data/Students"
        for year in `seq 11 16`
        do
            cd "Y${year}"
                for dir in `ls`
                do
                    cd "${dir}"
                        bloodGroup=`cat BloodGroup`
                        if [ "${bG,,}" = "${bloodGroup,,}"  ]; then
                            echo "${dir}" >> "../../../../temp/bG"
                        fi
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
        echo "Do you want to see the result(R) or add further filters(F)?[R/F](Ctrl-C to exit)"
        read ans
        if [ "${ans}" = "r" ] || [ "${ans}" = "R"  ]; then
            rollnoVAR "bG"
            echo "Do you want to add further filters?(y/n)"
            read ans
            if [ "${ans}" = "n" ] || [ "${ans}" = "N" ];then 
                break
            fi
            ans="F"
        fi
        if [ "${ans}" = "f" ] || [ "${ans}" = "F" ];then
            superFilter "bG"
        fi
    done
    rm temp/bG
    cd "${PWD}"
}
