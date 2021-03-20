# app_memo_xp

App Memo

## Funzionalità

- aggiunta di memo condivise su un server
- definizione di tag per identificare i memo
- Salvataggio di memo preferite
- ricerca di memo per tag
- login con Google tramite firebase
- visualizzazione memo secondo la data
- possibilita di creare e rendere private dei memo


## Da Notare

Query: 
- Firebase: 
  **ricerca solo memo personali**:

      _colecMemo
              .orderBy("date")
              .where("accaunt", isEqualTo: user.email)
              .snapshots(),


  **Ricerca memo per tag**:

       _colecMemo.orderBy("date").where("tags", arrayContainsAny: [_controllerRicerca.text]).snapshots()

  **Salvataggio memo**:
    
        widget.colec.add({
                "date":DateTime.now(),
                "private": private,
                "titolo": _controllerTitolo.text,
                "body": _controllerBody.text,
                "accaunt": widget.user.email,
                "tags": []
              });


- Floor:
  **salvataggio preferiti**:

                                    setState(() {
                                    if (_isFavorite) {
                                      widget.database.favoritesDao
                                          .deleteFavorite(
                                              Favorites(widget.docName));
                                      _isFavorite = !_isFavorite;
                                      print(
                                          "RIMOSSO......................................");
                                    } else {
                                      widget.database.favoritesDao
                                          .insertFavorites(
                                              Favorites(widget.docName));
                                      _isFavorite = !_isFavorite;
        print(
        "Aggiunto......................................");
        }
 **Visualizzazione Preferiti**:

     List<Favorites> favoritesF;
    database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final favoritesDao = database.favoritesDao;
    favoritesF = await favoritesDao.findAllFavorites();
    for (Favorites f in favoritesF) {
      favorites.add(f.id);
    }
       if (favorites.contains(doc.id)) //condizione visualizzazione memo dello stream

**Google LogIn**:

        final user = await gogleSingIn.signIn();
    if (user == null) {
      isSingingIn = false;
      return;
    } else {
      final googleAuth = await user.authentication;
      //recupero credenziali
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

Salvataggio Firebase:
- accaunt firebase:  
  await FirebaseAuth.instance.signInWithCredential(credential);
- accaunt App:
  
             FirebaseFirestore.instance.collection("Persona").doc(user.id).set({
            "email" : user.email,
            "nome"  : user.displayName,
            "profilePic" : user.photoUrl
          });

<br>
La visualizzazione dei widget "MemoCard" contenuti un una listView avviene all interno di uno StreamBuilder che ascolta la query che è stata data a secpnda della pagina