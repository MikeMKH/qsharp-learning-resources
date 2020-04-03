namespace Testing {
    
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Environment;


    @Test("QuantumSimulator")
    @Test("ResourcesEstimator")
    operation AllocateQubit () : Unit {
        
        using (q = Qubit()) {
            Assert([PauliZ], [q], Zero, "Newly allocated qubit must be in |0> state.");
        }
        
        Message("Test passed.");
    }
    
    @Test("QuantumSimulator")
    operation AssertQubitsAreAvailable() : Unit
    {
         Fact(GetQubitsAvailableToUse() > 0, "No qubits were actually available");
    }
    
    @Test("QuantumSimulator")
    operation AssertInitialQubitAreZero() : Unit
    {
        using(q = Qubit())
        {
            H(q);
            Assert([PauliX], [q], Zero, "By the anthropic principle that the state of register at this point is |+〉");
            Reset(q);   
        }
    }
    
    @Test("QuantumSimulator")
    operation AssertIdentityDoesNotChangeQubit() : Unit
    {
        using(q = Qubit())
        {
            H(q);
            Assert([PauliX], [q], Zero, "By the anthropic principle that the state of register at this point is |+〉");
            I(q);
            Assert([PauliX], [q], Zero, "Identity function must leave register as |+〉");
            Reset(q);   
        }
    }
}