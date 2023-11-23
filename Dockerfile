FROM alpine:3.18 as builder 
WORKDIR /src
RUN apk add --no-cache git make build-base 
COPY ./src /src 
RUN sed -i "s/SERVERLDFLAGS =/SERVERLDFLAGS = -static/g" /src/src/GNUmakefile && make

FROM scratch
COPY --from=builder /src/bin/vlmcsd /vlmcsd
EXPOSE 1688/tcp
ENTRYPOINT [ "/vlmcsd" ]
CMD [ "-vedD" ]
