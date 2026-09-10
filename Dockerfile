FROM nginx:1.27-alpine

# Remove default nginx config and static files
RUN rm -rf /etc/nginx/conf.d/default.conf /usr/share/nginx/html/*

# Copy custom configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy website content (static site: 19 páginas + styles.css + img/)
COPY . /usr/share/nginx/html/

# Remove build artifacts that must not be served
RUN rm -f /usr/share/nginx/html/Dockerfile /usr/share/nginx/html/nginx.conf /usr/share/nginx/html/CNAME

# Fix permissions
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
