
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
                    for program in "${programs[@]}"
                    do
                        cd "${program}"
                            lines=`grep -Pn "${department}" Department | cut -d: -f 1`
                            if [ "${lines}" = "" ]; then
                                cd ..
                                continue
                            fi
                            touch "../../../../temp/tempDept"
                            echo "${lines}" > "../../../../temp/tempDept"
                            while read line
                            do
                                roll=`head -${line} RollNo | tail -1`
                                echo "${roll}" >> "../../../../temp/dept"
                            done < "../../../../temp/tempDept"
                            rm "../../../../temp/tempDept"
                        cd ..
                    done
                cd ..
            done
		cd "../.."
        break
    done
    if [ ! -s "temp/dept"  ]; then
        echo "No such department exists"
    fi
    while [ 1 -lt 2  ]
    do
        echo "Do you want to see the result(y) or add further filters(n)?[y/n]"
        read ans
        if [ "${ans}" = "y"  ] || [ "${ans}" = "Y"   ]; then
            rollnoVAR "dept"           
            echo "Do you want to add further filters?(y/n)"
            if [ "$ans" = "n" ] || [ "$ans" = "N" ];then
                break
            fi
            ans="n"
        fi
        if [ "${ans}" = "n"  ] || [ "${ans}" = "N"  ];then
            superFilter "dept"
            break
        fi
    done
	rm "temp/dept"
    PS3="Pick an Option(Enter 9 or Ctrl-C to exit the search): "
	cd "${PWD}"
}
