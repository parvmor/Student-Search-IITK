
superRoll() {
    echo "Please provide a Roll No:"
    read roll
    line=`grep -Pn "${roll}" temp/$1 | cut -d: -f1`
    if [ "${line}" = "" ]; then
        echo "No such student exists."
        return
    fi
    year="${roll:0:2}"
    if [ "$year" -eq "$year" ] 2>/dev/null; then
        :
    else
        echo "error: Not a Number"
        continue
    fi
    cd "${scriptPath}/data/Students"
        cd "Y${year}"
            for program in "${programs[@]}"
            do
                cd "${program}"
                    line=`grep -Pn "${roll}" RollNo | cut -d: -f1`
                    if [ "${line}" = "" ]; then
                        cd ..
                        continue
                    fi
                    bloodGroup=`head -${line} BloodGroup | tail -1`
                    dept=`head -${line} Department | tail -1`
                    email=`head -${line} EmailID | tail -1`
                    gender=`head -${line} Gender | tail -1`
                    hall=`head  -${line} Hall | tail -1`
                    name=`head -${line} Name | tail -1`
                    output "$roll" "Y${year}" "$program" "$bloodGroup" "$dept" "$email"     "$gender" "$hall" "$name"
                cd ..
            done
        cd ..
    cd ../..
    cd "${PWD}"
}
