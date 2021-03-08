import 'package:flutter/material.dart';

class MemoCard extends StatefulWidget {
  final bool me;
  final titolo;
  final accaunt;
  final body;
  final categoria;
  MemoCard({Key key, this.titolo, this.accaunt, this.body, this.categoria, this.me})
      : super(key: key);

  @override
  _MemoCardState createState() => _MemoCardState();
}

class _MemoCardState extends State<MemoCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 180,
        child: Card(
          color: widget.me?Colors.greenAccent:Colors.white,
          elevation: 5,
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column( 
                mainAxisAlignment: MainAxisAlignment.start,      
                children: [
                  Container(
                    height: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(widget.titolo)),
                                                  
                        Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(icon: Icon(Icons.star_border),
                            onPressed: () {
                              
                            },)
                            
                            ,)
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.accaunt)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,10,0,5),
                    child: Container(
                         height: 109,
                      child: ListView(
                        children: [Text(widget.body)],
                      ),
                    ),
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
