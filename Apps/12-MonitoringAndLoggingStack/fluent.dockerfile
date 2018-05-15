FROM fluent/fluentd:v0.12-debian
RUN rm /fluentd/etc/fluent.conf
COPY ./confs/fluent.conf /fluentd/etc
