function validate() {
	var firstName = document.getElementById("firstName").value;
	var lastName = document.getElementById("lastName").value;
	fail = (firstName == '' ) || (lastName == '' );
	if (fail) {
		alert("No te dejes ningún dato! ;)");
	}
	return !fail;
}