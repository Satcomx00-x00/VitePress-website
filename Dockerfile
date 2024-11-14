# Use the official Node.js image as the base
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /app

# Install pnpm globally
RUN npm install -g pnpm

# Copy package.json to install dependencies
COPY package.json ./

# Install dependencies using pnpm
RUN pnpm install

# Copy the application code except for node_modules
COPY . .

# Build the VitePress site
RUN pnpm docs:build

# Install a lightweight static file server as a local dependency
RUN pnpm add serve

# Expose port 5000 for the server
EXPOSE 5173

# Serve the built site, binding to 0.0.0.0
#CMD ["npm", "serve", "-s", "docs/.vitepress/dist", "-l", "5000", "--host", "0.0.0.0"]
CMD ["pnpm", "run", "docs:dev"]
