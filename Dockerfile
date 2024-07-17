FROM ballerina/ballerina:2201.9.2 AS ballerina-build

USER root

COPY book_service /home/work-dir/book_service
WORKDIR /home/work-dir/book_service

RUN bal build

FROM eclipse-temurin:17-jre-alpine

RUN mkdir -p /work-dir \
    && addgroup troupe \
    && adduser -S -s /bin/bash -g 'ballerina' -G troupe -D ballerina \
    && apk upgrade \
    && apk add --no-cache libc6-compat\
    && rm -rf /var/cache/apk/* \
    && chown -R ballerina:troupe /work-dir \
    && chown -R ballerina:troupe /mnt

USER ballerina

WORKDIR /home/work-dir/

COPY --from=ballerina-build /home/work-dir/book_service/target/bin/book_service.jar /home/work-dir/

EXPOSE 9090

CMD java -jar book_service.jar 

