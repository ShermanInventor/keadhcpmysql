This is a Kea-DHCP 1.6.1 server with MySQL support. It was compiled with MariaDB 10.3 libraries.

The GitHub repo for everything is in https://github.com/ShermanInventor/keadhcpmysql

The startup file is start-dhcp-server.sh. Make sure its in the same directory as your Dockerfile. 

The startup file has "keactrl start && tail -f /dev/null"

docker run --name=keadhcpserver --net=host -v /opt/kea-dhcp/kea:/usr/local/etc/kea -d keadhcpmysql:1.0

You will need a mysql or mariadb container. The mysql table creation sql 
is in /usr/local/share/kea/scripts/mysql/dhcpdb_create.mysql on the container. 
Copy that sql script to a folder. In this example below I called my folder mariadb-entrypoint. You will 
need to modify the SQL script to create the database and also add a SQL script to create a user that
can access that database. I have included everything in GitHub

docker run --name kea-dhcp-mariadb -v /opt/kea-dhcp/mariadb-entrypoint:/docker-entrypoint-initdb.d -p 3306:3306 --env MYSQL_ROOT_PASSWORD=secret -d mariadb:latest

ISC Kea wants you to pay for their host API so they have little docs on this part. 
Here is a what got me started its an old doc but works on all versions 
https://oldkea.isc.org/wiki/HostReservationsHowTo

I copied the config files to /opt/kea-dhcp/kea from /usr/local/etc/kea in the container so that I can 
manipulate them outside of the container. In Kea DHCP you can manipulate the config files with out 
restarting the service. Make sure you setup your config files before starting it will cause problems.

