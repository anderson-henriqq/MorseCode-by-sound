import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput input;
FFT fft;
float[] frequencias;
float tempoInicio;
String codigoMorse = "";

void setup() {
  size(720, 480);
  minim = new Minim(this);
  input = minim.getLineIn();
  fft = new FFT(input.bufferSize(), input.sampleRate());
  frequencias = new float[fft.specSize()];
  tempoInicio = millis();
}

void draw() {
  background(255);
  
  fft.forward(input.mix);
  
  // Obtém as frequências do espectro
  for (int i = 0; i < frequencias.length; i++) {
    frequencias[i] = fft.getBand(i);
  }
  
  // Encontra a frequência dominante
  float frequenciaDominante = findDominantFrequency(frequencias);
  
  // Converte a frequência dominante em código Morse
  if (frequenciaDominante > 4500) {
    if (millis() - tempoInicio > 1100) {
      codigoMorse += "-";
      tempoInicio = millis();
    }
  } else {
    if (millis() - tempoInicio > 800 && millis() - tempoInicio < 1100  ) {
      codigoMorse += ".";
      tempoInicio = millis();
    }
  }
  
  // Exibe a frequência dominante e o código Morse na tela
  textSize(24);
  fill(0);
  textAlign(CENTER, CENTER);
  text("Frequência Dominante: " + frequenciaDominante + " Hz", width/2, height/2 - 50);
  text("Código Morse: " + codigoMorse, width/2, height/2 + 50);
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
