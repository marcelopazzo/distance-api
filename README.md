# distance-api

[![Build Status](https://travis-ci.org/marcelopazzo/distance-api.svg?branch=master)](https://travis-ci.org/marcelopazzo/distance-api)

This is a Rails REST API designed to calculate the best route between two points in a location using Dijkstra's algorithm (found [here](https://github.com/marcelopazzo/distance-api/blob/master/app/models/graph.rb)).

To test it, you can clone and run it with:
```shell
$ rails s
```

Or use a deployed version available online at http://distance-api.herokuapp.com/

### Resources
1. Locations: `{"name": "SP"}`
  * `GET:    /locations/`
  * `POST:   /locations/`
  * `GET:    /locations/:id`
  * `PUT:    /locations/:id`
  * `DELETE: /locations/:id`
  * `GET:    /locations/:id/best_route`
2. Points: `{"name": "A"}`
  * `GET:    /locations/:location_id/points`
  * `POST:   /locations/:location_id/points`
  * `GET:    /locations/:location_id/points/:id`
  * `PUT:    /locations/:location_id/points/:id`
  * `DELETE: /locations/:location_id/points/:id`
3. Paths: `{"point1_id": 1, "point2_id": 2, "distance": 10}`
  * `GET:    /locations/:location_id/paths`
  * `POST:   /locations/:location_id/paths`
  * `GET:    /locations/:location_id/paths/:id`
  * `PUT:    /locations/:location_id/paths/:id`
  * `DELETE: /locations/:location_id/paths/:id`

### Usage
The api can be used with any REST client. This is just a sample using `curl`:

```shell
$ curl -v -H "Content-Type: application/json" -d '{"name": "SP"}' http://distance-api.herokuapp.com/locations
* Hostname was NOT found in DNS cache
*   Trying 23.23.109.126...
* Connected to distance-api.herokuapp.com (23.23.109.126) port 80 (#0)
> POST /locations HTTP/1.1
> User-Agent: curl/7.37.1
> Host: distance-api.herokuapp.com
> Accept: */*
> Content-Type: application/json
> Content-Length: 14
>
* upload completely sent off: 14 out of 14 bytes
< HTTP/1.1 201 Created
...
< Location: http://distance-api.herokuapp.com/locations/1
...
{"id":1,"name":"SP"}
```

To create a case scenario, the following commands can be used:

```shell
curl -H "Content-Type: application/json" -d '{"name": "A"}' \
  http://distance-api.herokuapp.com/locations/1/points
curl -H "Content-Type: application/json" -d '{"name": "B"}' \
  http://distance-api.herokuapp.com/locations/1/points
curl -H "Content-Type: application/json" -d '{"name": "C"}' \
  http://distance-api.herokuapp.com/locations/1/points
curl -H "Content-Type: application/json" -d '{"name": "D"}' \
  http://distance-api.herokuapp.com/locations/1/points
curl -H "Content-Type: application/json" -d '{"name": "E"}' \
  http://distance-api.herokuapp.com/locations/1/points

curl -H "Content-Type: application/json" -d \
  '{"point1_id": 1, "point2_id": 2, "distance": 10}' \
  http://distance-api.herokuapp.com/locations/1/paths
curl -H "Content-Type: application/json" -d \
  '{"point1_id": 2, "point2_id": 4, "distance": 15}' \
  http://distance-api.herokuapp.com/locations/1/paths
curl -H "Content-Type: application/json" -d \
  '{"point1_id": 1, "point2_id": 3, "distance": 20}' \
  http://distance-api.herokuapp.com/locations/1/paths
curl -H "Content-Type: application/json" -d \
  '{"point1_id": 3, "point2_id": 4, "distance": 30}' \
  http://distance-api.herokuapp.com/locations/1/paths
curl -H "Content-Type: application/json" -d \
  '{"point1_id": 2, "point2_id": 5, "distance": 50}' \
  http://distance-api.herokuapp.com/locations/1/paths
curl -H "Content-Type: application/json" -d \
  '{"point1_id": 4, "point2_id": 5, "distance": 30}' \
  http://distance-api.herokuapp.com/locations/1/paths
```

Now let's check the created resources:

```shell
$ curl -H "Content-Type: application/json" http://distance-api.herokuapp.com/locations/1/points
[{"id":1,"name":"A"},{"id":2,"name":"B"},{"id":3,"name":"C"},{"id":4,"name":"D"},{"id":5,"name":"E"}]

$ curl -H "Content-Type: application/json" http://distance-api.herokuapp.com/locations/1/paths
[{"id":1,"distance":"10.0","point1":{"id":1,"name":"A"},"point2":{"id":2,"name":"B"}},
{"id":3,"distance":"20.0","point1":{"id":1,"name":"A"},"point2":{"id":3,"name":"C"}},
{"id":2,"distance":"15.0","point1":{"id":2,"name":"B"},"point2":{"id":4,"name":"D"}},
{"id":5,"distance":"50.0","point1":{"id":2,"name":"B"},"point2":{"id":5,"name":"E"}},
{"id":4,"distance":"30.0","point1":{"id":3,"name":"C"},"point2":{"id":4,"name":"D"}},
{"id":6,"distance":"30.0","point1":{"id":4,"name":"D"},"point2":{"id":5,"name":"E"}}]
```

Ok, our scenario is set up. Let's hit the best_route endpoint:

```shell
$ curl -H "Content-Type: application/json" http://distance-api.herokuapp.com/locations/1/best_route\?source_id\=1\&destination_id\=4\&autonomy\=10\&fuel_price\=2.5
{"cost":"6.25","path":["A","B","D"]}
```

And we found the expected results! \o/
