FROM node:carbon

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install

# Download wait-for-it
# RUN curl -L https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -o ./wait-for-it.sh

# Make wait-for-it executable
# RUN chmod +x ./wait-for-me.sh

# Bundle app source
COPY . .

RUN chmod +x ./wait-for-me.sh

EXPOSE 3000