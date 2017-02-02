# cool name!! yeah

for file in `ls superFilters`
do
    chmod 744 "superFilters/${file}"
    source "superFilters/${file}"
done

superFilter() {
    echo "Please select secondary filters:"
    PS3="Pick an Option(Enter Ctrl-C to exit): "
    select opt in "${options[@]}"
    do
        case "$opt" in
            "Roll Number")
                superRoll "$1"
                break ;;
            "Name")
                break ;;
            "Blood Group")
                superBG "$1"
                break ;;
            "Department")
                superDept "$1"
                break ;;
            "Email-ID")
                break ;;
            "Gender")
                superGen "$1"
                break ;;
            "Hall")
                superHall "$1"
                break ;;
            *)
                echo "Invalid Option" ;;
        esac
    done
    PS3="Pick an Option(Enter 9 or Ctrl-C to exit the search): "
    cd "${PWD}"
}
