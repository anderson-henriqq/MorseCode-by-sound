import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput input;
FFT fft;
float[] frequencias;

void setup() {
  size(400, 200);
  minim = new Minim(this);
  input = minim.getLineIn();
  fft = new FFT(input.bufferSize(), input.sampleRate());
  frequencias = new float[fft.specSize()];
}

void draw() {
  //delay(50);
  background(255);
  
  fft.forward(input.mix);
  
  // Obtém as frequências do espectro
  for (int i = 0; i < frequencias.length; i++) {
    frequencias[i] = fft.getBand(i);
  }
  
  // Encontra a frequência dominante
  float frequenciaDominante = findDominantFrequency(frequencias);
  
  // Exibe a frequência dominante na tela
  textSize(20);
  fill(0);
  textAlign(CENTER, CENTER);
  text("Frequência: " + frequenciaDominante + " Hz", width/2, height/2);
}

float findDominantFrequency(float[] frequencies) {
  float maxFreq = 0;
  int maxIndex = 0;
  
  for (int i = 0; i < frequencies.length; i++) {
    if (frequencies[i] > maxFreq) {
      maxFreq = frequencies[i];
      maxIndex = i;
    }
  }
  
  float dominantFreq = maxIndex * input.sampleRate() / fft.specSize();
  return dominantFreq;
}
