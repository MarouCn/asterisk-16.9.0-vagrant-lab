# asterisk-16.9.0-vagrant-lab

# Asterisk-server setup
- vagrant up
- Now we have to generate the DTLS certificates that are mandatory for the WebRTC communication:
    *  `cd /usr/local/src/asterisk-16.9.0/contrib/scripts`
    * `./ast_tls_cert -C 127.0.0.1 -O "Cn-Consult" -d /etc/asterisk/keys`
    * This will generate the asterisk.pem file, which is defined as the tlscertfile under the /etc/asterisk/http.conf file.
- `service asterisk restart`
- Enter the asterisk cli : `asterisk -r`
- Increase the verbosity in order to see more output when testing: `core set verbose 21`

The necessary configuration files for the server can be found under ./asterisk-config-files.
Those files are configured to allow WebRTC connection between two peers, and they will be copied
to the right path when provisioning the vagrant-box. Feel free to edit them if you want to change something in the configuration.

Now everything is ready for testing.
# Testing with sip.js
## Frontend
- sip.js 0.16.0 was used for testing: https://github.com/onsip/SIP.js/tree/0.16.0.
- The ws server that should be used for testing is: `ws://127.0.0.1:5000/ws.
- Two peers are configured which can be used to establish audio calls between them:
    * 1060:
        * uri: sip:1060@127.0.0.1
        * authorizationUsername: 1060
        * password: password
    * 1061:
         * uri: sip:1061@127.0.0.1
         * authorizationUsername: 1061
         * password: password

## With Nodejs
- In order to make a call from the backend, please use this forked sip.js library which is dedicated to be used within a nodejs environment: https://github.com/Winston87245/SIP.js
- Please install also the node-webrtc-audio-stream-source library: `npm i node-webrtc-audio-stream-source`
- The already mentioned library contains an example: ./example/PlayAudio.js, you can use this file in order to play an audio-file during an audio-call.
- Example of the UA that works with the current server configuration:
```
  const userAgent = new SIP.UA({
           uri: "sip:1061@127.0.0.1",
           transportOptions: {
               wsServers: "ws://127.0.0.1:5000/ws",
           },
           authorizationUser: "1061",
           password: "password",
           hackIpInContact: true,
           register:true,
           traceSip:true
       });
  ```
    