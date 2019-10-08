# Docker Astralys project
A docker project, the website of a video game, created by Vincent Darcemont for a Cloud Infrastructure project.  
The game is available directly on the site as well as the leaderboard but it can also be compiled in Linux.

## The game
It is a space shooter with a leaderboard.

I made this game thanks to [Godot Engine](https://godotengine.org/), an open source game engine.
I used the [image](https://hub.docker.com/r/barichello/godot-ci) of barichello on [Docker hub](https://hub.docker.com/) to compile my game, because it contains a handless version of Godot (I didn't need a display).
The game uses a [sqlite](https://github.com/khairul169/gdsqlite) library for the leaderboard with the linux version. For the HTML5 version, the game sends GET and POST request to the site.
#### Here the command to compile

   For the linux version.
   

    docker-compose up build-game-linux
    
   For the HTML5 version.
   

    docker-compose up build-game-html
   
   But the game can be run and edit in a docker. I made this [image](https://hub.docker.com/r/darcemontv/godot-dockerfile) to do that, strongly inspired by barichello repo but with a Linux/X11 version of Godot inside and all the libraries to display the editor. The code can be found [here](https://github.com/deakcor/godot-dockerfile).
#### Here the command to run the editor
To run the game.

    docker-compose up run-game

To edit the game.

    docker-compose up edit-game
## The website
On this site, you can run the HTML5 version of the game and see the leaderboard.

I made the site thanks to nodejs. It is also a docker image available [here](https://cloud.docker.com/repository/docker/darcemontv/node_astralys/general).
The code can be found [here](https://github.com/deakcor/nodejs_astralys/tree/master).
#### Here the command to run the site

    docker-compose up run-site
Don't forget to export the HTML5 version of the game before and play the game to enter something in the database to see the leaderboard.
