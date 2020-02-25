// Write a JavaScript code to solve a quadratic equation by reading the coefficients through dialog box. Also use confirm dialog box to check whether user wants to continue or not.

do {
    const msg = 'Enter the space separated coefficients a, b, and c for the equation ax^2 + bx + c = 0: ';
    const coeffs = prompt(msg).split(' ');
    const a = Number(coeffs[0]), b = Number(coeffs[1]), c = Number(coeffs[2]);
    if (!(isNaN(a) || isNaN(b) || isNaN(c) )) {
        const d = b**2 - 4*a*c;
        const r = -b/(2*a);
        if (d>0) { // the roots are real and distinct
            const sqrtD = Math.sqrt(d)/(2*a);
            const r1 = r + sqrtD;
            const r2 = r - sqrtD;
            alert(`The roots are real and distinct; their values are: \n${r1}, ${r2}`);
        } else if (d===0) { // the roots are real and equal
            alert(`The roots are real and equal; their values are: \n${r}, ${r}`);
        } else { // the root are complex and conjugates of each other
            const sqrtD = Math.sqrt(-d)/(2*a);
            const r1 = `${r} + ${sqrtD}i`;
            const r2 = `${r} - ${sqrtD}i`;
            alert(`The roots are complex and conjugates; their values are: \n${r1}, ${r2}`);
        }
    } else {
        alert('Enter only numeric values');
    }
} while (confirm('Do you want to continue?'));