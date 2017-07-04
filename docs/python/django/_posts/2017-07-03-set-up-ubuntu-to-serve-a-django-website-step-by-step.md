---
description: 
---

## Overview

This is a guide to have a website in an Ubuntu server using **nginx**
and **systemd**.

Ubuntu uses *systemd* to manage system and service daemons and
processes, we will create configuration files to:

- create temporary files
- manage gunicorn system service
- manage gunicorn system socket

And lastly configuring *nginx* to handle requests.

We assume the following configuration to set up the server, this is a
basic configuration example to follow the tutorial and be easier to
customize with your own data:

- website domain: `example.com`
- Django source code located in `/home/chengue/sites/example`
- environment variable pointing to production settings:
  `DJANGO_SETTINGS_MODULE=example.settings.production``
- Python virtual environment for the `example` project at:
  `/home/chengue/.virtualenvs/example`
- Ubuntu User: chengue

At the end of the tutorial we will have:

- nginx handling requests to `example.com`
- traffic gets redirected from *non-www* to *www* 

## Configuring Systemd services

### Socket

To handle incoming Gunicorn requests we create a unix socket
controlled by *systemd*. As the configuration filename should end in
`.socket` we create the following file:
`/etc/systemd/system/gunicorn.socket`.

~~~
[Unit]
Description=gunicorn socket

[Socket]
ListenStream=/run/gunicorn/socket

[Install]
WantedBy=sockets.target
~~~

*systemd* will listen on this socket and start **Gunicorn**
automatically in response to traffic.
{: cite="http://docs.gunicorn.org/en/stable/deploy.html#systemd"}

This sockets will be used by Gunicorn service using the parameter
`--bind unix:/run/gunicorn/socket` in the service file.

### Service

Then the service that use the above socket, In
`/etc/systemd/system/gunicorn.service`:

~~~
[Unit]
Description=gunicorn daemon
Requires=gunicorn.socket
After=network.target

[Service]
PIDFile=/run/gunicorn/pid
User=chengue
Group=www-data
RuntimeDirectory=gunicorn
WorkingDirectory=/home/chengue/sites/example/example
ExecStart=/home/chengue/.virtualenvs/example/bin/gunicorn \
          --access-logfile /home/chengue/sites/logs/example.access.log \
          --error-logfile /home/chengue/sites/logs/example.error.log \
          --pid /run/gunicorn/pid   \
          --env DJANGO_SETTINGS_MODULE=example.settings.production \
          --bind unix:/run/gunicorn/socket example.wsgi
ExecReload=/bin/kill -s HUP $MAINPID
ExecStop=/bin/kill -s TERM $MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target
~~~

Be sure to adjust `WorkingDirectory` to your application root.
{: .alert .alert-info}

### Temporal file

Temporal files handled by *systemd* are located in `/etc/tmpfiles.d/`,
we create `/etc/tmpfiles.d/gunicorn.conf` with the following content:

~~~
d /run/gunicorn 0755 chengue www-data -
~~~

`www-data` is the Linux group of `nginx`.
{: .alert .alert-info}

## Web proxy

Lastly, configure the web proxy to send traffic to the *Gunicorn*
socket. Create a virtual site in `/etc/nginx/sites-available/example.com`:

~~~
server {
	# redirect www to non-www
    server_name www.example.com;
    return 301 $scheme://example.com$request_uri;
}

server {
	server_name example.com;

	#location /static {
	#    alias /home/chengue/sites/example/static;
	#}

	#location /media {
	#    alias /home/chengue/sites/example/media;
	#}

	location / {
		proxy_set_header Host $host;
		proxy_pass http://unix:/run/gunicorn/socket;
	}
}
~~~

Now that we have our `example.com` configuration as an available
website in nginx, we should enable it creating a symbolic link in
`/etc/nginx/sites-enabled/example.com` pointing to the above file:

<kbd>sudo ln -s /etc/nginx/sites-available/example.com \
    /etc/nginx/sites-enabled/example.com</kbd>

## Commands

### Enabling services

Enable services to autostart at boot:

<kbd>systemctl enable gunicorn.socket</kbd>
<kbd>systemctl enable nginx.service</kbd>

### Activate services

Manually activating services:

<kbd>systemctl start gunicorn.socket</kbd>
<kbd>systemctl start nginx</kbd>

### Testing

To test if Gunicorn works <kbd>curl --unix-socket /run/gunicorn/socket
http</kbd> should retrieve an HTML from the server.

### Status

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>systemctl status gunicorn.socket</kbd>
● gunicorn.socket - gunicorn socket
   Loaded: loaded (/etc/systemd/system/gunicorn.socket; enabled; vendor preset: enabled)
   Active: active (running) since Mon 2017-07-03 18:52:15 EDT; 2h 58min ago
   Listen: /run/gunicorn/socket (Stream)

Jul 03 18:52:15  systemd[1]: Closed gunicorn socket.
Jul 03 18:52:15  systemd[1]: Stopping gunicorn socket.
Jul 03 18:52:15  systemd[1]: Listening on gunicorn socket.
<span class="shell-prompt">$</span> <kbd>systemctl status gunicorn.service</kbd>
   Loaded: loaded (/etc/systemd/system/gunicorn.service; disabled; vendor preset: enabled)
   Active: active (running) since Mon 2017-07-03 18:52:15 EDT; 2h 59min ago
 Main PID: 14216 (gunicorn)
    Tasks: 2 (limit: 4915)
   Memory: 41.8M
      CPU: 5.544s
   CGroup: /system.slice/gunicorn.service
           ├─14216 /home/chengue/.virtualenvs/example/bin/python3.6 /home/chengue/.virtualenvs/example/bin/gunicorn --access
           └─14252 /home/chengue/.virtualenvs/pullgravity/bin/python3.6 /home/chengue/.virtualenvs/example/bin/gunicorn --access

Jul 03 18:52:15  systemd[1]: Started gunicorn daemon.
<span class="shell-prompt">$</span> <kbd>systemctl status nginx.service</kbd>
   Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
  Drop-In: /etc/systemd/system/nginx.service.d
           └─override.conf
   Active: active (running) since Mon 2017-07-03 18:52:21 EDT; 3h 1min ago
     Docs: man:nginx(8)
 Main PID: 14353 (nginx)
    Tasks: 2 (limit: 4915)
   Memory: 2.8M
      CPU: 205ms
   CGroup: /system.slice/nginx.service
           ├─14353 nginx: master process /usr/sbin/nginx -g daemon on; master_process on;
           └─14357 nginx: worker process

Jul 03 18:52:21  systemd[1]: Starting A high performance web server and a reverse proxy server...
Jul 03 18:52:21  systemd[1]: Started A high performance web server and a reverse proxy server.
</samp>
</pre>

### Debugging

An useful command to see *systemd* logs filtered by service is
<kbd>journalctl</kbd>, it query the *systemd* journal and with the
`-u` parameter show messages for the specified systemd unit.

Using our services:

<kbd>journalctl -u nginx.service</kbd>
<kbd>journalctl -u gunicorn.service</kbd>
<kbd>journalctl -u gunicorn.socket</kbd>

## References

- Official page <https://www.freedesktop.org/wiki/Software/systemd/>
- Gunicorn systemd section <http://docs.gunicorn.org/en/stable/deploy.html#systemd>
- Linux manual pages:
  - <kbd>man systemd.socket</kbd>
  - <kbd>man systemd.service</kbd>
  - <kbd>man tmpfiles.d</kbd>
