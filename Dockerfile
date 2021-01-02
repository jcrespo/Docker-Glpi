FROM ubuntu:21.04
LABEL maintainer="Jcrespo - franciscojavier.crespo@gmail.com"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"

#Is required? Need pass variables?
ENV TZ=Europe/Madrid
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime

RUN apt update && apt upgrade -y --no-install-recommends
RUN apt install -y apache2 \
    wget \
    php7.4 \
    php7.4-json \
    php7.4-mbstring \
    php7.4-mysql \
    php7.4-cli \
    php7.4-curl \
    php7.4-xml \
    php7.4-gd \
    PHP7.4-imap \
    PHP7.4-ldap \
    php7.4-intl \
    php-apcu \
    php7.4-xmlrpc \
    php-cas \
    php7.4-zip \
    php7.4-bz2

RUN apt clean

# download, uncompress and copy
RUN wget https://github.com/glpi-project/glpi/releases/download/9.5.3/glpi-9.5.3.tgz \
    && tar zxvf glpi-9.5.3.tgz -C /var/www/html/ --strip 1 \
    && rm glpi-9.5.3.tgz

# clean and set permissions
RUN rm -f /var/www/html/index.html
RUN chown -R www-data:www-data /var/www/html/
RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# volume
VOLUME /var/www/html

# expose ports
EXPOSE 80

ENTRYPOINT ["/usr/sbin/apachectl"]
CMD ["-D", "FOREGROUND"]