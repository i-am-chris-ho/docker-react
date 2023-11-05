FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# Used by AWS Elastic Beanstalk - otherwise, functionally does nothing (locally)
EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html
