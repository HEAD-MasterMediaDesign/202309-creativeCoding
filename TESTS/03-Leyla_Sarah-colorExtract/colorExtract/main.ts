import Vibrant = require('node-vibrant')

async function main() {
    const vibrante = new Vibrant('./00.jpeg', {
        colorCount: 64,
    })

    const palette = await vibrante.getPalette()

    const data = [
        palette.DarkMuted?.toJSON().rgb,
        palette.DarkVibrant?.toJSON().rgb,
        palette.Muted?.toJSON().rgb,
        palette.Vibrant?.toJSON().rgb,
        palette.LightVibrant?.toJSON().rgb,
        palette.LightMuted?.toJSON().rgb,
    ]

    console.log(data)

}
main()
