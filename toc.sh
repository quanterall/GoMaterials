#!/bin/bash

find .|grep md$|xargs -n1 tocenize
