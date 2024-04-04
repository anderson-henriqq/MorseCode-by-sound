/*
Este código faz o seguinte:
Define os tempos para representar um ponto (0.5 segundos) e um traço (1.5 segundos).
Pressionar a tecla 's' ativa ou desativa a emissão de sons.
Este código deve atender às suas necessidades, gerando sons em frequência de 2000Hz em intervalos de tempo diferentes para representar os pontos e traços da linguagem do código Morse.
Certifique-se de ajustar os tempos de duração conforme necessário para corresponder aos requisitos do código Morse.
*/

import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput out;
boolean somLigado = false;

// Definição dos tempos para representar ponto e traço
final int pontoDuration = 500; // 0.5 segundos
final int tracoDuration = 1500; // 1.5 segundos
final float frequencia = 2000; // Frequência constante de 2000Hz

void setup() {
  size(200, 200);
  minim = new Minim(this);
  out = minim.getLineOut();
}

void draw() {
  background(255);
  // Emitir som apenas se o som estiver ligado
  if (somLigado) {
    emitirSom(pontoDuration); // Emitir som de ponto
    delay(pontoDuration); // Aguardar a duração do ponto
    emitirSom(tracoDuration); // Emitir som de traço
    delay(tracoDuration); // Aguardar a duração do traço
  }
}

// A função emitirSom() reproduz um som com a frequência constante definida e a duração fornecida
void emitirSom(int duracao) {
  out.playNote(frequencia, duracao/1000.0f, 1); // Reproduzir som com a frequência e duração especificadas
}

// Ativar/desativar a emissão de sons ao pressionar a tecla 's'
void keyPressed() {
  if (key == 's' || key == 'S') {
    somLigado = !somLigado; // Inverter o estado do som
  }
}
