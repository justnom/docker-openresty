# docker-openresty
Docker container for OpenResty based on Alpine linux.

## Usage

### Make a directory for files

```
mkdir -p /myapp
```

### Create a basic nginx configuration file

Save this to `/myapp/conf/nginx.conf`

    daemon off;  # This is crucial for Docker
    worker_processes 1;
    error_log logs/error.log;
    events {
        worker_connections 1024;
    }
    http {
        server {
            listen 80;
            location / {
                default_type text/html;
                content_by_lua 'ngx.say("<p>Hey! Love from Lua</p>")';
            }
        }
    }

### Run the docker container!

```
 docker run --name=openresty -d -v /myapp:/nginx -p 127.0.0.1:80:80 justnom/openresty
```

Yay! You now have an openresty server running!
