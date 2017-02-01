# cool name!! yeah

for file in `ls superFilters`
do
    chmod 744 "superFilters/${file}"
    source "superFilters/${file}"
done

superFilter() {
    echo "Please select secondary filters:"
    PS3="Pick an Option(Enter Ctrl-C to exit):"
    select opt in "${options[@]}"
    do
        case "$opt" in
            "Roll Number")
                superRoll "$1"
                break ;;
            "Name")
                break ;;
            "Blood Group")
                break ;;
            "Department")
                break ;;
            "Email-ID")
                break ;;
            "Gender")
                break ;;
            "Hall")
                break ;;
            *)
                echo "Invalid Option" ;;
        esac
    done
    cd "${PWD}"
}
