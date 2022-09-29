uniform vec2 iResolution;
uniform float iTime;
uniform sampler2D iTex; // processing で渡したテクスチャのデータはここから取得できる

float rand(vec2 n) { 
    return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
}
float noise(vec2 p){
    vec2 ip = floor(p);
    vec2 u = fract(p);
    u = u*u*(3.0-2.0*u);

    float res = mix(
        mix(rand(ip),rand(ip+vec2(1.0,0.0)),u.x),
        mix(rand(ip+vec2(0.0,1.0)),rand(ip+vec2(1.0,1.0)),u.x),u.y);
    return res*res;
}

vec2 makeNoise(vec2 uv, float range) {
    vec2 noiseUv = gl_FragCoord.xy/iResolution.xy;
    noiseUv.y += iTime;
    float n = noise(vec2(noiseUv.x, noiseUv.y*16.));
    uv.x += mix(range, -range, n);
    return uv;
}

void main() {
    vec2 uv = gl_FragCoord.xy/iResolution.xy;
    uv.y = 1.-uv.y; // 上下反転
    vec3 col = vec3(0.);

    // テクスチャのピクセルをノイズをかけたuv座標で取得している
    // rgb チャンネルごとに異なるノイズをかけるとイケてる感じになる
    float r = texture2D(iTex, makeNoise(uv, .001)).r;
    float g = texture2D(iTex, makeNoise(uv, .02)).g;
    float b = texture2D(iTex, makeNoise(uv, .04)).b;

    gl_FragColor = vec4(vec3(r,g,b), 1.);
}