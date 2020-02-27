let divs = new Array();
divs[0] = 'errFirst';
divs[1] = 'errLast';
divs[2] = 'errEmail';
divs[3] = 'errPassword';
divs[4] = 'errConfirm';
function validate() {
    let inputs = new Array();
    inputs[0] = document.getElementById('first').value;
    inputs[1] = document.getElementById('last').value;
    inputs[2] = document.getElementById('email').value;
    inputs[3] = document.getElementById('password').value;
    inputs[4] = document.getElementById('confirm').value;
    let errors = new Array();
    errors[0] = "<span>Please enter your first name!</span>";
    errors[1] = "<span>Please enter your last name!</span>";
    errors[2] = "<span>Please enter your email!</span>'";
    errors[3] = "<span>Please enter your password!</span>'";
    errors[4] = "<span>Please confirm your password!</span>'";
    for (i in inputs) {
        let errMessage = errors[i];
        let div = divs[i];
        if (inputs[i] === '')
            document.getElementById(div).innerHTML = errMessage;
        else if (i == 2) {
            let atpos = inputs[i].indexOf('@');
            let dotpos = inputs[i].lastIndexOf('.');
            if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= inputs[i].length)
                document.getElementById('errEmail').innerHTML = "<span>Enter a valid email address!</span>";
            else
                document.getElementById(div).innerHTML = 'OK!';
        }
        else if (i == 4) {
            let first = document.getElementById('password').value;
            let second = document.getElementById('confirm').value;
            if (second != first)
                document.getElementById('errConfirm').innerHTML = "<span>Your passwords don't match!</span>";
            else
                document.getElementById(div).innerHTML = 'OK!';
        }
        else
            document.getElementById(div).innerHTML = 'OK!';
    }
}
function finalValidate() {
    let count = 0;
    for (i = 0; i < 5; i++) {
        let div = divs[i];
        if (document.getElementById(div).innerHTML == 'OK!')
            count++;
    }
    if (count === 5)
        document.getElementById('errFinal').innerHTML = 'All the data you entered is correct!!!';
}