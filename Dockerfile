FROM php:7.4-apache

ENV APPBASEDIR /var/www/ssw_l/
# TODO: ENVIRON ARG dev/pord
ENV CONFIGFILE config.dev.php


# prepare app base
COPY ./000-default.conf /etc/apache2/sites-enabled/000-default.conf
RUN ln -s "/etc/apache2/mods-available/{headers,rewrite}.load" /etc/apache2/mods-enabled/
# copy from host
# TODO: 定数に
WORKDIR ${APPBASEDIR}

COPY index.php ${CONFIGFILE} .htaccess ${APPBASEDIR}
COPY ./script ${APPBASEDIR}/script
COPY ./store ${APPBASEDIR}/store
COPY ./style ${APPBASEDIR}/style
COPY ./req ${APPBASEDIR}/req


# mv config.php
RUN echo mv ${APPBASEDIR}${CONFIGFILE} ${APPBASEDIR}config.php &&\
    mv ${APPBASEDIR}${CONFIGFILE} ${APPBASEDIR}config.php


# readme.txtの指示
# chmod
RUN echo chmod u+rw ./store .htaccess &&\
    chmod u+rw ./store ./.htaccess


# chown
RUN echo chown www-data... &&\
    chown www-data:www-data ./store ./.htaccess

RUN a2enmod rewrite

