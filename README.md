STI-BT: A Scalable Transactional Index
============

The STI-BT is a highly scalable, transactional index for Distributed Key-Value stores. STI-BT is organized as a distributed B+Tree and adopts an innovative design that allows to achieve high efficiency in large-scale, elastic DKV stores. It is meant to act as a secondary index for such stores where the primary interface is a simple key-value access.

Some of the scripts in the code assume you place the radargun folder under /home/$USER/radargun in the machines where you will run it. The infinispan folder can be placed anywhere. It is assumed that these folders are placed in a machine that will "coordinate" the tests and that can reach the machines where the tests are actually run (the coordinator may be one of the executing machines).

Rough guidelines:
 * cd infinispan; mvn clean install -DskipTests
 * cd radargun; mvn clean install
 * create a file called "all\_machines" inside "radargun" with an IP/hostname per line for the machines to be used in the tests

It is assumed that the 1st machine in that list has 15GB of heap available, as the tests first load everything into one machine to try to speed up the loading, and only in the end they distribute it. If that is not the case, you can change this value in radargun/framework/src/main/resources/slave-coord.sh

 * create a folder /home/$USER/radargun/target/distribution/Radargun-1.1.0-SNAPSHOT in each machine where you will run
 * the "radargun/bench.sh" script may be used to launch everything from the coordinator machine (where the source code is); you can see that each execution corresponds to an invocation to the script "radargun/btt-scripts/run-test.sh" with the following parameters:
 * the number of nodes/machines is derived from the IPs in the /home/$USER/machines file, which is created by the script from the iteration values in the for loops
$1 - read-only percentage, unused unless no workload is specified in $10
$2 - how many keys to load in the index
$3 - the range of keys from which the keys are drawn
$4 - enable/disable the hybrid replication mechanism
$5 - enable/disable the sub-tree colocation
$6 - enable/disable the ghost reads
$7 - enable/disable the intra-node concurrency mechanism
$8 - the lower bound on the arity of the tree
$9 - "emulation" of the Minuet style of concurrency control for the index (either none, or some of the strings available in the bench.sh script)
$10 - the YCSB workload (from a to f)
$11 number of threads - unused in the current implementation

 * Create a folder called "radargun/auto-results".
 * You should now be able to invoke the bench.sh script and find the resulting CSV in the auto-results folder.

When using this work, please cite accordingly: 
 Nuno Diegues and Paolo Romano, "STI-BT: A Scalable Transactional Index", Proceedings of the International Conference on Distributed and Computer Systems, ICDCS 2014
