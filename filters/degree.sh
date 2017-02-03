
degree() {
    PS3="Please choose the required degree:"
    degrees=("BTech" "BS" "Prep")
    degree=""
    select deg in "${degrees[@]}"
    do
        case "${deg}" in
            "BTech")
                 ;;
            "BS")
                 ;;
            "Prep")
                ;;
            *)
                echo "No such degree exists"
                PS3="Pick an Option(Enter 9 or Ctrl-C to exit the search): "
                cd "${PWD}"
                return ;;
        esac
        degree="${deg}"
        touch "${scriptPath}/temp/degree"
        cd "${scriptPath}/data/Students"
            for year in `seq 11 16`
            do
                cd "Y${year}"
                    for dir in `ls`
                    do
                        cd "${dir}"
                            deg=`cat Program`
                            if [ "${deg}" = "${degree}" ]; then
                                echo "${dir}" >> "../../../../temp/degree"
                            fi
                        cd ..
                    done
                cd ..
            done
        cd ../..
        break
    done
    if [ ! -s "temp/degree" ]; then
        echo "No such degree exists"
        rm temp/degree
        cd "${PWD}"
        return
    fi
    while [ 1 -lt 2  ]
    do
        echo "Do you want to see the result(R) or add further filters(F)?[R/F](Ctrl-C to exit)"
        read ans
        if [ "${ans}" = "r"  ] || [ "${ans}" = "R"   ]; then
            rollnoVAR "degree"           
            echo "Do you want to add further filters?(y/n)"
            read ans
            if [ "${ans}" = "n"  ] || [ "${ans}" = "N"  ];then
                break
            fi
            ans="F"
        fi
        if [ "${ans}" = "f"  ] || [ "${ans}" = "R"  ];then
            superFilter "degree"
        fi
    done
    rm "temp/degree"
    PS3="Pick an Option(Enter 9 or Ctrl-C to exit the search): "
    cd "${PWD}"
}
