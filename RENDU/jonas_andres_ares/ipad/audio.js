let player;

let shifter;
let button;
let shiftSlider;
let rateSlider;
let windowSlider;
let presets = [];
let wetMix;

function preloadAudio() {
  shifter = new Tone.PitchShift(2).toMaster();
  shifter.windowSize = 0.03;
  player = new Tone.Player("audio/ZOOM0051.mp3").connect(shifter);
  player.loop = true;
}

function startAudio() {
  shifter.wet.value = 1;
  shifter.pitch = 20;
  shifter.windowSize = 0.5;
  player.playbackRate = 0.5;
  player.start();
}

function setAudioVolume(amount) {
  player.volume = map(amount, 0, 1, -60, 0);
}

function setAudioPitch(amount) {
  shifter.pitch = map(amount, 0, 1, -50, 31);
}

function setAudioWindowSize(amount) {
  shifter.windowSize = map(amount, 0, 1, 0.01, 2.57);
}

function setAudioPlaybackRate(amount) {
  player.playbackRate = map(amount, 0, 1, 0.25, 0.72);
}

// const audioPathsHigh = [
//   "audio/high/ZOOM0034.mp3",
//   "audio/high/ZOOM0046.mp3",
//   "audio/high/ZOOM0051.mp3",
//   "audio/high/ZOOM0062.mp3",
//   "audio/high/ZOOM0066.mp3",
//   "audio/high/ZOOM0069.mp3",
// ];

// const audioPathsMedium = [
//   "audio/medium/ZOOM0048.mp3",
//   "audio/medium/ZOOM0057.mp3",
//   "audio/medium/ZOOM0058.mp3",
//   "audio/medium/ZOOM0059.mp3",
//   "audio/medium/ZOOM0060.mp3",
//   "audio/medium/ZOOM0064.mp3",
//   "audio/medium/ZOOM0067.mp3",
//   "audio/medium/ZOOM0068.mp3",
// ];

// const audioPathsLow = [
//   "audio/low/ZOOM0012.mp3",
//   "audio/low/ZOOM0027.mp3",
//   "audio/low/ZOOM0049.mp3",
//   "audio/low/ZOOM0052.mp3",
//   "audio/low/ZOOM0053.mp3",
//   "audio/low/ZOOM0054.mp3",
//   "audio/low/ZOOM0055.mp3",
//   "audio/low/ZOOM0056.mp3",
//   "audio/low/ZOOM0061.mp3",
//   "audio/low/ZOOM0063.mp3",
//   "audio/low/ZOOM0065.mp3",
// ];

// function startRadio() {
//   console.log("Start Radio");
// }
