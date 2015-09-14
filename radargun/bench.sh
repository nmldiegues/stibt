#!/bin/bash

workload[1]="a"
workload[2]="b"
workload[3]="c"
workload[4]="d"
workload[5]="e"
workload[6]="f"

options[1]="true true true false"
options[2]="false false false false"
options[3]="true true true false"
options[4]="true true true false"
options[5]="true true true true"
options[6]="false true true false"
options[7]="true false true false"
options[8]="true true false false"

optStr[1]="col"
optStr[2]="ran"
optStr[3]="minuetPartial"
optStr[4]="minuetFull"
optStr[5]="colList"
optStr[6]="col-norepl"
optStr[7]="col-nocol"
optStr[8]="col-noghost"

emulation[1]="none"
emulation[2]="none"
emulation[3]="minuetPartial"
emulation[4]="minuetFull"
emulation[5]="none"
emulation[6]="none"
emulation[7]="none"
emulation[8]="none"

size[1]="1000000"
size[2]="1000000"
size[3]="1000000"
size[4]="1000000"

arity[1]="4"
arity[2]="8"
arity[3]="12"
arity[4]="32"


keyRange[1]="1000000"
keyRange[2]="1000000"
keyRange[3]="1000000"
keyRange[4]="1000000"

    for attempt in 1
    do
        echo "going for attempt $attempt"
        for nodes in 20
        do
        head -$nodes all_machines > /home/$USER/machines

                echo "going for nodes $nodes"
            for work in 1 2 3 4 5 6
            do
                echo "going for ro $ro"
                for opt in 1 2
                do
                echo "going for opt $opt"
                for sa in 3
                do
                echo "going for sa $sa"
                echo "bash btt-scripts/run-test.sh 50 ${size[$sa]} ${keyRange[$sa]} ${options[$opt]} ${arity[$sa]} ${emulation[$opt]} ${workload[$work]}"
                bash btt-scripts/run-test.sh 50 ${size[$sa]} ${keyRange[$sa]} ${options[$opt]} ${arity[$sa]} ${emulation[$opt]} ${workload[$work]} 1
                mv results-radargun/test-result-results2/infinispan4_ispn_$nodes.csv auto-results/$nodes-${optStr[$opt]}-${emulation[$opt]}-${size[$sa]}-${keyRange[$sa]}-${arity[$sa]}-${workload[$work]}-$attempt.csv
                rc=$?
                if [[ $rc != 0 ]] ; then
                    echo "Error within: bash btt-scripts/run-test.sh $nodes ${size[$sa]} ${keyRange[$sa]} ${options[$opt]} ${arity[$sa]} ${emulation[$opt]} ${workload[$work]}" >> auto-results/error.out
                fi
                done
                done
            done
        done
    done

