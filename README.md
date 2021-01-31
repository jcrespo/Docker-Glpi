# GLPI

[Wikipedia](https://en.wikipedia.org/wiki/GLPi)

GLPI (acronym: French: Gestionnaire Libre de Parc Informatique, or "Open Source IT Equipment Manager" in English) is an open source IT Asset Management, issue tracking system and service desk system. This software is written in PHP and distributed under the GNU General Public License.

As an open source technology, anyone can run, modify or develop the code. This way, contributors can participate in the development of the software by committing free and open source supplementary modules on GitHub.

GLPI is a web-based application helping companies to manage their information system. The solution is able to build an inventory of all the organization's assets and to manage administrative and financial tasks. The system's functionalities help IT Administrators to create a database of technical resources, as well as a management and history of maintenances actions. Users can declare incidents or requests (based on asset or not) thanks to the Helpdesk feature.

## Supported Architectures

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |

## Usage

Here are an example snippet to help you get started creating a container.

### docker-compose ([recommended](https://docs.docker.com/compose/))


```yaml
---
version: '3.3'

services:
   db:
     image: mysql:5.7
     volumes:
       - mysql:/var/lib/mysql:rw
     restart: unless-stopped
     environment:
       MYSQL_ROOT_PASSWORD: glpi
       MYSQL_DATABASE: glpi
       MYSQL_USER: glpi
       MYSQL_PASSWORD: glpi

   glpi:
     depends_on:
       - db
     image: fjcj/glpi:latest
     ports:
       - "80:80"
     volumes:
       - glpi:/var/www/html:rw
     restart: unless-stopped

volumes:
  mysql:
  glpi:
```

## Application Setup

Webui can be found at `http://<your-ip>:80`

More information can be found in their official documentation [here](https://glpi-install.readthedocs.io/en/latest/install/wizard.html) .

## Updating Info

Below are the instructions for updating containers:

### Via Docker Compose
* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull glpi`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d glpi`
* You can also remove the old dangling images: `docker image prune`

Enjoy!