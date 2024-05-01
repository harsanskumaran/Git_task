
FROM  tomcat:8.0

# Set the working directory for Tomcat
WORKDIR /usr/local/tomcat/webapps/ROOT/

# Copy contents into the Tomcat directory
COPY index.html .
)
EXPOSE 8080
CMD ["catalina.sh", "run"]
