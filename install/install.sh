#!/bin/bash

psql --host=localhost --port=5432 --user=postgres < install.sql
#cd .. && dbicdump -o dump_directory=./opt ACDwide::DB::Schema 'dbi:Pg:dbname="acdwide" host=127.0.0.1 port=5432' acdwide acdwide
sudo mkdir /var/log/ACDwide /etc/ACDwide
