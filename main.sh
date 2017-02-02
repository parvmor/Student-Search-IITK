#!/bin/bash

scriptPath=$(dirname $0)
PWD=`pwd`
chmod 744 "${scriptPath}/output.sh"
source "${scriptPath}/output.sh"

programs=("BTech" "BS" "MTech" "Prep" )
departments=("COMPUTER SCIENCE & ENGG." "ELECTRICAL ENGG." "CIVIL ENGG." "MECHANICAL ENGG." "AEROSPACE ENGG." "MATERIALS SCIENCE & ENGG." "BIOL.SCI. AND BIO.ENGG." "CHEMICAL ENGG." "Math for Pg online" "CHEMISTRY" "PHYSICS" "EARTH SCIENCES" "ECONOMICS")
halls=("HALL1" "HALL2" "HALL3" "HALL4" "HALL5" "HALL6" "HALL7" "HALL8" "HALL9" "HALLX" "GHT")

cd "${scriptPath}/secondaryFilters"
chmod 744 "rollno.sh"
source "rollno.sh"
chmod 744 "superFilterate.sh"
source "superFilterate.sh"
cd - >/dev/null


for files in `ls ${scriptPath}/filters`
do
    chmod 744 "${scriptPath}/filters/${files}"
    source "${scriptPath}/filters/${files}"
done

if [ ! -d "${scriptPath}/data/Students" ]; then
    echo "Database of Students does not exist locally."
    cd "${scriptPath}/data/script"
    chmod 744 scrap.sh
    ./scrap.sh
    cd -
    echo "Student Search is ready to be used now"
fi

# cool ascii art :p
toilet --metal -w 150 Student Search IITK

# start of asking user of filter method
PS3="Pick an Option(Enter 9 or Ctrl-C to exit the search): "
options=("Roll Number" "Name" "Blood Group" "Department" "Email-ID" "Gender" "Hall")
while [ "2" = "2"  ]
do
    echo "Please choose on what basis do you want to filter your search?"
    select opt in "${options[@]}" "Feedback" "Quit"
    do
        case "$opt" in
            "Roll Number")
                rollno 
                break ;;
            "Name")
                name 
                break ;;
            "Blood Group")
                bloodGroup 
                break ;;
            "Department")
                dept 
                break ;;
            "Email-ID")
                emailID
                break ;;
            "Gender")
                gender 
                break ;;
            "Hall")
                hall
                break ;;
            "Feedback")
                echo "Feedback"
                break ;;
            "Quit")
                echo "Thank You for using the search. Exiting Student Search." 
                exit ;;
            *)
                echo "Invalid Option" ;;
        esac
    done
    rm -rf "${scriptPath}/temp"
    mkdir "${scriptPath}/temp"
done
#end of filter
