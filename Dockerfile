FROM ubuntu:16.04

LABEL authors="Yves Hoppe, Robert Deutz"

# Install
RUN apt-get update \
	&& DEBIAN_FRONTEND='noninteractive' apt-get install -y  --allow-unauthenticated \
    git curl mysql-client wget postgresql-client \
    php php-common php-cli php-memcache php-memcached php-redis php-xdebug  \
	php-gd php-gettext php-mbstring php-mcrypt php-mysql php-sqlite3 \
    php-dom php-phpseclib php-pgsql php-curl php-ldap php-zip \
	&& sed -i 's/memory_limit\s*=.*/memory_limit=-1/g' /etc/php/7.0/cli/php.ini \
	&& php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
	&& php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
	&& php composer-setup.php --install-dir=bin --filename=composer \
	&& php -r "unlink('composer-setup.php');" \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
