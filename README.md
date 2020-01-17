# Ivideon Server for Docker

## More information

  - https://www.ivideon.com/ivideon-server-linux/

## Build

```
docker build -t croc/ivideon-server .
```

## Usage

Use docker compose method, more simple and easier:

```
docker-compose up -d
```

## Setup

You have to setup ivideon-server after the started the container.
Connect with a remote desktop client to the docker host (container) IP and 3389 TCP port.
Check the `docker-compose logs` output for the auto-generated password. (Username is fixed: `ivideon`)
Login on the GUI and start `ivideon-server` program. Step through the ivideon server setup wizard. Enjoy :)

## Known problems

  - You have to start ivideon-server program manually every time, when the container/docker host restarted.

  - the Linux GUI uses EN/US keyboard layout only

## Recommendations

Remote desktop clients:

  - for Windows:
    - use the default remote desktop client (mstsc)
  - for Linux:
    - remmina (https://remmina.org/)
  - for macOS:
    - Microsoft Remote Desktop for Mac


Good Luck!
