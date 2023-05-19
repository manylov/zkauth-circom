pragma circom 2.0.0;

template HashChecker (N) {  

   // Declaration of signals.  
   signal input value;  
   signal input hashToCheck;  
   signal output out;  

   // Constraints.  
   out <==  hashToCheck - (value + N) - 1;   // should be 0

   out === 0;

   signal dummy;
   dummy <== value * hashToCheck;
}

//This circuit multiplies in1, in2, and in3.
template ZKAuth () {
   //Declaration of signals and components.
   signal input password;
   signal input passwordHash;
   signal input passwordPlusOneHash;
   signal output out;

   component pwdChecker = HashChecker(0);
   component pwdPlusOneChecker = HashChecker(1);

   //Statements.
   pwdChecker.value <== password;
   pwdChecker.hashToCheck <== passwordHash;

   pwdPlusOneChecker.value <== password;
   pwdPlusOneChecker.hashToCheck <== passwordPlusOneHash;

   var result = pwdChecker.out * pwdPlusOneChecker.out; // should be 0

   out <== result;
}

component main {public [passwordHash]} = ZKAuth();