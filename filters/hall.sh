
hall() {
    PS3="Please choose the required hall:"
    hall=""
    select Hall in "${halls[@]}"
    do
        flag="0"
        for temp in "${halls[@]}"
        do
            if [ "${temp}" == "${Hall}" ]; then
                flag="1"
            fi
        done
        if [ "${flag}" == "0" ]; then
            echo "No such hall exists"
            PS3="Pick an Option(Enter 9 or Ctrl-C to exit the search): "
            cd "${PWD}"
            return
        fi
        hall="${Hall}"
        touch "${scriptPath}/temp/hall"
        cd "${scriptPath}/data/Students"
            for year in `seq 11 16`
            do
                cd "Y${year}"
                    for dir in `ls`
                    do
                        cd "${dir}"
                            Hall=`cat Hall`
                            if [ "${Hall}" = "${hall}" ]; then
                                echo "${dir}" >> "../../../../temp/hall"
                            fi
                        cd..
                    done
                cd ..
            done
        cd ../..
        break
    done
    if [ ! -s "temp/hall" ]; then
        echo "No such student exists"
        rm "temp/hall"
        PS3="Pick an Option(Enter 9 or Ctrl-C to exit the search): "
        cd "${PWD}"
        return
    fi
    while [ 1 -lt 2  ]
    do
        echo "Do you want to see the result(R) or add further filters(F)?[R/F](Ctrl-C to exit)"
        read ans
        if [ "${ans}" = "r"  ] || [ "${ans}" = "R"   ]; then
            rollnoVAR "hall"   
            echo "Do you want to add further filters?(y/n)"
            read ans
            if [ "${ans}" = "n"  ] || [ "${ans}" = "N"  ];then
                break
            fi
            ans="F"
        fi
        if [ "${ans}" = "f"  ] || [ "${ans}" = "F"  ];then
            superFilter "hall"
        fi
    done
    rm "temp/hall"
    PS3="Pick an Option(Enter 9 or Ctrl-C to exit the search): "
    cd "${PWD}"
    return
}
