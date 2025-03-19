# Use Node.js Alpine base image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Remove npm cache for a clean state
RUN rm -rf /root/.npm

# Copy package files and install dependencies
COPY package*.json ./
RUN npm cache clean --force

# ✅ Use npm ci for clean, reproducible builds (better for CI/CD)
RUN npm ci --legacy-peer-deps --force

# ✅ Install npm locally instead of globally (avoids permission issues)
RUN npm install npm@9.8.1 --legacy-peer-deps --force

# Copy the rest of the app files
COPY . .

# Expose the port
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
