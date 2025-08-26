# Use a lightweight Node.js base image
FROM node:20-alpine

# Set the working directory inside the container
WORKDIR /usr/src/app
#install curl
RUN apk add --no-cache curl
#COPY dist/*.* ./
COPY . /usr/src/app
# Copy package.json and package-lock.json to install dependencies
# This is done separately to leverage Docker's caching for faster builds
#COPY package*.json ./

# Install application dependencies
RUN npm install
RUN npm run build
#RUN npm run migration:run

ENV NODE_ENV=production

# Expose the port your Node.js application listens on
EXPOSE 3000

# Define the command to run your application when the container starts
CMD ["node", "dist/src/main.js"]
