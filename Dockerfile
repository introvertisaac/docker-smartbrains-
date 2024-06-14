# Use an official Node.js runtime as a parent image
FROM node:14

# Install dependencies for Electron and other required packages
RUN apt-get update && apt-get install -y \
    xvfb \
    x11vnc \
    fluxbox \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install the app dependencies
RUN npm install

# Set the environment variable to prevent the Electron window from displaying
ENV DISPLAY=:99

# Start the X server, VNC server, and Electron app
CMD ["sh", "-c", "xvfb-run -s '-screen 0 1024x768x24' fluxbox & x11vnc -forever -usepw -create & npm start"]
