# Remote
GUI for visualizing telemetry from the Pod and sending remote commands. Communication is established via MQTT over TLS.

## Requirements
* Node.js

## Install
```bash
git clone git@github.com:NYU-Hyperloop/Remote.git
cd Remote
npm install mosca
```

## Run
There is a sample config along with a server cert/key pair in the `test/` directory. **DO NOT** use these in production.
```bash
node remote.js test/config.json
```
