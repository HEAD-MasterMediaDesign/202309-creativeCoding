#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform sampler2D texture2;
uniform sampler2D textureDif;

void main(void) {
  
  vec4 col = texture2D(texture, vertTexCoord.st);
  vec4 colDiff = texture2D(textureDif, vertTexCoord.st * vec2(1,-1) + vec2(0,1) );

  //vec4 difference = abs(mask - image);  
  //fragColor = difference;

  gl_FragColor = abs(vec4(colDiff.rgb, 1.0) - vec4(col.rgb, 1.0));
}
