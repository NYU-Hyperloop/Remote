#!/usr/bin/bash
if [[ `uname` == MINGW32* ]] ;
then
	echo "Detected Windows"
	winpty openssl req -newkey rsa:4096 -keyform PEM -keyout ca.key -x509 -days 3650 -outform PEM -out ca.cer -subj '//C=US\ST=New-York\L=New-York\O=NYU-Hyperloop\CN=NYU-Hyperloop-Telemetry\emailAddress=nyu@hyper.loop'
	winpty openssl genrsa -out server.key 4096
	winpty openssl req -new -key server.key -out server.req -sha256 -subj '//C=US\ST=New-York\L=New-York\O=NYU-Hyperloop\CN=localhost'
	winpty openssl x509 -req -in server.req -CA ca.cer -CAkey ca.key -CAcreateserial -CAserial herong.seq -extensions server -days 1460 -outform PEM -out server.cer -sha256
	winpty openssl genrsa -out client.key 4096
	winpty openssl req -new -key client.key -out client.req -subj '//C=US\ST=New-York\L=New-York\O=NYU-Hyperloop\CN=127.0.0.1'
	winpty openssl x509 -req -in client.req -CA ca.cer -CAkey ca.key -CAcreateserial -CAserial herong.seq -extensions client -days 365 -outform PEM -out client.cer
	winpty openssl pkcs12 -export -inkey client.key -in client.cer -out client.p12
else
	openssl req -newkey rsa:4096 -keyform PEM -keyout ca.key -x509 -days 3650 -outform PEM -out ca.cer -subj '/C=US/ST=New-York/L=New-York/O=NYU-Hyperloop/CN=NYU-Hyperloop-Telemetry/emailAddress=nyu@hyper.loop'
	openssl genrsa -out server.key 4096
	openssl req -new -key server.key -out server.req -sha256 -subj '/C=US/ST=New-York/L=New-York/O=NYU-Hyperloop/CN=localhost'
	openssl x509 -req -in server.req -CA ca.cer -CAkey ca.key -CAcreateserial -CAserial herong.seq -extensions server -days 1460 -outform PEM -out server.cer -sha256
	openssl genrsa -out client.key 4096
	openssl req -new -key client.key -out client.req -subj '/C=US/ST=New-York/L=New-York/O=NYU-Hyperloop/CN=127.0.0.1'
	openssl x509 -req -in client.req -CA ca.cer -CAkey ca.key -CAcreateserial -CAserial herong.seq -extensions client -days 365 -outform PEM -out client.cer
	openssl pkcs12 -export -inkey client.key -in client.cer -out client.p12
fi
