import javax.swing.JOptionPane;
import processing.sound.*;
import java.util.ArrayList;

SoundFile dot;
SoundFile dash;
String entrada = " "; // Variável para armazenar a entrada do usuário
ArrayList<String> morseCode;
int intevalo_dash = 1600;
int intevalo_dot = 600;
int intevalo_entre_som = 200;
boolean novo = false;

void setup() {
  
  size(720, 480);
  dot =  new SoundFile(this, "0.5s_6000Hz.wav");
  dash =  new SoundFile(this, "1.5s_6000Hz.wav");
  morseCode = new ArrayList<String>();

  // Lê a entrada do usuário
  inputUser();

  // converte cada caractere da frase/texto em cod morse e salva em uma string, após isso, salva essa string em um Array
  entradaToMorse(entrada, morseCode);

  //Percorre o array de string emitindo um sinal sonoro correpondete ao cod morse
  Transciver(morseCode);

}
void draw(){
  if(novo){
    morseCode.clear();
    inputUser();
    entradaToMorse(entrada, morseCode);
    Transciver(morseCode);
    novo = !novo;

  }
}



void keyPressed(){
  if(key == 'n'|| key == 'N'){
    novo = !novo;
  }
}

// Lê a entrada do usuário
void inputUser(){
  entrada = JOptionPane.showInputDialog("Digite sua mensagem (apenas letras e números):");

}

// converte cada caractere da frase/texto em cod morse e salva em uma string, após isso, salva essa string em um Array
void entradaToMorse(String entra, ArrayList<String> lista){
  int i;
  for ( i = 0 ; i < entra.length() ; i++){
    char c = entra.charAt(i);
    String MorseCodChar = charToMorse(c);
    lista.add(MorseCodChar);
  }
}
String charToMorse(char c) {
  switch(c) {
    case 'A': return ".-";
    case 'B': return "-...";
    case 'C': return "-.-.";
    case 'D': return "-..";
    case 'E': return ".";
    case 'F': return "..-.";
    case 'G': return "--.";
    case 'H': return "....";
    case 'I': return "..";
    case 'J': return ".---";
    case 'K': return "-.-";
    case 'L': return ".-..";
    case 'M': return "--";
    case 'N': return "-.";
    case 'O': return "---";
    case 'P': return ".--.";
    case 'Q': return "--.-";
    case 'R': return ".-.";
    case 'S': return "...";
    case 'T': return "-";
    case 'U': return "..-";
    case 'V': return "...-";
    case 'W': return ".--";
    case 'X': return "-..-";
    case 'Y': return "-.--";
    case 'Z': return "--..";
    case '0': return "-----";
    case '1': return ".----";
    case '2': return "..---";
    case '3': return "...--";
    case '4': return "....-";
    case '5': return ".....";
    case '6': return "-....";
    case '7': return "--...";
    case '8': return "---..";
    case '9': return "----.";
    case ' ': return "/"; // Espaço
    default: return ""; // Caracteres não mapeados para Morse
  }
}


//Percorre o array de string emitindo um sinal sonoro correpondete ao cod morse
void Transciver(ArrayList<String> lista){
  int i,j;
  for(i=0; i < lista.size() ; i++){
    delay(500); 
    String x = lista.get(i);
    for(j=0; j < x.length(); j++){
      delay(200); 
      if( x.charAt(j) == '-'){
         dash.play();
         delay(intevalo_dash);
         delay(intevalo_entre_som);
       }
       
       if( x.charAt(j) == '.'){
         dot.play();
         delay(intevalo_dot);
         delay(intevalo_entre_som);
       }
    }
  }
}
