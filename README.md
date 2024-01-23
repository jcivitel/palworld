[![](https://img.shields.io/maintenance/yes/2024)](https://github.com/jcivitel/)
[![Static Badge](https://img.shields.io/badge/GitHub-jcivitell-green?logo=github)](https://github.com/jcivitel/palworld)
[![Docker Pulls](https://img.shields.io/docker/pulls/jcivitell/palworld)](https://hub.docker.com/r/jcivitell/palworld)
[![Docker Stars](https://img.shields.io/docker/stars/jcivitell/palworld)](https://hub.docker.com/r/jcivitell/palworld)
[![Docker Image Size](https://img.shields.io/docker/image-size/jcivitell/palworld/latest)](https://hub.docker.com/r/jcivitell/palworld)


# What is Palworld?
Palworld is an action-adventure survival game by Japanese developer Pocket Pair. The game is set in an open world populated with animal-like creatures known as "Pals". The players can battle and capture Pals in order to use them for base building, traversal, and combat. Palworld can be played either solo, or online by up to 32 players on one server. Announced in 2021, it launched via early access for Windows, Xbox One, and Xbox Series X/S in January 2024.[^1]

This Docker image contains the dedicated server of the game.


<a href="https://store.steampowered.com/app/1623730/Palworld/"><img src="https://cdn.cloudflare.steamstatic.com/steam/apps/1623730/header.jpg?t=1698777053" alt="logo" width="400"/></img></a>

---

# How to use this image
## Setting up game server

**Running a Palworld dedicated server**

1. Run using a bind mount for data persistence on container recreation. Replace the following fields before executing the command:
```console
$ mkdir -p $(pwd)/pw-data
$ chmod 777 $(pwd)/pw-data # Makes sure the directory is writeable by the unprivileged container user
$ docker run -d --net=host \
    -v $(pwd)/pw-data:/home/steam/pw-dedicated/ \
    --name=pw-dedicated jcivitell/palworld
```

**The container will automatically update the game on startup, so if there is a game update just restart the container.**

# Configuration
## Environment Variables
Feel free to overwrite these environment variables, using -e (--env):
```dockerfile
PW_SERVERNAME=""
PW_PORT=8211
PW_RCONPORT=25575
PW_PW="changeme"
PW_MAXPLAYERS=32
PW_LOCATION="de"
PW_ADMINPW="changeme"
```

# Contributors
[![Contributors Display](https://badges.pufler.dev/contributors/jcivitel/palworld?size=50&padding=5&bots=false)](https://github.com/jcivitel/palworld/graphs/contributors)

[^1]: https://en.wikipedia.org/wiki/Palworld
