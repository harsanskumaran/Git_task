#!/bin/bash


file=file.txt

sed '5,${/welcome/s/give/learning/g}' $file

