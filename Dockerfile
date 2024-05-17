FROM  ubuntu

run apt-get update
run apt-get install nginx -y


WORKDIR /var/www/html/


COPY index.html .

EXPOSE 80


CMD ["nginx", "-g", "daemon off;"]
