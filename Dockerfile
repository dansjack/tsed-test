###############################################################################
###############################################################################
##                      _______ _____ ______ _____                           ##
##                     |__   __/ ____|  ____|  __ \                          ##
##                        | | | (___ | |__  | |  | |                         ##
##                        | |  \___ \|  __| | |  | |                         ##
##                        | |  ____) | |____| |__| |                         ##
##                        |_| |_____/|______|_____/                          ##
##                                                                           ##
## description     : Dockerfile for TsED Application                         ##
## author          : TsED team                                               ##
## date            : 2021-04-14                                              ##
## version         : 1.1                                                     ##
##                                                                           ##
###############################################################################
###############################################################################
# Staging build
# This build created a staging docker image 
#
FROM node:14-alpine AS appbuild

RUN apk update && apk add build-base git python

COPY package.json ./

RUN npm install

COPY . ./

ENV NODE_ENV production

RUN npm run build

# Production build
FROM node:14-alpine

COPY package.json ./

RUN npm install --production

COPY --from=appbuild ./dist ./dist

ENV NODE_ENV production

CMD ["npm", "start"]
