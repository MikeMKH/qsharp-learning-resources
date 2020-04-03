namespace Teleportation {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    
    operation Teleport(msg : Qubit, there : Qubit) : Unit {
        using (here = Qubit()) {
            H(here);
            CNOT(here, there);
            
            CNOT(msg, here);
            H(msg);
            
            // Measure out the entanglement
            if (M(msg) == One)  { Z(there); }
            if (M(here) == One) { X(there); }
            
            Reset(here);
        }
    }
    
        operation TeleportClassicalMessage (message : Bool) : Bool {
        // Ask for some qubits that we can use to teleport.
        using ((msg, target) = (Qubit(), Qubit())) {

            // Encode the message we want to send.
            if (message) {
                X(msg);
            }

            // Use the operation we defined above.
            Teleport(msg, target);

            // Check what message was sent.
            let result = MResetZ(target) == One;
            
            ResetAll([target, msg]);
            
            return result;
        }
    }
}

