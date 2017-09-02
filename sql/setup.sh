#!/bin/bash -x

mysql -u root -p -e "create database isuda"
cat isuda.sql | mysql -u root -p isuda
mysql -u root -p -e "create database isutar"
cat isutar.sql | mysql -u root -p isutar
