FROM alpine:latest as builder 
WORKDIR /src
RUN apk add --no-cache git make build-base 
COPY ./src /src 
RUN make

FROM busybox:glibc
COPY --from=builder /src/bin/vlmcsd /bin/vlmcsd
EXPOSE 1688/tcp
CMD [ "/bin/vlmcsd", "-vedD" ]
