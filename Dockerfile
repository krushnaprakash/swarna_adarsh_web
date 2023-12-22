FROM node:18-alpine
WORKDIR /app
COPY . .
RUN npm install --save react react-dom react-scripts
EXPOSE 3000
ENTRYPOINT ["npm","run","start"]

