#!/bin/bash

echo "Making Necessary Directories"
echo

cd ..
mkdir Students #top level root directory
cd Students
    
    for i in `seq 11 16`
    do
        echo "Making directories for Y${i}"
        mkdir "Y${i}"
        cd "Y${i}"
            if [ "${i}" = "16" ]; then
                for roll in `seq 160001 160832`
                do
                    mkdir "${roll}"
                    cd ${roll}
                        touch "Gender" "Hall" "Department" 
                        touch "BloodGroup" "Name" "Summary"
                        touch "EmailID" "Program"     
                    cd ..
                done
            fi
            if [ "${i}" = "15" ]; then
                for roll in `seq 150001 150845`
                do
                    mkdir "${roll}"
                    cd ${roll}
                        touch "Gender" "Hall" "Department" 
                        touch "BloodGroup" "Name" "Summary"
                        touch "EmailID" "Program"     
                    cd ..
                done
            fi
            if [ "${i}" = "14" ]; then
                for roll in `seq 14001 14832`
                do
                    mkdir "${roll}"
                    cd ${roll}
                        touch "Gender" "Hall" "Department" 
                        touch "BloodGroup" "Name" "Summary"
                        touch "EmailID" "Program"     
                    cd ..
                done
            fi
            if [ "${i}" = "13" ]; then
                for roll in `seq 13001 13819`
                do
                    mkdir "${roll}"
                    cd ${roll}
                        touch "Gender" "Hall" "Department" 
                        touch "BloodGroup" "Name" "Summary"
                        touch "EmailID" "Program"     
                    cd ..
                done
            fi
            if [ "${i}" = "12" ]; then
                for roll in `seq 12001 12837`
                do
                    mkdir "${roll}"
                    cd ${roll}
                        touch "Gender" "Hall" "Department" 
                        touch "BloodGroup" "Name" "Summary"
                        touch "EmailID" "Program"     
                    cd ..
                done
            fi
            if [ "${i}" = "11" ]; then
                for roll in `seq 11001 11833`
                do
                    mkdir "${roll}"
                    cd ${roll}
                        touch "Gender" "Hall" "Department" 
                        touch "BloodGroup" "Name" "Summary"
                        touch "EmailID" "Program"     
                    cd ..
                done
            fi
        cd ..
        echo "Directories for Y${i} made"
        echo 
    done

cd ..
cd script
echo "Necessary Directories Made"
echo
