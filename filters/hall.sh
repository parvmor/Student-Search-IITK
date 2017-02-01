
hall() {
    PS3="Please choose the required hall:"
    halls=("HALL1" "HALL2" "HALL3" "HALL4" "HALL5" "HALL6" "HALL7" "HALL8" "HALL9" "HALLX" "GHT")
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
                    for program in "${programs[@]}"
                    do
                        cd "${program}"
                            lines=`grep -Pn "${hall}" Hall | cut -d: -f1`
                            if [ "${lines}" == "" ]; then
                                cd ..
                                continue
                            fi
                            touch "../../../../temp/tempHall"
                            echo "${lines}" > "../../../../temp/tempHall"
                            while read line
                            do
                                roll=`head -${line} RollNo | tail -1`
                                echo "${roll}" >> "../../../../temp/hall"
                            done < "../../../../temp/tempHall"
                            rm "../../../../temp/tempHall"
                        cd ..
                    done
                cd ..
            done
        cd ../..
        break
    done
    if [ ! -s "temp/hall" ]; then
        echo "No such student exists"
    fi
    while [ 1 -lt 2  ]
    do
        echo "Do you want to see the result(y) or add further filters(n)?[y/n](Ctrl-C to exit)"
        read ans
        if [ "${ans}" = "y"  ] || [ "${ans}" = "Y"   ]; then
            rollnoVAR "hall"   
            echo "Do you want to add further filters?(y/n)"
            read ans
            if [ "${ans}" = "n"  ] || [ "${ans}" = "N"  ];then
                break
            fi
            ans="n"
        fi
        if [ "${ans}" = "n"  ] || [ "${ans}" = "N"  ];then
            superFilter "hall"
        fi
    done
    rm "temp/hall"
    PS3="Pick an Option(Enter 9 or Ctrl-C to exit the search): "
    cd "${PWD}"
}
