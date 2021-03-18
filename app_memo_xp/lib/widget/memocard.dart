import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';

class MemoCard extends StatefulWidget {
  final bool me;
  final titolo;
  final accaunt;
  final body;
  final tags;
  final docName;
  MemoCard(
      {Key key,
      this.titolo,
      this.accaunt,
      this.body,
      this.tags,
      this.me,
      this.docName})
      : super(key: key);

  @override
  _MemoCardState createState() => _MemoCardState();
}

class _MemoCardState extends State<MemoCard> {
  bool _isEditingText = false;
  @override
  Widget build(BuildContext context) {
    List tags = widget.tags ?? [];
     

    final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();



    Widget _editTitleTextField(String initialText) {
       TextEditingController _editingController=TextEditingController(text: initialText);
      if (_isEditingText && widget.me   ) {
        return TextField(
          onSubmitted: (newValue) {
            setState(() {
              initialText = newValue;
              _isEditingText = false;
              FirebaseFirestore.instance
                  .collection("Memo")
                  .doc(widget.docName)
                  .update({"body": newValue});
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
       TextEditingController _editingControllerTitle=TextEditingController(text: initialText);
      if (_isEditingText && widget.me) {
        return Container(
          width: MediaQuery.of(context).size.width*0.6,
          child: TextField(
            onSubmitted: (newValue) {
              setState(() {
                initialText = newValue;
                _isEditingText = false;
                FirebaseFirestore.instance
                    .collection("Memo")
                    .doc(widget.docName)
                    .update({"title": newValue});
                print(_isEditingText);
              });
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
                color: widget.me?Colors.greenAccent[700]:Colors.black,
                fontSize: 20.0,
              ),
            ));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Card(
          shadowColor:widget.me ? Colors.greenAccent: Colors.white,
          color:  Colors.white,
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
                        Align(
                            alignment: Alignment.centerLeft,
                            child: _editTitleField(widget.titolo,)),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(Icons.star_border),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.accaunt)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                    child: Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            color: Color.fromRGBO(250, 250, 250, 0.7),
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
                                          width: 100,
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
                        width: 300,
                        child: Tags(
                          alignment: WrapAlignment.start,
                          runAlignment: WrapAlignment.start,
                          key: _tagStateKey,
                          itemCount: tags.length,
                          itemBuilder: (int index) {
                            return ItemTags(
                                key: Key(index.toString()),
                                index: index, // required
                                title: tags[index],

                                // textStyle: TextStyle( fontSize: , ),
                                combine: ItemTagsCombine.withTextBefore,
                                removeButton: widget.me
                                    ? ItemTagsRemoveButton(
                                        onRemoved: () {
                                          // Remove the item from the data source.
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
