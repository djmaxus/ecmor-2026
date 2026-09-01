#!/bin/env bash
mpiexec -n 16 flow --enable-tuning=1 --output-dir="./out" fine.data
