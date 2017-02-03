# NOTE:No #!/bin/bash as this should not spawn an extra shell.

name() {
    echo "Please Input the Name:"
    read name
    touch "${scriptPath}/temp/name"
    cd "${scriptPath}/data/Students"
        for year in `seq 11 16`
        do
            cd "Y${year}"
                for dir in `ls`
                do
                    cd "${dir}"
                        Name=`cat Name`
                        if [[ "${Name,,}" = "${name,,}"*  ]]; then
                            echo "${dir}" >> "../../../../temp/name"
                        fi
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
        echo "Do you want to see the result(R) or add further filters(F)?[R/F](Ctrl-C to exit)"
        read ans
        if [ "${ans}" = "r" ] || [ "${ans}" = "R" ]; then
            rollnoVAR "name"
            echo "Do you want to add further filters?(y/n)"
            read ans
            if [  "${ans}" = "n" ] || [ "${ans}" = "N" ]; then
                break
            fi
            ans="F"
        fi
        if [ "${ans}" = "f" ] || [ "${ans}" = "F" ]; then
            superFilter "name"
        fi
    done
    rm "temp/name"
    cd "${PWD}"
    return
}
