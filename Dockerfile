FROM rust:1.83-bookworm AS build
WORKDIR /root
ARG VERSION
COPY v$VERSION.tar.gz /root
RUN tar -zxf v$VERSION.tar.gz
RUN cd wstunnel-$VERSION && cargo build --release --package wstunnel-cli
RUN cp wstunnel-$VERSION/target/release/wstunnel /usr/bin
RUN apt update && apt install --no-install-recommends tini

FROM gcr.io/distroless/cc-debian12
COPY --from=build /usr/bin/wstunnel /usr/bin/tini /usr/bin/
ENTRYPOINT ["tini", "--", "wstunnel"]
