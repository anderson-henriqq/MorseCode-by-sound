import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput out;
boolean somLigado = true;
int ultimoSom;

// Definição dos tempos para representar ponto e traço
final int pontoDuration = 1000; // 1 segundo
final int tracoDuration = 2000; // 2 segundos
final float frequencia = 4000; // Frequência constante de 4000Hz, alterado em 08/04/2024 por ser considerado mais audível

void setup() {
  size(1280, 720);
  minim = new Minim(this);
  out = minim.getLineOut();
}

void draw() {
  background(255);  // Deixar a tela (backgroud) na cor branca
  // Emitir som apenas se o som estiver ligado
  if (somLigado) {
    int tempoAtual = millis();
    if (tempoAtual - ultimoSom >= pontoDuration + tracoDuration) {
      emitirSom(pontoDuration); // Emitir som de ponto
      ultimoSom = millis();
    } else if (tempoAtual - ultimoSom >= pontoDuration) {
      emitirSom(tracoDuration); // Emitir som de traço
      ultimoSom = millis();
    }
  }
}

// A função emitirSom() reproduz um som com a frequência constante definida e a duração fornecida
void emitirSom(int duracao) {
  out.playNote(frequencia, duracao / 1000.0f, 1); // Reproduzir som com a frequência e duração especificadas
}

// Ativar/desativar a emissão de sons ao pressionar a tecla 's'
void keyPressed() {
  if (key == 's' || key == 'S') {
    somLigado = !somLigado; // Inverter o estado do som
    if (somLigado) {
      ultimoSom = millis(); // Inicializar o timer
    }
  }
}
