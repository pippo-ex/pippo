FROM elixir:1.9.4-alpine AS builder

ENV MIX_ENV prod

WORKDIR /build

RUN apk update --no-cache && \
    apk upgrade --no-cache && \
    apk add --no-cache git

RUN mix local.rebar --force && \
    mix local.hex --force

COPY . .

RUN mix deps.get --only ${MIX_ENV} && \
    mix compile && \
    mix release

FROM alpine:3.11

ENV HTTP_PORT 80

WORKDIR /opt/app

RUN apk update --no-cache && \
    apk upgrade --no-cache && \
    apk add --no-cache ncurses

COPY --from=builder /build/_build/prod/rel/* .

EXPOSE $HTTP_PORT

ENTRYPOINT ["/opt/app/bin/pippo", "start"]
