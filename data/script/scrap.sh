#!/bin/bash

if [ -d "../Students" ]; then
    echo "Script has already been run. Delete Students directory to rerun it."
    exit
fi

chmod 744 directoryMaker.sh
./directoryMaker.sh

echo "Starting to scrap data now..."
echo

extract() {
    data=$(curl -s http://oa.cc.iitk.ac.in/Oa/Jsp/OAServices/IITk_SrchRes.jsp?sbm=Y -d typ="stud" -d numtxt=$1) # store data in a variable for multiple use
    cd ../Students
        cd "Y$2"
            program=`echo "$data" | grep -P -A1 'Program' | tail -1 | grep -Po '\w+'`
            if [ ! -d "${program}"   ]; then
                mkdir "${program}"
            fi 
            cd "${program}"

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

                email=`echo "$data" | grep -Po '[\w\+\._]+@[\w*\.]{2,}\w+' | head -1`
                if [ "$email" = "" ]; then
                    email="NOT AVAILABLE"
                fi

                name=`echo "$data" | grep -P -A1 'Name' | tail -1 | grep -Po '\w[\s\w\.\(\)]*'`
                if [ "$name" = ""  ]; then
                    name="NOT AVAILABLE"
                fi

                bloodGroup=`echo "$data" | grep -P -A1 'Blood Group' | tail -1 | grep -Po '[ABO]{1,2}[\+-]{1}'`
                if [ "$bloodGroup" = ""  ]; then
                    bloodGroup="NOT AVAILABLE"
                fi

                dept=`echo "$data" | grep -P -A1 'Department' | tail -1 | grep -Po '\w[\s\w&\.]+'`

                rollno=$1

                ( echo "$rollno"     >> RollNo       & \
                  echo "$gender"     >> Gender       & \
                  echo "$email"      >> EmailID      & \
                  echo "$bloodGroup" >> BloodGroup   & \
                  echo "$name"       >> Name         & \
                  echo "$dept"       >> Department   & \
                  echo "$hall"       >> Hall )       &>/dev/null

            cd ..
        cd ..
    cd ..
    cd script

}

export -f extract # export extract as xargs calls it from a bash

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
