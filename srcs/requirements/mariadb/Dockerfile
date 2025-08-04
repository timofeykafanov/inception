FROM debian:bullseye

# Install MariaDB server
RUN apt-get update && apt-get install -y \
    mariadb-server mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Copy MariaDB configuration
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy startup script
COPY tools/start.sh /start.sh
RUN chmod +x /start.sh

RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

# Expose port 3306
EXPOSE 3306

# Start MariaDB
CMD ["/start.sh"]
