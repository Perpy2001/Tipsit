# Perpignano Mattia 

esercitazione TPSIT creare un cronometro,timer e un gioco;

## Soluzione

ho creato 3 pagine(contenute nella cartella pages) diverse per contenere tutte e tre le richieste, nel home è contenuto il gioco,mentre a sinistra dell appBarc'è un menù a tendina per sceglire il cronometro o il timer.

### Il gioco:
il gioco presenta un pulsante per l'avvio che avvierà lo stream il quale fara combiare i container di colore, le due barre orizzontali rappresentano il colore "risposta".

-punteggio:
per incrementare il punteggio bisognierà premere sul container del colore della risposta.Nella parte superiore viene visualizzato il punteggio e affianco al bottone di avvio si trova l' highscore che viene aggiornato in caso il punteggio sia maggiore di esso.

-difficolta:
a destra dell appbar si trova un bottone "?" con cui scegliere la difficoltà all avvio. La difficoltà è data dal numero di celle della griglia del gioco facile:4,Medio:8,Difficile:20.

in fine il tempo 30 sec è giestito da uno stream separato da quello del gioco che in terrompe il gioco quando sono passati 30 secondi;Per interrompere il gioco he creato una funzione updatePlay() che cambia lo stato del gioco e lo mette crea un popup con il punteggio e l'higscore.

per formattare senza problemi la tabella dei container ho creato una funzione che in base alla dificoltà cambiasse gli elementi
 int scegliDifficolta(int dif) {
  if (dif == 4) return 2;
  if (dif == 8) return 4;
  if (dif == 20) return 5;
}
nel wideget
 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: difficolta == 4 ? 1.21 : 1,
                    crossAxisCount: scegliDifficolta(difficolta)),
### Cronometro:
si presenta con un container che visualizza il tempo,un tasto per l'avvio e la pausa e un tasto reset.
per simulare un flusso di dati esterno ho dichiarato una map globale la quale viene aggiornata da uno stream ongni 100ms(utilizzando Future.delayed il tempo inferiore ai 50ms causa problemi al programma) per incrementare il campo "time",una volta che  il valore "time" della mappa raggiunge 10 viene posto a zero e icrementato il valore sec che rappresenta i secondi,allo stesso modo quando "sec" raggiunge 60 viene posto a 0 e incrementato "min".
per la coretta visualizzazione dei valori com ad esempo 01:02:50 invecedi 1:2:50 ho utilizzato una serie di if che formattasero le stringhe da far visualizzare in cao il valore fosse solo un unità;

### Timer:
Si presenta come un unico container che mostra il timer, per accedere alla selezione del tempo da impostare basta tappare sullo scermo e si apria una selezione, per avviare il timer basta chiacciare sul pulsante di avvio sotto la selezione.

in maniera simile al cronometro creo una mappa, ma questa volta all interno dello stream.la mappa quando viene dichiarata traduce il tempo scelto dall user in "int" in maniera tale da riuscire a svolgere le operazioni necesserie per il decremento e la visualizzazione di esso.