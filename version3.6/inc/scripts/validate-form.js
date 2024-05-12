function validateForm() {
    var name = document.forms["dl-zeus-form"]["Name"].value;
    var position = document.forms["dl-zeus-form"]["Position"].value;
    var institution = document.forms["dl-zeus-form"]["Institution"].value;
    var email = document.forms["dl-zeus-form"]["email"].value;
    if (name == null || name == "") {
        alert("The name field must be completed with your full name.");
        return false;
    }
    if (position == null || position == "") {
        alert("The position field must be completed with your current position (e.g., professor, PhD student, etc.).");
        return false;
    }
    if (institution == null || institution == "") {
        alert("The institution field must be completed with the name of your institution.");
        return false;
    }
    if (email == null || email == "") {
        alert("The e-mail field must be completed with your valid e-mail address.");
        return false;
    }   
}
