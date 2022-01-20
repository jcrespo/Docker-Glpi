FROM ubuntu:21.04

LABEL maintainer="Javier Crespo - javi@javiercrespo.es"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV TZ=Europe/Madrid
ENV PHP_VERSION=7.4
ENV GLPI_VERSION=9.5.6

RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime

RUN apt update && apt upgrade -y --no-install-recommends
RUN apt install -y apache2 \
    wget \
    php$PHP_VERSION \
    php$PHP_VERSION-json \
    php$PHP_VERSION-mbstring \
    php$PHP_VERSION-mysql \
    php$PHP_VERSION-cli \
    php$PHP_VERSION-curl \
    php$PHP_VERSION-xml \
    php$PHP_VERSION-gd \
    PHP$PHP_VERSION-imap \
    PHP$PHP_VERSION-ldap \
    php$PHP_VERSION-intl \
    php-apcu \
    php$PHP_VERSION-xmlrpc \
    php-cas \
    php$PHP_VERSION-zip \
    php$PHP_VERSION-bz2


# clean
RUN apt clean
RUN rm -f /var/www/html/index.html

# download, uncompress and copy
RUN wget https://github.com/glpi-project/glpi/releases/download/$GLPI_VERSION/glpi-$GLPI_VERSION.tgz \
    && tar zxvf glpi-$GLPI_VERSION.tgz -C /var/www/html/ --strip 1 \
    && rm glpi-$GLPI_VERSION.tgz

RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
RUN chown -R www-data:www-data /var/www/html/

# volume
VOLUME ["/var/www/html"]

# port
EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/usr/sbin/apachectl"]
CMD ["-D", "FOREGROUND"]
