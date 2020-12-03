import 'dart:async';
import 'dart:io';

import 'package:Chat_Perpignano/data/data.dart';
import 'package:Chat_Perpignano/view/widget/messaggio.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final Socket channel;

  Home({Key key, this.channel}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  _sowDialog() async {
    await Future.delayed(Duration(milliseconds: 20));
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        TextEditingController _controllerNome = TextEditingController();
        return AlertDialog(
          title: Text("Inserisci Il Tuo Username"),
          content: Container(
            child: TextField(
              controller: _controllerNome,
              decoration: InputDecoration(labelText: 'Send a message'),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("inserici Nome"),
              onPressed: () {
                nome = _controllerNome.text;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _sowDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Row(
          children: [
            Text("Chat Dart"),
            IconButton(
              icon: Icon(Icons.add_box),
              onPressed: () => _sowDialog(),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StreamBuilder(
              stream: widget.channel,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  messaggioSet.add(String.fromCharCodes(snapshot.data));
                  Timer(
                      Duration(milliseconds: 300),
                      () => _scrollController
                          .jumpTo(_scrollController.position.maxScrollExtent));
                  return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        height: MediaQuery.of(context).size.height * 0.70,
                        child: ListView.builder(
                            controller: _scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: messaggioSet.length - 1,
                            itemBuilder: (BuildContext context, int index) {
                              return Messaggio(
                                  messaggio: messaggioSet.elementAt(index + 1));
                            }),
                      ));
                } else
                  return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: MediaQuery.of(context).size.height * 0.70,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        height: MediaQuery.of(context).size.height * 0.70,
                        child:
                            Center(child: Text("NON SEI CONNESSO AL SERVER")),
                      ));
              },
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 12),
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(labelText: 'Send a message'),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _sendMessage();
                      });
                    },
                    tooltip: 'Send message',
                    icon: Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      widget.channel.write(nome + "/" + _controller.text);
      messaggioSet.add("Tu:1\n" + _controller.text);
      _controller.clear();
    }
  }

  @override
  void dispose() {
    widget.channel.close();
    super.dispose();
  }
}
