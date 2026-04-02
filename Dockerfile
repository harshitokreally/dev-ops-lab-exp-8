# Use Nginx as the base image for a lightweight web server
FROM nginx:alpine [cite: 17]

# Copy the local index.html file into the Nginx default public directory
COPY index.html /usr/share/nginx/html/index.html 

# Expose port 80 to allow external access to the web server
EXPOSE 80 [cite: 20]
