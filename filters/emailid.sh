# NOTE:No #!/bin/bash as this should not spawn an extra shell.

emailID() {
    echo "Please Input The Email-ID:"
    read email
    touch "${scriptPath}/temp/email"
    cd "${scriptPath}/data/Students"
        for year in `seq 11 16`
        do
            cd "Y${year}"
                for dir in `ls` 
                do
                    cd "${dir}"
                        emailid=`cat EmailID`
                        if [[ "${emailid,,}" = "${email,,}"*  ]]; then
                            echo "${dir}" >> "../../../../temp/email"
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
        echo "Do you want to see the result(R) or add further filters(F)?[R/F](Ctrl-C to exit)"
        read ans
        if [ "${ans}" = "r" ] || [ "${ans}" = "R" ]; then
            rollnoVAR "email"
            echo "Do you want to add further filters?(y/n)"
            read ans
            if [  "${ans}" = "n" ] || [ "${ans}" = "N" ]; then
                break
            fi
            ans="F"
        fi
        if [ "${ans}" = "f" ] || [ "${ans}" = "F" ]; then
            superFilter "email"
        fi
    done
    rm "temp/email"
    cd "${PWD}"
    return
}
