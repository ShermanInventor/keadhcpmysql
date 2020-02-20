CREATE USER 'keadhcp' IDENTIFIED BY 'secret';

GRANT ALL PRIVILEGES ON kea_dhcp.* TO 'keadhcp'@'%';

