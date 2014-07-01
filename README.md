docker-reviewboard
==================

Configure a running Reviewboard system using Docker

To build:

```bash
docker build --rm -t <username>/docker-reviewboard .
```

To run:

```bash
docker run -d -t -p 8080:80 -p 2222:22 <username>/docker-reviewboard
```

Then you just point your browser to http://localhost:8080 and login with user ```admin``` and password ```password```.
