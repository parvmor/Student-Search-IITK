
dept() {
    departments=("COMPUTER SCIENCE & ENGG." "ELECTRICAL ENGG." "CIVIL ENGG." "MECHANICAL ENGG." "AEROSPACE ENGG." "MATERIALS SCIENCE & ENGG." "BIOL.SCI. AND BIO.ENGG." "CHEMICAL ENGG." "Math for Pg online" "CHEMISTRY" "PHYSICS" "EARTH SCIENCES" "ECONOMICS")
    department=""
    PS3="Please choose the required department:"
    select Dept in "${departments[@]}"
    do
        flag="0"
        for temp in "${departments[@]}"
        do
            if [ "${Dept}" = "${temp}"  ];then
                flag="1"
                break
            fi
        done
        if [ "$flag" == "0" ]; then
            echo "No such department exists"
            cd "${PWD}"
            PS3="Pick an Option(Enter 9 or Ctrl-C to exit the search): "
            return
        fi
        department="${Dept}"
        touch "${scriptPath}/temp/dept"
        cd "${scriptPath}/data/Students"
			for year in `seq 11 16`
            do
                cd "Y${year}"
                    for dir in `ls`
                    do
                        cd "${dir}"
                            dept=`cat Department`
                            if [ "${dept}" = "${department}" ]; then
                                echo "${dir}"  >> "../../../../temp/dept"
                            fi
                        cd ..
                    done
                cd ..
            done
		cd "../.."
        break
    done
    if [ ! -s "temp/dept"  ]; then
        echo "No such department exists"
        rm temp/dept
        cd "${PWD}"
        return
    fi
    while [ 1 -lt 2  ]
    do
        echo "Do you want to see the result(R) or add further filters(F)?[R/F](Ctrl-C to exit)"
        read ans
        if [ "${ans}" = "r"  ] || [ "${ans}" = "R"   ]; then
            rollnoVAR "dept"           
            echo "Do you want to add further filters?(y/n)"
            read ans
            if [ "$ans" = "n" ] || [ "$ans" = "N" ];then
                break
            fi
            ans="F"
        fi
        if [ "${ans}" = "f"  ] || [ "${ans}" = "F"  ];then
            superFilter "dept"
        fi
    done
	rm "temp/dept"
    PS3="Pick an Option(Enter 9 or Ctrl-C to exit the search): "
	cd "${PWD}"
}
