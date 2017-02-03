
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
        cat "data/Students/Y${year}/${roll}/Summary" >> "temp/display"
    done < "temp/$1"
    if [ ! -s "temp/display" ]; then
        echo "No Result Found" > "temp/display"
    fi
    totalLines=`wc -l < "temp/display"`
    if [ "${totalLines}" = "11"  ]; then
        cat temp/display
        roll=`cat temp/$1`
        echo "Do you want to see the image of the Student?[y/n]"
        read tans
        if [ "${tans}" = "y" ] || [ "${tans}" = "Y" ]; then
            cacaview "data/Students/Y${roll:0:2}/${roll}/image.jpg"
        fi
    else
        vim temp/display
    fi
    echo
    echo "Do you want to save this file locally?[y/n]"
    read ans
    if [ "$ans" = y  ] || [ "$ans" = Y ]; then
        cp temp/display ~/SSResult
        echo "A copy has been made to the home folder."
    fi
    echo
    rm temp/display
    return
}
