# NOTE:No #!/bin/bash as this should not spawn an extra shell.

rollno() {
    echo "Please Input The Roll Number:"
    read roll
    year="${roll:0:2}"
    if [ "${roll}" -eq "${roll}" ] 2>/dev/null; then
        :
    else
        echo "error: Not a Number"
        return
    fi
    if [ "${year}" -eq "${year}" ] 2>/dev/null; then
        :
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
    touch "temp/rollno"
    cd ""data/Students
        cd "Y${year}"
            for dir in `ls`
            do
                cd "${dir}"
                    if [[ "${dir}" = "${roll}"* ]]; then
                        echo "${dir}" >> "../../../../temp/rollno"
                    fi
                cd ..
            done
        cd ..
    cd ../..  
    if [ ! -s "temp/rollno"  ]; then
        echo "No such student exists"
        rm "temp/rollno"
        cd "${PWD}"
        return
    fi
    while [ 1 -lt 2 ]
    do
        echo "Do you want to see the result(R) or add further filters(F)?[R/F](Ctrl-C to exit)"
        read ans
        if [ "${ans}" = "r"  ] || [ "${ans}" = "R"  ]; then
            rollnoVAR "rollno"
            echo "Do you want to add further filters?(y/n)"
            read ans
            if [  "${ans}" = "n"  ] || [ "${ans}" = "N"  ]; then
                break
            fi
            ans="F"
        fi
         if [ "${ans}" = "f"  ] || [ "${ans}" = "F"  ]; then
             superFilter "rollno"
         fi
    done
    rm "temp/rollno"
    cd "${PWD}"
    return
}
