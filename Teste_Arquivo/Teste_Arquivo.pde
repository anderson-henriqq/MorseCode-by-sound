import processing.sound.*;

SoundFile[] sounds;
int currentSoundIndex = 0;
int numSounds = 3;
int interval = 3000; // Intervalo entre os sinais em milissegundos
int startTime;

void setup() {
  size(200, 200);
  sounds = new SoundFile[numSounds];
  
  // Inicializa os sons
  for (int i = 0; i < numSounds; i++) {
    sounds[i] = new SoundFile(this, "sine_2000hz.wav");
  }
  
  // Inicia o temporizador
  startTime = millis();
}

void draw() {
  // Verifica se já passou o intervalo
  if (millis() - startTime > interval) {
    // Reproduz o próximo som
    sounds[currentSoundIndex].play();
    sounds[currentSoundIndex].play();
    sounds[currentSoundIndex].play();
    sounds[currentSoundIndex].play();
    sounds[currentSoundIndex].play();
    sounds[currentSoundIndex].play();
    sounds[currentSoundIndex].play();
    sounds[currentSoundIndex].play();
    sounds[currentSoundIndex].play();
    sounds[currentSoundIndex].play();
    sounds[currentSoundIndex].play();
    sounds[currentSoundIndex].play();
    sounds[currentSoundIndex].play();
    sounds[currentSoundIndex].play();
    sounds[currentSoundIndex].play();
    sounds[currentSoundIndex].play();
    sounds[currentSoundIndex].play();
    sounds[currentSoundIndex].play();
    sounds[currentSoundIndex].play();
    sounds[currentSoundIndex].play();
    sounds[currentSoundIndex].play();
    sounds[currentSoundIndex].play();
    sounds[currentSoundIndex].play();
    sounds[currentSoundIndex].play();
    
    // Incrementa o índice do som
    currentSoundIndex++;
    if (currentSoundIndex >= numSounds) {
      // Reinicia o índice se atingiu o último som
      currentSoundIndex = 0;
    }
    
    // Reinicia o temporizador
    startTime = millis();
  }
}
