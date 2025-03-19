# Use a specific Node.js Alpine base image for consistency
FROM node:20-alpine

# Create and set the working directory inside the container
WORKDIR /app

# Remove npm cache manually to avoid corruption
RUN rm -rf /root/.npm

# Copy package.json and package-lock.json in one step to leverage Docker layer caching
COPY package*.json ./

# Install npm stable version and install dependencies with better conflict handling
RUN npm install -g npm@9.8.1
RUN npm install --legacy-peer-deps --force

# Copy the entire codebase to the working directory
COPY . .

# Expose the port your app runs on (replace with the actual port)
EXPOSE 3000

# Health check to ensure the container is running properly
HEALTHCHECK CMD curl --fail http://localhost:3000 || exit 1

# Define the command to start your application
CMD ["npm", "start"]
