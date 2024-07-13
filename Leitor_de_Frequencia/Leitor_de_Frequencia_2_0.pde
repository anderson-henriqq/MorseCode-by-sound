import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput in;
FFT fft;

ArrayList<String> mensagemMorse;
int contador = 0;
int t;
int tempoAtual;
int ultimoTempo,deltaT;
int USL; // ultimo sinal lido
int ajuste_dot = 800;
int ajuste_dash = 2000;
boolean exibir_mensagemMorse = false;
boolean pausar = true;

void setup() {
  size(400, 200);
  
  // Inicializa o Minim e a entrada de áudio
  minim = new Minim(this);
  in = minim.getLineIn();
  
  // Inicializa o FFT com o tamanho do buffer de áudio
  fft = new FFT(in.bufferSize(), in.sampleRate());
  
  mensagemMorse = new ArrayList<String>();
}

void draw() {
  background(255);
  
  if(pausar){
  // Atualiza o FFT com o sinal de áudio
  fft.forward(in.mix);
  tempoAtual = millis();
  }
  
  // Encontra a frequência dominante
  delay(50);
  float freq = findDominantFrequency();

  //Caso seja captado uma frequencia acima de 5900Hz, inciamos um temporizador para cronometrar quanto tempo o sinal se mantece constante
  if(freq > 5900){
    if(t==0){
      ultimoTempo = tempoAtual;
      t = t+1;
    }
    contador = contador + 1;
  }
  if(freq < 5000){
    if(t==1){
      deltaT = tempoAtual - ultimoTempo;
      USL = deltaT;
    }
    if(deltaT > ajuste_dot && deltaT < 1300){
      mensagemMorse.add(".");
    }
    if(deltaT > ajuste_dash && deltaT < 3300){
      mensagemMorse.add("-");
    }
    t=0;
    deltaT = 0;
  }
  
  
  // Exibe a frequência dominante na tela
  fill(0);
  textSize(18);
  text("Frequência Dominante: " + freq + " Hz", 20, 30);
  text("Contador: " + contador, 20, 50);
  text("Tempo: " + USL, 20, 70);
  
  //if(exibir_mensagemMorse){
    text("Mensagem: " + mensagemMorse, 20, 90);
  //}
}

void keyPressed(){
  if(key == 'M'|| key == 'm'){
    exibir_mensagemMorse = !exibir_mensagemMorse;
  }
  if(key == 'P'|| key == 'p'){
    pausar = !pausar;
  }
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
