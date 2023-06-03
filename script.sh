curl -H "X-Auth-Token: s6W6VkgpaQdh2Xthye-CrZYtZba5S36A0iBqTQ04Z5Y" \
            -H "X-User-Id: ooz6WsdQ4Ki7GR5WP" \
                 -H "Content-type:application/json" \
                      http://localhost:3000/api/v1/users.create \
                          -d '{"name": "nexus2", "email": "spok.fabio@gmail.com2", "password": "123", "username": "test2"}'

curl -H "X-Auth-Token: s6W6VkgpaQdh2Xthye-CrZYtZba5S36A0iBqTQ04Z5Y" \
             -H "X-User-Id: ooz6WsdQ4Ki7GR5WP" \
                  -H "Content-type: application/json" \
                       http://localhost:3000/api/v1/rooms.get
                       
curl -H "X-Auth-Token: s6W6VkgpaQdh2Xthye-CrZYtZba5S36A0iBqTQ04Z5Y" \
     -H "X-User-Id: ooz6WsdQ4Ki7GR5WP" \
     http://localhost:3000/api/v1/roles.list
