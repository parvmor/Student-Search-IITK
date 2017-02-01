
gender() {
   PS3="Please choose the required gender:"
   genders=("M" "F")
   gender=""
   select gen in "${genders[@]}"
   do
        case "${gen}" in
            "F")
                break ;;
            "M")
                break ;;
            *)
                echo "No such gender exists"
                cd "${PWD}"
                return ;;
        esac
        gender="${gen}"
        touch "${scriptPath}/temp/gender"
        cd "${scriptPath}/temp/gender"
            for year in `seq 11 16`
            do
                cd "Y${year}"
                    for program in "${programs[@]}"
                    do
                        cd "${program}"
                            lines=`grep -Pn "${gender}" Gender | cut -d: -f1`
                            if [ "${lines}" = "" ]; then
                                cd ..
                                continue
                            fi
                            touch "../../../../temp/tempGender"
                            echo "${lines}" > "../../../../temp/tempGender"
                            while read line
                                roll=`head -{line} RollNo | tail -1`
                                echo "${roll}" >> "../../../../temp/gender"
                            do
                            done < "../../../../temp/tempGender"
                            rm "../../../../temp/tempGender"
                        cd..
                    done
                cd ..
            done
        cd "../.."
        break
   done
   if [ -s "temp/dept" ]; then
       echo "No such gender exists"
   fi
   rm "temp/gender"
   PS3="Pick an Option(Enter 9 or Ctrl-C to exit the search): "
   cd "${PWD}"
