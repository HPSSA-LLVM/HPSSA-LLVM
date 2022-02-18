// tau(x, x1, x2, x3) tau(y, y1, y2, y5)

//     prog->fuzzer->{
//   t1, t2, t3....
// }

// if (a > 90)
//   assert(0); // crashes a fuzzer.

// Guide the fuzzer to low frequency paths using Tau
//     information.cov = paths{p1, p2} = > t1,
//     t2,
//     t3 from these three testcases
//         .

//     while (True) : 0. Pick input from corpus.List of inputs
//         .(corpus)1. Mutate(input)
//         ->next_input,
//     -- > Insert our the algorithm 2. Run the binary with next_input,
//     (with some timeout)3. Maintains a coverge, prevC = {p1, p2, p3},
//     nextC =
//         {p1, p2, p3, p4} 4. Adds next_input->List of inputs
//             .(corpus)5. Add a negation condition that takes you to a low freq.

//         How fuzzer picks inputs
//     ? t1->e1,
//     t2->e2 e2 == e1,
//     (All inputs have equal energy for naive simple fuzzer.)

//         1. Capture x1,
//     x2,
//     x3.(Dataflow Analysis)
//         from tau information.Hot paths->We have inputs like this :
//     {x1, x2, x3} on those paths.In the IR we add a new condition,
//     similar to below using tau information.COND :
//     if (not(x == x1 and x == x2 and x == x3)) = > x == x4 assert(0);
// == > Cold Path(low freq path.)

//             int main() {
//             for {
//                 for {
//                   if {
//                     if {
//                     x:
//                       x1, x2, x3
//                     } else {
//                     x:
//                       x4
//                     }
//                   }
//                 }
//             }

//             ....if (not(x == x1 and x == x2 and x == x3 and x == x4 and
//                         x == x6...)) dummy();
//             return 0;
// }

//     The other is to use dataflow coverage. Note that for the tau nodes: tau(x, x1, x2),
//     if it takes one of the frequent paths then ((x = x1) \/ (x = x2)) must be satisfied. 
//     So, we add coverage for the case (not((x = x1) \/ (x = x2))). This is easy to do: 
//     add an if condition: if (not((x = x1) \/ (x = x2))) dummy(); So, normal branch coverage (in AFL) 
//     can now cover these cases too. 
// The whole scheme can be as follows:
// Run the fuzzer for some time on the original binary B1 and collect interesting inputs (say X1)
// 1, Create HPSSA with the interesting inputs X1
// 2, Add the mentioned instrumentation and create binary B2
// 3, Run the fuzzer on B2 with X1 as seed inputs;
//     collect interesting inputs(say X2) 4,
//         Goto 2 with X1 = X1 \cup X2 till timeout is reached 5,
//                     Check vulnerabilities found and coverage with X1 on B1