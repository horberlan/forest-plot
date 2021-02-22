#!/bin/bash
sudo apt-get update
#install package
sudo su - -c "R -e \"install.packages("meta")\""
sudo su - -c "R -e \"install.packages("grid")\""
sudo su - -c "R -e \"install.packages("readxl")\""

