# Digital Pheromones
by Andres, Ares, Jonas

Source Code for the projcet of the Alpine Glaciers & Creative Coding Course (Master Media Design 1st year, October 2023)

## Plotter Setup

Install axicli globally on your system (see [Axidraw Documentation](https://axidraw.com/doc/cli_api/#introduction))  
`python -m pip install https://cdn.evilmadscientist.com/dl/ad/public/AxiDraw_API.zip`


Navigate to folder and install dependencies  
`cd plotter`  
`npm i` 

Change constants PENCIL_UP and PENCIL_DOWN on top of index.js file.   
Either you experiment with the Axidraw Inkscape Extension to find the right values or you try out different values by using axicli:
`axicli -d 60 -u 90 --mode manual --manual_cmd raise_pen`   
`axicli -d 60 -u 90 --mode manual --manual_cmd lower_pen `


Starting plotter & processing code  
`npm start`  

Stop plotter: `Control + C` (two times)
Move plotter to home position: `npm home`

## iPad Setup

Install mkcert on your system (optional but required for local testing on iPad in fullscreen mode)  
`brew install mkcert`    
`mkcert --install`  

Navigate to folder and install dependencies  
`cd ipad`  
`npm i`

Start dev server   
`npm run dev`  

Copy the root certificate to iPad (Airdrop, etc.) and install it in the settings app.  
The folder of the rootCA.pem file can be found with the following command:  
`mkcert -CAROOT`  

Open url in iPad browser (copy link or scan QR code from console)   

Add site to your home screen  

Open site from home screen

Alternatively use a Kiosk App to have real fullscreen:
https://apps.apple.com/us/app/kiosk-fullscreen-browser/id1544947623
(but then it has to be hosted in the cloud to work)


# Socket Server

Generate https certificate for local development
`mkcert localhost 172.20.13.7 ::3333`

