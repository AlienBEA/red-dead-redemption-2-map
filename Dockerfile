# Setup the environment
# FROM node:10-alpine
#FROM --platform=linux/arm/v7 node:lts-alpine3.22
#ENV NODE_ENV=production
#ENV APP=/home/node/app
#RUN mkdir -p $APP/node_modules && chown -R node:node /home/node/*
#WORKDIR $APP

# Copy over tiles before anything else that may actually change, to ensure
# users don't have to re-download them when new versions are deployed.
#COPY --chown=node:node ./public/imgs/tiles ./public/imgs/tiles/

# Copy over package related files to install production modules
#COPY --chown=node:node ./package*.json ./
#COPY --chown=node:node ./bin/copy-assets-to-public.sh ./bin/

# Install production dependencies
#RUN npm i --only=production --quiet

# Copy local code to the image. In order to ensure users don't have to re-download
# an unchanged folder (like tiles) anytime something changes in public, copy
# over individual folders separately to leverage Docker's caching. The COPY
# commands are ordered by least to most likely to change.
#COPY --chown=node:node ./public/index.html ./public/
#COPY --chown=node:node ./public/markers.default.json ./public/
#COPY --chown=node:node ./public/imgs/icons ./public/imgs/icons/
#COPY --chown=node:node ./public/imgs/markers ./public/imgs/markers/
#COPY --chown=node:node ./server.js ./
#COPY --chown=node:node ./public/css ./public/css/
#COPY --chown=node:node ./public/js ./public/js/

# List off contents of final image
#RUN ls -la $APP

FROM ubuntu
WORKDIR /usr/local/app
# USER app
RUN apt update -y && apt upgrade -y
RUN apt install npm -y
RUN apt install git -y
RUN git clone https://github.com/the0neWhoKnocks/red-dead-redemption-2-map.git
RUN cd red-dead-redemption-2-map
RUN npm i
#CMD npm run start:dev
# Expose the default port from the server, on the container
EXPOSE 3000

# Start the app
CMD ["node", "server.js"]
