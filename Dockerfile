#FROM node
#FROM node:15.1.0-alpine3.10 as build
FROM node:8.11
WORKDIR /app

#RUN apk add git openssh-client

USER root
RUN mkdir -m 700 ~/.ssh && touch -m ~/.ssh/known_hosts && ssh-keyscan github.com > ~/.ssh/known_hosts

RUN git config --global url."https://github.com/".insteadOf ssh://git@github.com:
RUN git config --global url."https://github.com/".insteadOf ssh://github.com

RUN npm config set registry https://registry.npmjs.org/

RUN npm install --unsafe-perm -g gulp sha3
#react-scripts

# Install Truffle
RUN npm install --unsafe-perm  -g truffle@5.0.19
RUN npm config set bin-links false

# Move Contract Files
COPY contracts ./contracts
COPY migrations ./migrations
COPY test ./test
COPY truffle-config.js ./truffle-config.js

RUN mkdir -p output/contracts/


# Move React Files
RUN mkdir client
COPY client/src ./client/src
COPY client/scripts ./client/scripts
COPY client/config ./client/config
COPY client/public ./client/public
COPY client/package.json ./client/package.json
COPY client/package-lock.json ./client/package-lock.json

#RUN mkdir -p ./client/src/contracts/
#RUN mkdir -p output/contracts/

# Hacemos el Build de la app React
RUN cd client && npm i web3@1.0.0-beta.37 sha3@1.2.0 env-cmd dotenv  && npm install 

#RUN npm run build

#WORKDIR /app

# PREPRODUCCION
##############
# Exponer puerto usado en la aplicación
#EXPOSE 5000
# Correr la aplicación
#CMD [ "npm","run", "start" ]







