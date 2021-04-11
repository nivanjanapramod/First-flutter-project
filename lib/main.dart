import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'StartUp Name Generator',
      home: RandomWords(),
      debugShowCheckedModeBanner: false,
    );
  }
}





class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);
  final _saved = <WordPair>{};
  AudioPlayer audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('StartUp Name Generator'),
      ),
      body: _buildSuggestions(),
    );

  }
  Widget _buildSuggestions(){
    return ListView.builder(padding: const EdgeInsets.all(16),
    itemBuilder: (BuildContext _context, int i){
      if (i.isOdd){
        return Divider();
      }
      final int index = i ~/ 2;

      if (index >= _suggestions.length){
        _suggestions.addAll(generateWordPairs().take(10));
      }
      return _buildRow(_suggestions[index]);
    });
  }

  Widget _buildRow(WordPair pair){

    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: GoogleFonts.oswald(),
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: (){
        audioPlayer.play('assets/tone.mp3', isLocal: true);
        setState(() {
          if (alreadySaved){
            _saved.remove(pair);
          }
          else{
            _saved.add(pair);
          }
        });
      },
    );
  }
}
