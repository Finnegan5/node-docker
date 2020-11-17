FROM node:15.2.1-alpine3.10

ARG NODE_ENV=production
ENV NODE_ENV $NODE_ENV

ARG PORT=3000
ENV PORT $PORT
EXPOSE $PORT 9229 9230

RUN mv ./usr/local/lib/node_modules/npm ./usr/local/lib/node_modules/npm.tmp \
  && mv ./usr/local/lib/node_modules/npm.tmp ./usr/local/lib/node_modules/npm \
  && npm install -g npm@7.0.11

RUN mkdir /opt/node_app
WORKDIR /opt/node_app

COPY package*.json ./
RUN npm install --only=production --no-optional && npm cache clean --force
ENV PATH /opt/node_app/node_modules/.bin:$PATH

WORKDIR /opt/node_app/app
COPY . .


CMD ["npm", "start"]
