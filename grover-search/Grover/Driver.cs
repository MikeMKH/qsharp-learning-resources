﻿using System;
using System.Threading.Tasks;
using Microsoft.Quantum.Simulation.Simulators;

namespace Microsoft.Quantum.Samples.SimpleGrover
{
    class Program
    {
        static void Main(string[] args)
        {
            var sim = new QuantumSimulator();
            var nDatabaseQubits = 7;

            var result = SearchForMarkedInput.Run(sim, nDatabaseQubits).Result;
            Console.WriteLine($"Result: {result}");

            Console.WriteLine("\n\nPress any key to continue...\n\n");
            Console.ReadKey();
        }
    }
}