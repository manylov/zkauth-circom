circom zkauth.circom --r1cs --wasm --sym --c && \
cp input.json ./zkauth_js/input.json && \
cd zkauth_js && \
node generate_witness.js zkauth.wasm input.json witness.wtns && \
cd .. && \
snarkjs powersoftau new bn128 12 pot12_0000.ptau -v   && \
snarkjs powersoftau contribute pot12_0000.ptau pot12_0001.ptau --name="First contribution" -v && \
snarkjs powersoftau prepare phase2 pot12_0001.ptau pot12_final.ptau -v && \
snarkjs groth16 setup zkauth.r1cs pot12_final.ptau zkauth_0000.zkey && \
snarkjs zkey contribute zkauth_0000.zkey zkauth_0001.zkey --name="1st Contributor Name" -v && \
snarkjs zkey export verificationkey zkauth_0001.zkey verification_key.json  && \
snarkjs groth16 prove zkauth_0001.zkey ./zkauth_js/witness.wtns proof.json public.json && \
snarkjs zkey export solidityverifier zkauth_0001.zkey verifier.sol && \
snarkjs generatecall
