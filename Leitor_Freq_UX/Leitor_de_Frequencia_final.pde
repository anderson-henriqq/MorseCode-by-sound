import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput in;
FFT fft;

PFont minhaFonte; // Variável para armazenar a fonte
ArrayList<String> mensagemMorse;
ArrayList<Integer> mensagemMorseTempo;
int contador = 0;
int t, ultimoTempo, deltaT, tempoAtual, USL;
int ajuste_dot = 500;
int ajuste_dash = 1500;
boolean new_mensagemMorse = false;
boolean pausar = true;
float freq;


void setup() {
  size(700, 300); // Tamanho da janela
   minhaFonte = createFont("RobotoCondensed-VariableFont_wght.ttf", 24);
  
  // Inicializa o Minim e a entrada de áudio
  minim = new Minim(this);
  in = minim.getLineIn();
  
  // Inicializa o FFT com o tamanho do buffer de áudio
  fft = new FFT(in.bufferSize(), in.sampleRate());
  
  mensagemMorse = new ArrayList<String>(); // Array para imprimir a mensagem
  mensagemMorseTempo = new ArrayList<Integer>();
}

void draw() { // função void 

  tempoAtual = millis();
  
  
  if(pausar){
    fft.forward(in.mix);// Atualiza o FFT com o sinal de áudio
  }
  // Encontra a frequência dominante
  delay(50);
  freq = findDominantFrequency();
  
  sinal();  //Caso seja captado uma frequencia acima de 5900Hz, inciamos um temporizador para cronometrar quanto tempo o sinal se mantece constante
  
  if(new_mensagemMorse){
    mensagemMorse.clear();
    mensagemMorseTempo.clear();
    new_mensagemMorse = !new_mensagemMorse;
  }
  



  background(176, 168, 185); // Cor de funda janela 
  stroke(75, 68, 83); // Define a cor da linha (preto)
  line(width / 10 , 0, width / 10, height); // Desenha uma linha vertical no meio
  strokeWeight(220);
  textFont(minhaFonte);
  fill(0); //trasparencia do texto
  textSize(18);//tamanho do texto
  text("Frequência Dominante: " + freq + " Hz", 200, 30);
  text("Contador: " + contador, 200, 60);
  text("Tempo: " + USL, 200, 90);
  text("Mensagem: ", 200, 230);
  text("" + mensagemMorse, 200, 260);
  text("" + mensagemMorseTempo, 200, 280);
  text("Botões " , 20, 30);
  text("C : Nova mensagem" , 20, 60);
  text("P : Pausar" , 20, 90);
 
}

void keyPressed(){
  if(key == 'C'|| key == 'c'){
    new_mensagemMorse = !new_mensagemMorse;
  }
  if(key == 'P'|| key == 'p'){
    pausar = !pausar;
  }
  
}

void sinal(){ //Caso seja captado uma frequencia acima de 5900Hz, inciamos um temporizador para cronometrar quanto tempo o sinal se mantece constante
  
  if(freq > 5900){
    if(t==0){
      ultimoTempo = tempoAtual;
      t = t+1;
    }
    contador = contador + 1;
  }
  delay(50);
  if(freq < 5000){
    if(t==1){
      deltaT = tempoAtual - ultimoTempo; // salva o tempo que o audio captado
      USL = deltaT;
    }
    if(deltaT > ajuste_dot && deltaT < 1400){
      mensagemMorse.add(".");
      mensagemMorseTempo.add(deltaT);
    }
    if(deltaT > ajuste_dash && deltaT < 3300){
      mensagemMorse.add("-");
      mensagemMorseTempo.add(deltaT);
    }
    t=0;
    deltaT = 0;
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
  in.close();//fecha a entrada de audio
  minim.stop(); //fecha a biblioteca
  super.stop();//encerra o programa
}
