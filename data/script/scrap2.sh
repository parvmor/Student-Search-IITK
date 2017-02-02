
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

                Gender=`echo "$data" | grep -P -A1 'Gender' | tail -1 | grep -Po '\w'`

                if [ "$Gender" = "F"   ]; then
                    Hall="GHT"
                else
                    if [ "$Gender" = "M"  ]; then
                        Hall=`echo "$data" | grep -P -A1 'Hostel Info' | tail -1 | grep -Po 'HALL[\dX]{1}'`
                    else
                        Hall="NOT AVAILABLE"
                        Gender="UNKNOWN"
                    fi
                fi

                EmailID=`echo "$data" | grep -Po '[\w\+\._]+@[\w*\.]{2,}\w+' | head -1`
                if [ "$EmailID" = "" ]; then
                    EmailID="NOT AVAILABLE"
                fi

                Name=`echo "$data" | grep -P -A1 'Name' | tail -1 | grep -Po '\w[\s\w\.\(\)\[\]\/\d\-]*[^\s]'`
                if [ "$Name" = ""  ]; then
                    Name="NOT AVAILABLE"
                fi

                BloodGroup=`echo "$data" | grep -P -A1 'Blood Group' | tail -1 | grep -Po '[ABO]{1,2}[\+-]{1}'`
                if [ "$BloodGroup" = ""  ]; then
                    BloodGroup="NOT AVAILABLE"
                fi

                Department=`echo "$data" | grep -P -A1 'Department' | tail -1 | grep -Po '\w[\s\w&\.]+[^\s]'`

                rollno=$1

                url=`echo "$data" | grep -P "img" | grep -Po 'http.*jpg'`

                cd "../../../images"
                    wget -q -O "${rollno}.jpg" "${url}"
                cd - >/dev/null

                echo "${rollno}"      >> RollNo
                echo "${Name}"        >> Name
                echo "${EmailID}"     >> EmailID
                echo "${Department}"  >> Department
                echo "${Hall}"        >> Hall
                echo "${Gender}"      >> Gender
                echo "${BloodGroup}"  >> BloodGroup
            cd ..
        cd ..
    cd ..
    cd script

}

echo "Scraping Data for Y16"
for i in `seq 160001 160832`
do
   extract $i 16
done
echo "Data Scraped for Y16"
echo

echo "Scraping Data for Y15"
for i in `seq 150001 150845`
do
    extract $i 15
done
echo "Data Scraped for Y15"
echo

echo "Scraping Data for Y14"
for i in `seq 14001 14832`
do
    extract $i 14
done
echo "Data Scraped for Y14"
echo

echo "Scraping Data for Y13"
for i in `seq 13001 13819`
do
    extract $i 13
done
echo "Data Scraped for Y13"
echo

echo "Scraping Data for Y12"
for i in `seq 12001 12837`
do
    extract $i 12
done
echo "Data Scraped for Y12"
echo

echo "Scraping Data for Y11"
for i in `seq 11001 11833`
do
    extract $i 11
done
echo "Data Scraped for Y11"
echo
