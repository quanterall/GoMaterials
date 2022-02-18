#!/bin/bash

find .|grep md$|xargs -n1 toc -b false -s 1 -p
