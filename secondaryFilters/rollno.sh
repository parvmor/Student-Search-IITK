
rollnoVAR() {
    touch "temp/display"
    while read roll
    do
        year="${roll:0:2}"
        if [ "${year}" -eq "${year}" ] 2>/dev/null; then
            :
        else
            echo "error: Not a Number"
            continue
        fi
        cd data/Students
            cd "Y${year}"
                for program in "${programs[@]}"
                do
                    cd "${program}"
                        line=`grep -Pn "${roll}" RollNo | cut -d: -f1`
                        if [ "${line}" != "" ]; then
                            bloodGroup=`head -${line} BloodGroup | tail -1`
                            dept=`head -${line} Department | tail -1`
                            email=`head -${line} EmailID | tail -1`
                            gender=`head -${line} Gender | tail -1`
                            hall=`head  -${line} Hall | tail -1`
                            name=`head -${line} Name | tail -1`
                            output "$roll" "Y${year}" "$program" "$bloodGroup" "$dept" "$email" "$gender" "$hall" "$name" >> "../../../../temp/display"
                        fi
                    cd ..
                done
            cd ..
        cd ../..
    done < "temp/$1"
    vim  temp/display
    rm temp/display
    return
}
