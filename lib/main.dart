import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blueGrey,
      canvasColor: Color(0xffffffff),
      ),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

  // INICIALIZACION DE VARIABLES PARA LA ECUACION Y RESULTADOS
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;


  // INGRESO DE DATOS MEDIANTE BOTONES
  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if(buttonText == "⌫"){
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if(equation == ""){
          equation = "0";
        }

      } else if(buttonText == ".") {

        String res = equation.substring(equation.length - 1);
        print("$res");
        if(res == ".") {
        }else{
          equationFontSize = 48.0;
          resultFontSize = 38.0;
          if(equation == "0"){
            equation = buttonText;
          }else {
            equation = equation + buttonText;
          }
        }


      } else if(buttonText == "="){
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        // REALIZANDO LAS OPERACIONES "+" "-" "×" "÷" utilizando la biblioteca math_expressions
        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }

      }
        else{
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if(equation == "0"){
          equation = buttonText;
        }else {
          equation = equation + buttonText;
        }
      }
    });
  }

  // DEFINIR CARACTERISTICAS DE LOS BOTONES
  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor, Color textcolor){
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
              color: Colors.white12,
              width: 1,
              style: BorderStyle.solid
          )
      ),
      padding: EdgeInsets.all(16.0)

    );
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
          style: flatButtonStyle,
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: textcolor
            ),
          )
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Calculator')),
      body: Column(
        children: <Widget>[

          // TAMAÑO DE LETRA DE LA ECUACION
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: equationFontSize),),
          ),

          // TAMAÑO DE LETRA DE LA RESPUESTA
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resultFontSize),),
          ),


          Expanded(
            child: Divider(),
          ),

          // AÑADIENDO LOS BOTONES POR FILAS
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("C", 1, Color(0xffdbd9d9), Colors.black),
                          buildButton("⌫", 1, Color(0xffdbd9d9), Colors.black),
                          buildButton("", 1, Color(0xffdbd9d9), Colors.black),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("7", 1, Color(0xffdbd9d9), Colors.black),
                          buildButton("8", 1, Color(0xffdbd9d9), Colors.black),
                          buildButton("9", 1, Color(0xffdbd9d9), Colors.black),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("4", 1, Color(0xffdbd9d9), Colors.black),
                          buildButton("5", 1, Color(0xffdbd9d9), Colors.black),
                          buildButton("6", 1, Color(0xffdbd9d9), Colors.black),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("1", 1, Color(0xffdbd9d9), Colors.black),
                          buildButton("2", 1, Color(0xffdbd9d9), Colors.black),
                          buildButton("3", 1, Color(0xffdbd9d9), Colors.black),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("0", 1, Color(0xffdbd9d9), Colors.black),
                          buildButton("00", 1, Color(0xffdbd9d9), Colors.black),
                          buildButton(".", 1, Color(0xffdbd9d9), Colors.black),
                        ]
                    ),
                  ],
                ),
              ),

              // AÑADIENDO LOS BOTONES DE OPERACIONES EN UNA COLUMNA
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("÷", 1, Color(0xff575454), Colors.white),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("×", 1, Color(0xff575454), Colors.white),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("-", 1, Color(0xff575454), Colors.white),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("+", 1, Color(0xff575454), Colors.white),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("=", 1, Colors.redAccent, Colors.white),
                        ]
                    ),
                  ],
                ),
              )
            ],
          ),

        ],
      ),
    );
  }
}

