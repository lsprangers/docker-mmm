# makes this the builder phase of things
FROM node:16-alpine as builder 
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# So now in our container there's a directory /app/build holding all of the files we will
#   need to serve using nginx

# Phase 2 - run
# Default command of nginx container will start up everything we move here so we
#   don't have to actually include a CMD
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
