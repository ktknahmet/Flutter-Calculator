import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
String equation="0";
String result = "0";
String expression ="";


buttonPressed(String buttonText){
setState(() {
  if(buttonText=="C"){
    equation="0";
    result="0";

  }else if(buttonText=="BACK"){
    equation = equation.substring(0,equation.length-1);
    //tek tek silme
    if(equation==""){
      equation="0";
    }

  }else if (buttonText =="="){
    expression=equation;
    expression=expression.replaceAll('x', '*');
    expression=expression.replaceAll('%', '/');
    try{
      Parser p = new Parser();
      Expression exp=p.parse(expression);
      ContextModel cm = ContextModel();
      result= '${exp.evaluate(EvaluationType.REAL,cm)}';
    }catch(e){
      result="ERROR";
    }
  }
  else{
    if(equation=="0"){
      equation=buttonText;
    }
    else{
      equation = equation+buttonText;
    }
  }
});
}

Widget buildButton(String buttonText,double buttonHeight,Color buttonColor){
  return Container(
    height: MediaQuery.of(context).size.height*0.1*buttonHeight,
    color: buttonColor,
    child: FlatButton(
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: Colors.white,
            width: 1,
            style: BorderStyle.solid
        ),
      ),
      padding: EdgeInsets.all(16.0),
      onPressed:() => buttonPressed(buttonText),
      child:Text(
        buttonText,
        style: TextStyle(
          fontSize: 30.0,
        ),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation ,style: TextStyle(fontSize: 38.0),),
          ),
          Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Text(result,style: TextStyle(fontSize: 48.0),),
          ),
          Expanded(
              child:Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width*.75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("C",1, Colors.red),
                        buildButton("BACK",1, Colors.red),
                        buildButton("%",1, Colors.lightGreen),

                      ]
                    ),
                    TableRow(
                        children: [
                          buildButton("7",1, Colors.black54),
                          buildButton("8",1, Colors.black54),
                          buildButton("9",1, Colors.black54),

                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("4",1, Colors.black54),
                          buildButton("5",1, Colors.black54),
                          buildButton("6",1, Colors.black54),

                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("1",1, Colors.black54),
                          buildButton("2",1, Colors.black54),
                          buildButton("3",1, Colors.black54),

                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("(",1, Colors.black54),
                          buildButton(")",1, Colors.black54),
                          buildButton("0",1, Colors.black54),

                        ]
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.25,

                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("x",1,Colors.lightGreen),
                      ]
                    ),
                    TableRow(
                        children: [
                          buildButton("-",1,Colors.lightGreen),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("+",1,Colors.lightGreen),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("=",2,Colors.red),
                        ]
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      )

    );
  }
}
