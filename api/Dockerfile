FROM elixir:1.8-otp-22

#   Install the Phoenix dependencies
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install hex phx_new 1.5.3 --force && \
    apt-get update

#   Install mix dependencies

ADD . /app/
WORKDIR /app

RUN  mix deps.get
RUN  mix deps.compile

RUN chmod +x entrypoint.sh
ENTRYPOINT "./entrypoint.sh"