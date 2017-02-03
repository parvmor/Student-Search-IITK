# NOTE: no #!/bin/bash so as to not spawn a new bash

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
