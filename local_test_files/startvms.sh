#!/bin/bash
docker start 'ssh1' 'ssh2' 'ssh3' 'ssh4';
docker ps | perl -ne 's/0.0.0.0/localhost/g;/\s(localhost:\d+)->/;print "root:screencast@".$1."\n" if $1 ' > local_test_files/mygroupfile;
chown $USER:$USER local_test_files/mygroupfile;
chmod 777 local_test_files/mygroupfile;
