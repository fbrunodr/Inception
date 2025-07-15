# Docker inception

![Inception poster](https://upload.wikimedia.org/wikipedia/en/1/18/Inception_OST.jpg)

Run docker inside docker recursively

## How to run

Assuming you have docker installed, go to your terminal and run:

```bash
docker build -t inception .
docker run --privileged --name inception -p 8000:8000 -p 5900:5900 inception
```

After that go to http://localhost:8000/vnc.html and connect to your container. You have to go to its desktop (powered by fluxbox) and open a bash terminal (right click anywhere in the desktop; for mac users, double click on the trackpad). Then inside this terminal do `cd home/Inception` and run the commands above, changing the host terminal. For example:

```bash
docker build -t inception .
docker run --privileged --name inception -p 8001:8000 -p 5901:5900 inception
```

This will build a Docker image and run it inside a container that itself is running in another container on your machine. Then you can repeat the steps just carefully changing the host port to avoid port conflict. **You can’t connect to a nested container directly** from the host; you must traverse each “inception” layer via its noVNC session to reach the next one.