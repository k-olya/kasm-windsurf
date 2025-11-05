How to add to KASM

Get Dockerfile from this repo to KASM machine and run
`sudo docker build -t ubuntu-noble:windsurf -f Dockerfile .`

![image](https://somnitelnonookay.ucoz.net/kasm-config1.png)

Windsurf thumbnail: `https://somnitelnonookay.ucoz.net/windsurf.png`

![image](https://somnitelnonookay.ucoz.net/kasm-config2.png)

Docker image: `ubuntu-noble:windsurf`

![image](https://somnitelnonookay.ucoz.net/kasm-config3.png)

Persistent profile path example: `/mnt/data/kasm/profiles/{username}/{image_id}`
If you don’t specify a persistent profile, your login session won’t be saved between Kasm Workspace restarts.

Docker run override config: 
```
{
  "environment": {
    "KASM_PROFILE_FILTER": "null"
  }
}
```
