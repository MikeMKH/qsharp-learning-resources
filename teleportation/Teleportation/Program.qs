namespace Teleportation {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    
    operation Set(desired : Result, q1 : Qubit) : Unit {
        if (desired != M(q1)) {
            X(q1);
        }
    }
    
    operation Teleport(msg : Qubit, there : Qubit) : Unit {
        using (here = Qubit()) {
            H(here);
            CNOT(here, there);
            
            CNOT(msg, here);
            H(msg);
            
            // Measure out the entanglement
            if (M(msg) == One)  { Z(there); }
            if (M(here) == One) { X(there); }
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
            
            
            Set(Zero, target);
            Set(Zero, msg);
            
            return result;
        }
    }
}

