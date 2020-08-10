FROM registry.access.redhat.com/ubi8-minimal

ENV CADDYFILE /config/caddy/Caddyfile

EXPOSE 80
EXPOSE 443
EXPOSE 2019

# See https://caddyserver.com/docs/conventions#file-locations for details
ENV XDG_CONFIG_HOME=/config
ENV XDG_DATA_HOME=/data

RUN set -eux; \
	mkdir -p \
		/config/caddy \
		/data/caddy \
		/etc/caddy

# Copy extra files to the image
COPY ./root/ /

VOLUME /config
VOLUME /data

# copy the binary
COPY build/ingress /usr/bin/ingress
# make it executable and test it
RUN chmod +x /usr/bin/ingress ; \
	ingress version

CMD run
