
#!/bin/bash

if [ -d "../Students" ]; then
    echo "Script has already been run. Delete Students directory to rerun it."
    exit
fi

chmod 744 directoryMaker.sh
./directoryMaker.sh

echo "Starting to scrap data now..."
echo

output() {
    printf '%*s\n' "$(tput cols)" | tr " " -
    echo "Roll No.: $1"
    echo "Batch: $2"
    echo "Degree: $3"
    echo "Blood Group: $4"
    echo "Department: $5"
    echo "Email-ID: $6"
    echo "Gender: $7"
    echo "Hall: $8"
    echo "Name: $9"
    printf '%*s\n' "$(tput cols)" | tr " " -
}

extract() {
    data=$(curl -s http://oa.cc.iitk.ac.in/Oa/Jsp/OAServices/IITk_SrchRes.jsp?sbm=Y -d typ="stud" -d numtxt=$1) # store data in a variable for multiple use
    cd ../Students
        cd "Y$2"
            cd "$1"
                program=`echo "$data" | grep -P -A1 'Program' | tail -1 | grep -Po '\w+'`
                echo "${program}" > "Program"
                gender=`echo "$data" | grep -P -A1 'Gender' | tail -1 | grep -Po '\w'`
                if [ "$gender" = "F"   ]; then
                    hall="GHT"
                else
                    if [ "$gender" = "M"  ]; then
                        hall=`echo "$data" | grep -P -A1 'Hostel Info' | tail -1 | grep -Po 'HALL[\dX]{1}'`
                    else
                        hall="NOT AVAILABLE"
                        gender="UNKNOWN"
                    fi
                fi
                echo "${gender}" > Gender
                echo "${hall}" > Hall
                email=`echo "$data" | grep -Po '[\w\+\._]+@[\w*\.]{2,}\w+' | head -1`
                if [ "$email" = "" ]; then
                    email="NOT AVAILABLE"
                fi
                echo "${email}" > EmailID
                name=`echo "$data" | grep -P -A1 'Name' | tail -1 | grep -Po '\w[\s\w\.\(\)\[\]\/\d\-]*[^\s]'`
                if [ "$name" = ""  ]; then
                    name="NOT AVAILABLE"
                fi
                echo "${name}" > Name
                bloodGroup=`echo "$data" | grep -P -A1 'Blood Group' | tail -1 | grep -Po '[ABO]{1,2}[\+-]{1}'`
                if [ "$bloodGroup" = ""  ]; then
                    bloodGroup="NOT AVAILABLE"
                fi
                echo "${bloodGroup}" > BloodGroup
                department=`echo "$data" | grep -P -A1 'Department' | tail -1 | grep -Po '\w[\s\w&\.]+[^\s]'`
                echo "${department}" > Department
                output "$1" "Y${2}" "${program}" "${bloodGroup}" "${department}" "${email}" "${gender}" "${hall}" "${name}" > Summary                
                url=`echo "$data" | grep -P "img" | grep -Po 'http.*jpg'`
                wget -q -O "image.jpg" "${url}"
            cd ..
        cd ..
    cd ..
    cd script
}

export -f extract
export -f output

echo "Scraping Data for Y16"
seq 160001 160832 | xargs -P0 -I {} bash -c 'extract {} 16'   
echo "Data Scraped for Y16"
echo

echo "Scraping Data for Y15"
seq 150001 150845 | xargs -P0 -I {} bash -c 'extract {} 15' 
echo "Data Scraped for Y15"
echo

echo "Scraping Data for Y14"
seq 14001 14832 | xargs -P0 -I {} bash -c 'extract {} 14' 
echo "Data Scraped for Y14"
echo

echo "Scraping Data for Y13"
seq 13001 13819 | xargs -P0 -I {} bash -c 'extract {} 13'
echo "Data Scraped for Y13"
echo

echo "Scraping Data for Y12"
seq 12001 12837 | xargs -P0 -I {} bash -c 'extract {} 12'
echo "Data Scraped for Y12"
echo

echo "Scraping Data for Y11"
seq 11001 11833 | xargs -P0 -I {} bash -c 'extract {} 11'
echo "Data Scraped for Y11"
echo
