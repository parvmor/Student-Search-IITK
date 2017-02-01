
gender() {
    PS3="Please choose the required gender:"
    genders=("M" "F")
    gender=""
    select gen in "${genders[@]}"
    do
        case "${gen}" in
            "F")
                 ;;
            "M")
                 ;;
            *)
                echo "No such gender exists"
                PS3="Pick an Option(Enter 9 or Ctrl-C to exit the search): "
                cd "${PWD}"
                return ;;
        esac
        gender="${gen}"
        touch "${scriptPath}/temp/gender"
        cd "${scriptPath}/data/Students"
            for year in `seq 11 16`
            do
                cd "Y${year}"
                    for program in "${programs[@]}"
                    do
                        cd "${program}"
                            lines=`grep -Pn "${gender}" Gender | cut -d: -f1`
                            if [ "${lines}" == "" ]; then
                                cd ..
                                continue
                            fi
                            touch "../../../../temp/tempGender"
                            echo "${lines}" > "../../../../temp/tempGender"
                            while read line
                            do
                                roll=`head -${line} RollNo | tail -1`
                                echo "${roll}" >> "../../../../temp/gender"
                            done < "../../../../temp/tempGender"
                            rm "../../../../temp/tempGender"
                        cd ..
                    done
                cd ..
            done
        cd ../..
        break
    done
    if [ ! -s "temp/gender" ]; then
        echo "No such gender exists"
    fi
    while [ 1 -lt 2  ]
    do
        echo "Do you want to see the result(y) or add further filters(n)?[y/n]"
        read ans
        if [ "${ans}" = "y"  ] || [ "${ans}" = "Y"   ]; then
            rollnoVAR "gender"           
            echo "Do you want to add further filters?(y/n)"
            if [ "${ans}" = "n"  ] || [ "${ans}" = "N"  ];then
                break
            fi
            ans="n"
        fi
        if [ "${ans}" = "n"  ] || [ "${ans}" = "N"  ];then
            superFilter "gender"
            break
        fi
    done
    rm "temp/gender"
    PS3="Pick an Option(Enter 9 or Ctrl-C to exit the search): "
    cd "${PWD}"
}
