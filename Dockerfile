FROM ubuntu:21.04
LABEL maintainer="Jcrespo - franciscojavier.crespo@gmail.com"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"

#Is required? Need pass variables?
ENV TZ=Europe/Madrid
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime

RUN apt update && apt upgrade -y --no-install-recommends
RUN apt install -y apache2 \
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

WORKDIR /var/www/html/
RUN rm index.html
COPY ./src/glpi .
RUN chown -R www-data:www-data .
RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# expose ports
EXPOSE 80

ENTRYPOINT ["/usr/sbin/apachectl"]
CMD ["-D", "FOREGROUND"]