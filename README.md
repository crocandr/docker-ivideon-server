# Ivideon Server for docker

## More information

  - https://hub.docker.com/r/consol/ubuntu-xfce-vnc
  - https://www.ivideon.com/ivideon-server-linux/


## Build

```
docker build -t croc/ivideon-server .
```

## Run

Use docker-compose.

```
docker-compose up -d
```

Do not forget to change the `config` directory permission after the first start!
```
chmod 777 config
```

## Usage

  - Open the VNC console in your browser. Port is 16901 by default. URL: http://< IP of your docker host >:16901 (URL example: http://192.168.1.11:16901 )
  - Type the default password: `vncpassword`
  - Open a terminal or find in the menu to open the `ivideon-server` (if the program does not start, check the config folder permission first)
  - Follow the wizard to configure the ivideon server

## Known bugs

  - You have to start the `ivideon-server` manually every time when you restarted the container



Good Luck!

