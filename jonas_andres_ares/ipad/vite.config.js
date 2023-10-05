import { defineConfig } from 'vite';
import mkcert from'vite-plugin-mkcert'
import { qrcode } from 'vite-plugin-qrcode';

export default defineConfig({
  server: {
    https: true
  },
  plugins: [
    mkcert(),
    qrcode()
  ]
});