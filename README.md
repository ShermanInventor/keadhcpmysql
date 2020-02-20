The startup file is start-dhcp-server.sh. Make sure its in the same directory as your Dockerfile. 

The startup file has "keactrl start && tail -f /dev/null"

docker run --name=keadhcpserver --net=host -v /opt/kea-dhcp/kea:/usr/local/etc/kea -d keadhcpmysql:1.0

You will need a mysql or mariadb container. The mysql table creation sql is in /usr/local/share/kea/scripts/mysql/dhcpdb_create.mysql on the container ISC Kea wants you to pay for their host API so they have little docs on this part. Here is a what got me started its an old doc but works on all versions https://oldkea.isc.org/wiki/HostReservationsHowTo

I copied the config files to /opt/kea-dhcp/kea from /usr/local/etc/kea in the container so that i manipulate them outside of the container. In Kea DHCP you can manipulate the config files with out restarting the service. Make sure you setup your config files before starting it will cause problems.

