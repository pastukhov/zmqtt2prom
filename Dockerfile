# syntax=docker/dockerfile:1.7

ARG SWIFT_VERSION=6.1.2

FROM swift:${SWIFT_VERSION} AS builder
WORKDIR /build

COPY Package.swift Package.resolved ./

RUN --mount=type=cache,target=/root/.swiftpm \
    swift package resolve

COPY Sources ./Sources
COPY Tests ./Tests

RUN --mount=type=cache,target=/root/.swiftpm \
    swift build -c release

FROM swift:${SWIFT_VERSION}-slim AS runner
WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends tini ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN useradd --system --create-home --home-dir /app --shell /usr/sbin/nologin app

COPY --from=builder /build/.build/release/zmqtt2prom /usr/local/bin/zmqtt2prom

USER app
EXPOSE 8080

ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/zmqtt2prom"]
