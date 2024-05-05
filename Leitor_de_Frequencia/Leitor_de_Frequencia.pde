import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput in;
FFT fft;

int contador = 0;


void setup() {
  size(400, 200);
  
  // Inicializa o Minim e a entrada de áudio
  minim = new Minim(this);
  in = minim.getLineIn();
  
  // Inicializa o FFT com o tamanho do buffer de áudio
  fft = new FFT(in.bufferSize(), in.sampleRate());
}

void draw() {
  background(255);
  
  // Atualiza o FFT com o sinal de áudio
  fft.forward(in.mix);
  
  // Encontra a frequência dominante
  delay(100);
  float freq = findDominantFrequency();
  if(freq > 5900){
    
    contador = contador + 1;
  }
  // Exibe a frequência dominante na tela
  fill(0);
  textSize(18);
  text("Frequência Dominante: " + freq + " Hz", 20, 30);
  text("Contador: " + contador, 20, 50);
}

// Função para encontrar a frequência dominante
float findDominantFrequency() {
  int maxIndex = 0;
  float maxAmplitude = 0;
  
  // Percorre as bandas de frequência
  for (int i = 0; i < fft.specSize(); i++) {
    // Verifica a amplitude da banda atual
    if (fft.getBand(i) > maxAmplitude) {
      maxAmplitude = fft.getBand(i);
      maxIndex = i;
    }
  }
  
  // Converte o índice da banda em frequência
  return fft.indexToFreq(maxIndex);
}

void stop() {
  // Fecha a entrada de áudio e o Minim ao encerrar o programa
  in.close();
  minim.stop();
  super.stop();
}
