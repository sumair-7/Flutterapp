import "package:flutter/material.dart";
import "package:english_words/english_words.dart";

class Randomwords extends StatefulWidget{
  Randomwordstate createState() => Randomwordstate();
}

class Randomwordstate extends State<Randomwords>{

  final _randomwordpairs = <WordPair>[];
  final _savedwordpair = Set<WordPair>();
  Widget _buildList(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
  itemBuilder: (context, item) {
    if(item.isOdd){
      return Divider();
    } 

    final  index = item ~/ 2;
    if(index >= _randomwordpairs.length){
      _randomwordpairs.addAll(generateWordPairs().take(15));
    }
    return _buildRow(_randomwordpairs[index],);
  },
    );
  }
  Widget _buildRow(WordPair pair){
    final alreadysaved = _savedwordpair.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase, style: TextStyle(fontSize: 16),),
      trailing: Icon(alreadysaved ? Icons.favorite : Icons.favorite_border, color: alreadysaved ? Colors.red : null),
      onTap: (){
        setState(() {
          if(alreadysaved)
          _savedwordpair.remove(pair);
          else
            _savedwordpair.add(pair);
        });
      },
    );
  }
  void _pushsaved(){
    Navigator.of(context).push(
      MaterialPageRoute(builder:(BuildContext context){
        final Iterable<ListTile> tiles = _savedwordpair.map((WordPair pair){
          return ListTile(
            title: Text(pair.asPascalCase, style: TextStyle(fontSize: 16.0),),
          );
        });
        final List<Widget> divided = ListTile.divideTiles(
          context: context,
          tiles: tiles,
        ).toList();
        return Scaffold(
          appBar: AppBar(title: Text("Saved WordPairs",),),
          body: ListView(children: divided,),
        );
      }
      )
    );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Word Pair Generator"),
        actions: <Widget>[
          IconButton(onPressed: _pushsaved, icon :Icon(Icons.list),),
        ],   
      ),
      body: _buildList(),
    );
  }
}