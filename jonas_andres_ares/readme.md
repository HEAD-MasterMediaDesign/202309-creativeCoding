# Digital Pheromones
by Andres, Ares, Jonas

## Plotter Setup

Install axicli globally on your system (see [Axidraw Documentation](https://axidraw.com/doc/cli_api/#introduction))  
`python -m pip install https://cdn.evilmadscientist.com/dl/ad/public/AxiDraw_API.zip`



Navigate to folder and install dependencies  
`cd plotter`  
`npm i` 

Change constants PENCIL_UP and PENCIL_DOWN on top of index.js file

Starting plotter & processing code  
`npm start`  

Stop plotter: `Control + C`  
Move plotter to home position: `npm home`

## iPad Setup

Static IP: 172.20.5.202

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


