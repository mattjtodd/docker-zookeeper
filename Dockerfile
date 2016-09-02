FROM java:openjdk-8-jre-alpine

ENV MIRROR=http://mirror.vorboss.net/apache
ENV VERSION=3.4.8
ENV SIGN=http://www-eu.apache.org/dist

LABEL name="zookeeper" version=$VERSION

WORKDIR /opt/zookeeper

RUN set -ex \
    && apk update \
    && apk add --no-cache wget bash gnupg \
    && apk add --upgrade tar \
    && wget -q $SIGN/zookeeper/zookeeper-$VERSION/zookeeper-$VERSION.tar.gz.asc \
    && wget -q --show-progress --progress=bar:force $MIRROR/zookeeper/zookeeper-$VERSION/zookeeper-$VERSION.tar.gz \
    && wget -q -O - http://www-eu.apache.org/dist/zookeeper/KEYS | gpg --import \
    && gpg --verify zookeeper-$VERSION.tar.gz.asc \
    && tar -zxvf zookeeper-$VERSION.tar.gz --strip=1 \
    && rm zookeeper-$VERSION.tar.gz* \
    && apk del wget gnupg \
    && rm -rf /var/cache/apk/*

RUN set -ex \
    && echo "tickTime=2000" > conf/zoo.cfg \
    && echo "dataDir=/opt/zookeeper/data" >> conf/zoo.cfg \
    && echo "dataLogDir=/opt/zookeeper/data-log" >> conf/zoo.cfg \
    && echo "clientPort=2181" >> conf/zoo.cfg

EXPOSE 2181 2888 3888

COPY docker-entrypoint.sh /

VOLUME ["/opt/zookeeper/conf", "/opt/zookeeper/data", "/opt/zookeeper/data-log"]

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["start-foreground"]