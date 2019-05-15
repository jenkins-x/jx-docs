FROM abiosoft/caddy
EXPOSE 2015
WORKDIR /srv
COPY tmp-website .
