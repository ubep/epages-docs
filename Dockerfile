FROM nginx:1.9.1

ADD ./_site /epages-docs
WORKDIR /epages-docs

ADD ./_docker/nginx.conf /etc/nginx/conf.d/default.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

CMD \
  if [ ! -z "$ELASTICSEARCH_PORT_9200_TCP_ADDR" ]; then \
    sed -i "s/127\.0\.0\.1:9200/$ELASTICSEARCH_PORT_9200_TCP_ADDR:$ELASTICSEARCH_PORT_9200_TCP_PORT/" /etc/nginx/conf.d/default.conf; \
  fi && \
  nginx
