// Write a JavaScript program to find the factorial of a number.
function factorial(n) {
    if (n<=0) return 1;
    return n*factorial(n-1);
}

const a = Number(prompt("Enter a number"));
if (isNaN(a)) {
    alert(`${a} is not a number!`);
} else {
    const f = factorial(a);
    alert(`${a}! = ${f}`);
}