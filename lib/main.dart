import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const CalculatorScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

//adding calculator UI class
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});
  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}
//createing screen state
class _CalculatorScreenState extends State<CalculatorScreen> {
  //creating display string variable
  String _display = "0";
  //variable to hold values and clear display
  double? _firstNumber;
  String? _operator;
  bool _clearDisplay = false;

  double _formatDisplay() {
    if (_display.endsWith('.')) {
      return double.parse(_display + '0'); //adds a 0 if no number after decimal
    }
    return double.parse(_display);
  }

  //heper method to hanle the pressing of buttons
  void _handlePress(String label) {
    setState(() {
      //if theres an erro message and user presses another button
      if (_display == 'Error' && int.tryParse(label) != null) {
        _display = label;
        _clearDisplay = false;
        return;
      }
      if (_display == "Error" && label == '.') {
        _display = '0.';
        _clearDisplay = false;
        return;
      }
      if (_display == 'Error' && (label == '+' || label == '-' || label == 'x' || label == '÷' || label == '=' || label == '±')) {
        _display = '0';
        _firstNumber = null;
        _operator = null;
        _clearDisplay = false;
      }
      if (int.tryParse(label) != null) {//is a number
        if (_clearDisplay) {
          _display = label;
          _clearDisplay = false;
        } else if (_display == '0') {
          _display = label;
        } else {
          _display = _display + label;
        }
      } else if (label == '+') {
        _firstNumber = _formatDisplay();//set first number
        _operator = label; //store operator
        _clearDisplay = true; // clears display for second number
      } else if (label == '-') {
        _firstNumber = _formatDisplay();//set first number
        _operator = label; //store operator
        _clearDisplay = true; // clears display for second number
      } else if (label == '÷') {
        _firstNumber = _formatDisplay();//set first number
        _operator = label; //store operator
        _clearDisplay = true; // clears display for second number
      } else if (label == 'x') {
        _firstNumber = _formatDisplay();//set first number
        _operator = label; //store operator
        _clearDisplay = true; // clears display for second number
      } else if (label == '=') {//if the operator is equal
      _calculateResult();//helper method
      } else if (label == '.') {
        if (_clearDisplay) {//theres no whold number
          _display = '0.';
          _clearDisplay = false;
        } else {
          if (!_display.contains('.')) {
            _display+='.';
          }
        }
      } else if (label == 'C') {
        _display = '0';
        _firstNumber = null;
        _operator = null;
        _clearDisplay = false;
      } else if (label == '±') {
        if (_display.startsWith('-')) {
          _display = _display.substring(1); //remove the negative sign
        } else {
          _display = '-$_display';
        }
      }
    });
  }

  //helper method to calculate when '=' is pressed
  void _calculateResult() {
    if (_clearDisplay) {// no second number
      _display = 'Error';
      _clearDisplay = true;
      return;
    } else if (_firstNumber ==null || _operator == null) {
      _display = 'Error';
      _clearDisplay = true;
      return;
    }
    double a = _firstNumber!;
    double b = _formatDisplay();//convert from string to double
    String op = _operator!;
    double res;
    if (op == '+') {
      res = a + b;
    } else if (op == '-') {
      res = a - b;
    } else if (op == 'x') {
      res = a * b;
    } else if (op == '÷') {
      if (b == 0){ //handle divide by 0 error
        _display = 'Error';
        _clearDisplay = true;
        return;
      } else {
        res = a / b;
      }
      
    } else {
      return;
    }
    _display = res.toStringAsFixed(2);
    _clearDisplay = true;
    }
  

  //helper method to print labels for buttons
  Widget _buildButton(String label) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ElevatedButton(
          onPressed: () {
            _handlePress(label);
          },
          child: Text(
            label,
            style: const TextStyle(fontSize: 22),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child:Container(
            width: 380,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color:  const Color(0xFF1B1F2A),
              borderRadius: BorderRadius.circular(28),
              boxShadow: const[
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 30,
                  offset: Offset(0, 20),
                )
              ]
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      _display,
                      style: const TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                //creating rows of buttons
                Row( //Row 1
                  children: [
                    _buildButton("C"),
                    _buildButton("±"), //1
                    _buildButton("÷"),//2
                    _buildButton("x"),
                  ],
                ),
                Row( //Row 2
                  children: [
                    _buildButton("7"),
                    _buildButton("8"), //1
                    _buildButton("9"),//2
                    _buildButton("-"),
                  ],
                ),
                Row( //Row 3
                  children: [
                    _buildButton("4"),
                    _buildButton("5"), //1
                    _buildButton("6"),//2
                    _buildButton("+"),
                  ],
                ),
                Row( //Row 4
                  children: [
                    _buildButton("1"),
                    _buildButton("2"), //1
                    _buildButton("3"),//2
                    _buildButton("="),
                  ],
                ),
                Row( //Row 5
                  children: [ 
                    Expanded(
                      flex: 3,//'0' button need to be the full length of 3
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: ElevatedButton(
                          onPressed: () => _handlePress('0'),
                          child: const Text(
                            '0',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1, //takes the remaining 1
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: ElevatedButton(
                          onPressed: () => _handlePress("."),
                          child: const Text(
                            '.',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}