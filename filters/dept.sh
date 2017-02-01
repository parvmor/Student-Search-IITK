
dept() {
    departments=("COMPUTER SCIENCE & ENGG." "ELECTRICAL ENGG." "CIVIL ENGG." "MECHANICAL ENGG." "AEROSPACE ENGG." "MATERIALS SCIENCE & ENGG." "BIOL.SCI. AND BIO.ENGG." "CHEMICAL ENGG." "Math for Pg online" "CHEMISTRY" "PHYSICS" "EARTH SCIENCES" "ECONOMICS")
    department=""
    select Dept in "${departments[@]}"
    do
        department="${Dept}"
        touch "${scriptPath}/temp/dept"
        cd "${scriptPath}/data/Students"
			for year in `seq 11 16`
            do
                for program in "${programs[@]}"
                do
                    cd "${program}"
                        lines=`grep -Pn "${dept}" Department | cut -d: -f 1`
                        if [ "${lines}" = "" ]; then
                            cd ..
                            continue
                        fi
                        touch "../../../../temp/tempDept"
                        echo "${lines}" > "../../../../temp/tempDept"
                        while read line
                        do
                            roll=`head -${line} RollNo | tail -1`
                            echo "${roll}" >> "../../.././temp/dept"
                        done < "../../../../temp/tempDept"
                        rm "../../../../temp/tempDept"
                    cd ..
                done
            done
		cd "../.."
        break
    done
	rm "temp/dept"
	cd "${PWD}
}
