# Perpignano Mattia 

esercitazione TPSIT creare una chat room.

## Soluzione

dopo aver modificato il file del server che ci è stato fornito,per connettere l'applicazione al server creo un Soket all' avvio connettendolo alla porta 3000 e l'indirizzo 10.0.2.2 (indirizzo dell' local host per l'emulatore) salvando i messaggi in entrata e traducendoli,vengono poi aggiunti con quelli in uscita ad un  Set che viene mostrato da un listView.builder.

All accesso all applicazione viene chiesto di inserire un nome che verrà visualizzato dagli altri utenti.

Attraverso un Widget "Messaggio" personalizzato e utilizzando la dependencies "flutter_chat_bubble" ottengo una visualizzazione diversa per i messaggi in uscita e in entrata, per permettere una migliore visualizzazione.



####da notare:
per fare in modo che si visualizzi l'ultimo messaggio inviato/ricevuto ho utilizzato uno scroll controller nella mia list.view che permette di scorrere alla fine della lista quando viene aggiunto un messaggio alla lista.Questa operazione deve essere ritardata a per premetere al context di aggiornarsi

con un AlertDIalog iniziale permetto all' user di scegiere il suo nome che puo essere modificato successivamente con un pulsante sull appBar.