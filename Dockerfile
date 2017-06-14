FROM node:8-alpine as builder

# Need this to cache the npm install step
ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir -p /build && cp -a /tmp/node_modules /build

COPY . /build/

WORKDIR /build/
RUN npm run package
# Once this bug is fixed should be able to use prune
#   https://github.com/npm/npm/issues/12558
# RUN npm prune --production

FROM node:8-alpine

RUN npm install -g forever && npm cache clean --force

COPY --from=builder /build/ /app/

EXPOSE 3099
WORKDIR /app/
CMD forever ./bin/www

