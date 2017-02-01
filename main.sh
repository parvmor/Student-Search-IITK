#!/bin/bash

scriptPath=$(dirname $0)
PWD=`pwd`
chmod 744 "${scriptPath}/output.sh"
source "${scriptPath}/output.sh"

programs=("BTech" "BS" "MTech" "Prep" )

for files in "rollno.sh" "bloodGroup.sh" "name.sh" "emailid.sh" "dept.sh" "gender.sh"
do
    chmod 744 "${scriptPath}/filters/${files}"
    source "${scriptPath}/filters/${files}"
done

if [ ! -d "./data/Students" ]; then
    echo "Database of Students does not exist locally."
    cd ./data/script
    chmod 744 scrap.sh
    ./scrap.sh
    cd -
    echo "Student Search is ready to be used now"
fi

# cool ascii art :p
toilet --metal -w 150 Student Search IITK

# start of asking user of filter method
PS3="Pick an Option(Enter 9 or Ctrl-C to exit the search): "
options=("Roll Number" "Name" "Blood Group" "Department" "Email-ID" "Gender" "Hall" "Feedback" "Quit")
while [ "2" = "2"  ]
do
    echo "Please choose on what basis do you want to filter your search?"
    select opt in "${options[@]}"
    do
        case $opt in
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
                echo "Hall"
                break ;;
            "Feedback")
                echo "Feedback"
                break ;;
            "Quit")
                echo "Thank You for using the search. Exiting Student Search" 
                exit ;;
            *)
                echo "Invalid Option" ;;
        esac
    done
done
#end of filter
