FROM golang:1.13

WORKDIR /go/src/github.com/mccutchen/go-httpbin

COPY Makefile .
RUN make deps

COPY . .
RUN make build buildtests

FROM gcr.io/distroless/base
COPY --from=0 /go/src/github.com/mccutchen/go-httpbin/dist/go-httpbin* /bin/
EXPOSE 8080
CMD ["/bin/go-httpbin"]
