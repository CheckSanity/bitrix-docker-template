#!/bin/bash

echo "Granting Bitrix user privileges..."

mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
GRANT SUPER ON *.* TO '${MYSQL_USER}'@'%';
GRANT SESSION_VARIABLES_ADMIN ON *.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
";

# Other migration scripts here

echo "Migration done!"
