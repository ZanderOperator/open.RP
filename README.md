# open.RP
Open sourced server codes(including maps & custom models) & files of RP server, up to programming standards, 
for upcoming open.mp modification of GTA San Andreas, written mostly in embedded C(pawn) and database in SQL.

## Installation
To take full advantage of developing experience, please download and install sampctl by Southclaws.

Paste this:
```
git clone https://github.com/ZanderOperator/open.RP
sampctl p ensure --platform windows or linux
sampctl p build
```
in your Code Terminal on Visual Studio Code. 

Import the open_RP.sql database on your server(easiest way: phpMyAdmin) - xampp or wamp

Use ```sampctl p run``` to start your server localy, ```exit``` to terminate it.


## Dependencies

[sampctl](https://github.com/Southclaws/sampctl)

Rest of the dependencies for the server itself are managed by sampctl.


In case of usage files on public server - transfer all server files on server AFTER ensuring(plugins, server.cfg, samp-server, samp-npc, gamemodes, scriptfiles, filterscripts, models)
