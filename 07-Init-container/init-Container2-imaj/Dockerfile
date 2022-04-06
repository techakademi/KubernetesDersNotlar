FROM alpine

RUN apk update

RUN apk add git

COPY docker_entrypoint.sh /docker_entrypoint.sh

ENTRYPOINT ["/docker_entrypoint.sh"]