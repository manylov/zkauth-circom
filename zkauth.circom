pragma circom 2.0.0;

include "./circomlib/circuits/sha256/Sha256.circom";

template HashChecker (N) {  

   // Declaration of signals.  
   signal input value;  
   signal input hashToCheck;  
   signal output out;  

   component sha256 = Sha256(256);
   sha256.in <== value + N;
   var hashedValue = sha256.out;

   // Constraints.  
   out <==  hashToCheck - hashedValue;   // should be 0

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