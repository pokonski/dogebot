FROM alpine:3.4

ENV HOME=/app
ENV PATH="$PATH:$HOME/node_modules/.bin"

RUN apk add --no-cache nodejs && adduser -D -h $HOME hubot

COPY package.json npm-shrinkwrap.json $HOME/

WORKDIR $HOME
RUN npm install

COPY . $HOME/

USER hubot
CMD ["hubot", "--adapter", "slack", "--alias", "!"]
