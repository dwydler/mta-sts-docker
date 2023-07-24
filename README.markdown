# Online MTA-STS testing tool

This tool verifies whether a give host correctly implements the new in-development <a href="https://github.com/mrisher/smtp-sts">MTA-STS standard</a> for downgrade-resistant secure email. It is very new and not very well tested so don't rely on it's result too much.

Online version: https://mta-sts-validator.wydler.eu/

License: BSD 2-clause license (see LICENSE.txt).

## Installing application on Ubuntu 22.04 LTS

 1. Install dependencies:

        $ apt install uwsgi uwsgi-plugin-python3 python3-flask python3-flask-limiter python3-dnspython

 2. Create a configuration file for uWSGI at `/etc/uwsgi/apps-available/emperor.ini`:

    ```ini
    [uwsgi]
	emperor = /etc/uwsgi/vassals
	uid = www-data
	gid = www-data
	limit-as = 512
	reload-on-as = 128
	reload-on-rss = 192
	logto = /tmp/uwsgi.log
    ```
        $ chmod 644 /etc/uwsgi/apps-available/emperor.ini
        $ cd /etc/uwsgi/apps-enabled
        $ ln -s ../apps-available/emperor.ini .
        $ cd ~
	
 3. Create `/etc/uwsgi/vassals/`:
 
        $ mkdir /etc/uwsgi/vassals
        $ chmod 755 /etc/uwsgi/vassals
	
 4. Create a configuration for this app at `/etc/uwsgi/vassals/mta-sts.ini`:

    ```ini
	[uwsgi]
	socket             = 127.0.0.1:17000
	manage-script-name = true
	mount              = /=check:app
	plugins            = python3
	chmod-socket       = 660
	pythonpath         = /var/www/html/mta-sts
	stats              = 127.0.0.1:17005
	vacuum             = True
	processes          = 1
	pidfile            = /tmp/%n.pid
    ```
        $ chmod 644 /etc/uwsgi/vassals/mta-sts.ini

 5. Restart service:
 
        $ service uwsgi restart		

 6. Install the application:
	
        $ git clone --branch customizing https://codeberg.org/wd/mta-sts /var/www/html/mta-sts
		

 7. Install a montioring tool for it:
	
        $ apt install python3-pip
		
        $ pip3 install setuptools wheel
        $ pip3 install uwsgitop
        $ pip3 install Flask-Limiter

        $ uwsgitop 127.0.0.1:17005

		
## Installing apache2 on Ubuntu 22.04 LTS

 1. Install webserver and dependencies:

        $ apt install apache2 apache2-dev
        $ wget https://github.com/unbit/uwsgi/raw/master/apache2/mod_proxy_uwsgi.c
        $ apxs2 -i -c mod_proxy_uwsgi.c
        $ a2enmod proxy_http

 2. Expand existing webserver configuration with these lines. For example `/etc/apache2/sites-available/000-default.conf`:

    ```apache2
	<VirtualHost *:80>
	...
    LoadModule proxy_uwsgi_module /usr/lib/apache2/modules/mod_proxy_uwsgi.so
	ProxyPass /mta-sts/api uwsgi://127.0.0.1:17000
	ProxyPassReverse /mta-sts/api uwsgi://127.0.0.1:17000
	...
	</VirtualHost>
    ```

 3. Restart service:
 
        $ systemctl restart apache2


## Installing nginx on Ubuntu 22.04 LTS

 1. Install webserver:

        $ apt install nginx

 2. Expand existing webserver configuration with these lines. For example `/etc/nginx/sites-enabled/default`:

    ```nginx
		# proxy_cache_bypass $http_upgrade;
	}
	...
	location = /mta-sts/api {
		include uwsgi_params;
		uwsgi_pass 127.0.0.1:17000;
	}
	...
	# pass the PHP scripts to FastCGI server listening on 127.0.0.1:17000
	#
    ```
 3. Restart service:
 
        $ systemctl restart nginx
		

## Remark
  Don't forget to test, that the applcation works sucessully.
        
		$ http(s)://IP-Addresse or FQDN/mta-sts/