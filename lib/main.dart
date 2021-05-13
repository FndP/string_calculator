import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int value = 0;
  String error = "";
  final intInStr = RegExp(r'\d+');
  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              value!=0?value.toString():"0",
            ),
            // error.isNotEmpty?
            // Text(
            //   error.isNotEmpty?error:"",
            // ):SizedBox(),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              minLines: 1,
              controller: _controller,
              // inputFormatters: [new WhitelistingTextInputFormatter(RegExp("[0-9 +-,//]")),],
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                      color: Colors.grey
                  ),
                  labelText: 'Enter your text',
                  hintText: 'Enter Your text'),
              onChanged: (text) {
                value = 0;
                calculatorWithValidator(text, false);
              },
            )
          ],
        ),
      ),
    );
  }


  @visibleForTesting
  calculatorWithValidator(String text, bool isTesting) {
    if(!text.contains("-")){
      Iterable data = intInStr.allMatches(text).map((m) => m.group(0));

      if(isTesting){
        for (var element in data) {
          if(int.parse(element)<=1000){
            value += int.parse(element);
          }
        }
        // value = text;
        error = "";
        print(value);
      }else{
        setState(() {
          for (var element in data) {
            if(int.parse(element)<=1000){
              value += int.parse(element);
            }
          }
          // value = text;
          error = "";
          print(value);
        });
      }

    }else{
      if(isTesting){
        error = "Negatives not allowed.";
      }else{
        setState(() {
          error = "Negatives not allowed.";
        });
      }
    }
  }
}
