import 'package:app_memo_xp/floor_database/entities/favorites.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';

class MemoCard extends StatefulWidget {
  final Timestamp date;
  final private;
  final bool me;
  final titolo;
  final accaunt;
  final body;
  final tags;
  final docName;
  final database;
  MemoCard(
      {Key key,
      this.titolo,
      this.accaunt,
      this.body,
      this.tags,
      this.me,
      this.docName,
      this.database,
      this.private,
      this.date})
      : super(key: key);

  @override
  _MemoCardState createState() => _MemoCardState();
}

class _MemoCardState extends State<MemoCard> {
  bool _isEditingText = false;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
  }

  isFavorite() async {
    final favoritesDao = widget.database.favoritesDao;
    await favoritesDao.findFavoritesById(widget.docName).listen((favorite) {
      if (favorite.id == widget.docName) {
        return _isFavorite = true;
      }
      return _isFavorite = false;
    });
  }

  Widget _editTitleTextField(String initialText) {
    TextEditingController _editingController =
        TextEditingController(text: initialText);
    if (_isEditingText && widget.me) {
      return TextField(
        onSubmitted: (newValue) {
          setState(() {
            FirebaseFirestore.instance
                .collection("Memo")
                .doc(widget.docName)
                .update({"body": newValue});
            initialText = newValue;
            _isEditingText = false;
          });
        },
        autofocus: true,
        controller: _editingController,
      );
    } else
      return InkWell(
          onTap: () {
            setState(() {
              _isEditingText = true;
            });
          },
          child: Container(
            child: Text(
              initialText,
              style: TextStyle(
                color: Colors.black,
                fontSize: 13.0,
              ),
            ),
          ));
  }

  Widget _editTitleField(String initialText) {
    TextEditingController _editingControllerTitle =
        TextEditingController(text: initialText);
    if (_isEditingText && widget.me) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: TextField(
          onSubmitted: (newValue) {
           
              FirebaseFirestore.instance
                  .collection("Memo")
                  .doc(widget.docName)
                  .update({"titolo": newValue});
              initialText = newValue;
              _isEditingText = false;
          },
          autofocus: true,
          controller: _editingControllerTitle,
        ),
      );
    } else
      return InkWell(
          onTap: () {
            setState(() {
              _isEditingText = true;
            });
          },
          child: Text(
            initialText,
            style: TextStyle(
              color: widget.me ? Colors.greenAccent[700] : Colors.black,
              fontSize: 20.0,
            ),
          ));
  }
 

  @override
  Widget build(BuildContext context) {
    List tags = widget.tags ?? [];
    final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
   DateTime date =DateTime.fromMicrosecondsSinceEpoch(widget.date.microsecondsSinceEpoch);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Card(
          shadowColor: widget.me ? Colors.greenAccent : Colors.white,
          color: Colors.white,
          elevation: 5,
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _editTitleField(
                          widget.titolo,
                        ),
                        Spacer(),
                        widget.me
                            ? IconButton(
                                icon: Icon(widget.private
                                    ? Icons.lock
                                    : Icons.lock_open),
                                onPressed: () {
                                  setState(() {
                                    FirebaseFirestore.instance
                                        .collection("Memo")
                                        .doc(widget.docName)
                                        .update({"private": !widget.private});
                                  });
                                })
                            : Container(),
                        FutureBuilder(
                            future: isFavorite(),
                            builder: (context, snapshot) {
                              return IconButton(
                                icon: Icon(_isFavorite
                                    ? Icons.star
                                    : Icons.star_border),
                                onPressed: () {
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
                                  });
                                },
                              );
                            }),
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(date.day.toString()+" "+whatMonth(date.month)),),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.me
                          ? "${widget.accaunt} (Tu)"
                          : "${widget.accaunt}")),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                    child: Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.70,
                            color: Color.fromRGBO(245, 245, 245, 0.7),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _editTitleTextField(widget.body),
                            )),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      widget.me
                          ? IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                return showDialog(
                                    context: context,
                                    builder: (context) {
                                      TextEditingController _controllerTag =
                                          TextEditingController();
                                      return AlertDialog(
                                        title: Center(
                                            child: Text("Aggiungi un Tag")),
                                        content: Container(
                                          height: 30,
                                          width: 80,
                                          child: TextField(
                                            controller: _controllerTag,
                                            keyboardType: TextInputType.text,
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                                width: 80,
                                                height: 25,
                                                child: Center(
                                                    child: Text("Cancella"))),
                                            style: ButtonStyle(
                                                alignment:
                                                    Alignment.bottomLeft),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                tags.add(_controllerTag.text);
                                                FirebaseFirestore.instance
                                                    .collection("Memo")
                                                    .doc(widget.docName)
                                                    .update({"tags": tags});
                                                Navigator.of(context).pop();
                                              },
                                              child: Container(
                                                  width: 80,
                                                  height: 25,
                                                  child: Center(
                                                      child: Text("Salva"))),
                                              style: ButtonStyle(
                                                  alignment:
                                                      Alignment.bottomLeft))
                                        ],
                                      );
                                    });
                              })
                          : Container(),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.60,
                        child: Tags(
                          alignment: WrapAlignment.start,
                          runAlignment: WrapAlignment.start,
                          key: _tagStateKey,
                          itemCount: tags.length,
                          itemBuilder: (int index) {
                            return ItemTags(
                                key: Key(index.toString()),
                                index: index,
                                title: tags[index],
                                combine: ItemTagsCombine.withTextBefore,
                                removeButton: widget.me
                                    ? ItemTagsRemoveButton(
                                        onRemoved: () {
                                          setState(() {
                                            tags.removeAt(index);
                                            FirebaseFirestore.instance
                                                .collection("Memo")
                                                .doc(widget.docName)
                                                .update({"tags": tags});
                                          });
                                          return true;
                                        },
                                      )
                                    : null);
                          },
                        ),
                      ),
                      Spacer(),
                      widget.me?Container(
                        width: 20,
                        height: 20,
                        child: Center(
                          child: IconButton(
                              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                              icon: Icon(
                                Icons.delete,
                                size: 25,
                              ),
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection("Memo")
                                    .doc(widget.docName)
                                    .delete();
                              }),
                        ),
                      ):Container(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String whatMonth(int month) {
  switch(month) { 
   case 1: { 
      return "Gennaio";
   } 
   break; 
  
   case 2: { 
       return "Febbraio";
   } 
   break; 
      case 3: { 
      return "Marzo";
   } 
   break; 
  
   case 4: { 
       return "Aprile";
   } 
   break; 
      case 5: { 
     return "Maggio";
   } 
   break; 
  
   case 6: { 
      return "Gugnio";
   } 
   break; 
      case 7: { 
       return "Lulgio";
   } 
   break; 
  
   case 8: { 
       return "Agosto";
   } 
   break; 
      case 9: { 
     return "Settembre"; 
   } 
   break; 
  
   case 10: { 
      return "Ottobre";
   } 
   break; 
      case 11: { 
      return "Novembre";
   } 
   break; 
  
   case 12: { 
       return "Dicembre";
   } 
   break; 
      
   default: { 
       return "Gennaio";
   }
   break; 
} 
}
