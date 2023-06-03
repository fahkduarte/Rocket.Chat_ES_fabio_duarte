# Rocket.Chat Installation

I decided to install the Rocket.Chat server via Docker-Compose for two main reasons:

1. I'm studying Docker and Containerization right now.
2. Docker installation is more comfortable and also aligns with what the market is seeking for a technology standpoint.

### Setting Up my environment

In order to deploy I used WSL2 in my Desktop to install the Rocket.Chat server. I followed the steps described in this [article](https://nickjanetakis.com/blog/install-docker-in-wsl-2-without-docker-desktop) in order to Install Docker and Docker-Compose.

For the Rocket.Chat installation I followed the steps described in the documentation:

1. `curl -L https://raw.githubusercontent.com/RocketChat/Docker.Official.Image/master/compose.yml -O`
2. `cp env.example .env`
3. `docker compose up -d`

After this, I noticed that the port for the Rocket.Chat webserver was exposed to the port 3000:

```
root@DESKTOP-AO45K96:~/rocket.chat# docker ps
CONTAINER ID   IMAGE                                                COMMAND                  CREATED        STATUS          PORTS                    NAMES
b10ace8f47d0   registry.rocket.chat/rocketchat/rocket.chat:latest   "docker-entrypoint.s…"   22 hours ago   Up 56 minutes   0.0.0.0:3000->3000/tcp   rocketchat-rocketchat-1
2e14ecca3830   bitnami/mongodb:5.0                                  "/opt/bitnami/script…"   22 hours ago   Up 56 minutes   27017/tcp                rocketchat-mongodb-1
```

### API exercises - Access Token

Then, I headed to access it locally on my web browser and signed for the Rocket.Chat Cloud account. Moreover, I played with the application a bit and started to look for the documentation on how to make use of the API. 

I found the API Developer documentation and noticed that in order to make the request an access token was required.The documentation I used to create the access token can be found [here](https://developer.rocket.chat/reference/api/rest-api/endpoints/access-tokens-endpoints).

### API exercises - Create user

The documentation used to create the user may be found [here](https://developer.rocket.chat/reference/api/rest-api/endpoints/users-endpoints/create-user).

I copied the example in the documentation above and added it to a file called `script.sh` so I could better format the request so it could be easier to be handled. In order to make this easier to be read I'll only add the piece of code related to the `cURL` command below:

```
curl -H "X-Auth-Token: s6W6VkgpaQdh2Xthye-CrZYtZba5S36A0iBqTQ04Z5Y" \
            -H "X-User-Id: ooz6WsdQ4Ki7GR5WP" \
            -H "Content-type:application/json" \
            http://localhost:3000/api/v1/users.create \
            -d '{"name": "nexus2", "email": "spok.fabio@gmail.com2", "password": "123", "username": "test2"}'
```

The output I received after running the command were unformatted, so I decided to keep it this way):

```
root@DESKTOP-AO45K96:~/rocket.chat# bash script.sh
{"user":{"_id":"NeN8qXPL7S2nYpBTx","createdAt":"2023-06-03T02:26:51.304Z","username":"test2","emails":[{"address":"spok.fabio@gmail.com2","verified":false}],"type":"user","status":"offline","active":true,"__rooms":["GENERAL"],"_updatedAt":"2023-06-03T02:26:51.694Z","roles":["user"],"name":"nexus2","settings":{}},"success":true}
```

### API exercises - Get rooms information

The documentation used to list the rooms may be found [here](https://developer.rocket.chat/reference/api/rest-api/endpoints/rooms-endpoints/get-rooms).

The command I used:

```
curl -H "X-Auth-Token: s6W6VkgpaQdh2Xthye-CrZYtZba5S36A0iBqTQ04Z5Y" \
             -H "X-User-Id: ooz6WsdQ4Ki7GR5WP" \
             -H "Content-type: application/json" \
             http://localhost:3000/api/v1/rooms.get
```

The output I received after running the command were unformatted, so I decided to keep it this way). The listed rooms are the following ones:

```
root@DESKTOP-AO45K96:~/rocket.chat# bash script.sh
{"update":[{"_id":"6476c837dfe64350a25db969","fname":"Teste","_updatedAt":"2023-05-31T04:08:23.530Z","topic":"general","prid":"GENERAL","encrypted":false,"name":"ym6sHo6BeedFFMbt5","t":"c","msgs":0,"usersCount":1,"u":{"_id":"ooz6WsdQ4Ki7GR5WP","username":"fahkduarte","name":"Fábio Duarte"},"ts":"2023-05-31T04:08:23.483Z","ro":false,"default":false,"sysMes":true},{"_id":"GENERAL","ts":"2023-05-31T03:38:25.986Z","t":"c","name":"general","usernames":[],"msgs":5,"usersCount":3,"default":true,"_updatedAt":"2023-06-03T02:26:51.367Z","lastMessage":{"_id":"6476c837dfe64350a25db96b","t":"discussion-created","rid":"GENERAL","ts":"2023-05-31T04:08:23.554Z","msg":"Teste","u":{"_id":"ooz6WsdQ4Ki7GR5WP","username":"fahkduarte","name":"Fábio Duarte"},"groupable":false,"drid":"6476c837dfe64350a25db969","_updatedAt":"2023-05-31T04:08:23.566Z"},"lm":"2023-05-31T04:08:23.554Z"}],"remove":[],"success":true}
```

### Get a list of all user roles in the system via an API endpoint

The documentation used to get a list of all user roles in the system may be found [here](https://developer.rocket.chat/reference/api/rest-api/endpoints/roles-endpoints/list).

The piece of code used:

```
curl -H "X-Auth-Token: s6W6VkgpaQdh2Xthye-CrZYtZba5S36A0iBqTQ04Z5Y" \
     -H "X-User-Id: ooz6WsdQ4Ki7GR5WP" \
     http://localhost:3000/api/v1/roles.list
```

The output I received after running the command were unformatted, so I decided to keep it this way). The listed roles are the following ones:

```
root@DESKTOP-AO45K96:~/rocket.chat# bash script.sh
{"roles":[{"_id":"admin","scope":"Users","description":"Admin","mandatory2fa":false,"name":"admin","protected":true},{"_id":"moderator","scope":"Subscriptions","description":"Moderator","mandatory2fa":false,"name":"moderator","protected":true},{"_id":"leader","scope":"Subscriptions","description":"Leader","mandatory2fa":false,"name":"leader","protected":true},{"_id":"owner","scope":"Subscriptions","description":"Owner","mandatory2fa":false,"name":"owner","protected":true},{"_id":"user","scope":"Users","description":"","mandatory2fa":false,"name":"user","protected":true},{"_id":"bot","scope":"Users","description":"","mandatory2fa":false,"name":"bot","protected":true},{"_id":"app","scope":"Users","description":"","mandatory2fa":false,"name":"app","protected":true},{"_id":"guest","scope":"Users","description":"","mandatory2fa":false,"name":"guest","protected":true},{"_id":"anonymous","scope":"Users","description":"","mandatory2fa":false,"name":"anonymous","protected":true},{"_id":"livechat-agent","scope":"Users","description":"Livechat Agent","mandatory2fa":false,"name":"livechat-agent","protected":true},{"_id":"livechat-manager","scope":"Users","description":"Livechat Manager","mandatory2fa":false,"name":"livechat-manager","protected":true}],"success":true}
```

### Observations

- Every time I ran the `script.sh` file I commented the other `cURL` commands.
- It might be possible that I made some changes in the example `.env` file or in the example `compose.yml` file.
