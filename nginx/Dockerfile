FROM openresty/openresty:1.21.4.1-0-focal

RUN /usr/local/openresty/luajit/bin/luarocks install luaposix  

RUN mkdir /logs

COPY ./nginx/lua/* /usr/local/openresty/site/lualib
COPY ./nginx/lua/onlineconf-lua/lua/* /usr/local/openresty/site/lualib
COPY ./nginx/nginx.conf /usr/local/openresty/nginx/conf/nginx.conf

CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]
