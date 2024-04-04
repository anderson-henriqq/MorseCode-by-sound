import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput out;
boolean somLigado = false;

// Definição dos tempos para representar ponto e traço
final int pontoDuration = 1000; // 1 segundos
final int tracoDuration = 2000; // 2 segundos
final int delayDuration = 1000; // 1 segundos
final float frequencia = 2000; // Frequência constante de 2000Hz

void setup() {
  size(1280, 720);
  minim = new Minim(this);
  out = minim.getLineOut();
}

void draw() {
  background(255);	// Deixar a tela (backgroud) na cor branca
  // Emitir som apenas se o som estiver ligado
  if (somLigado) {
    emitirSom(pontoDuration); // Emitir som de ponto
    delay(delayDuration);
    emitirSom(tracoDuration); // Emitir som de traço
    delay(delayDuration);
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
