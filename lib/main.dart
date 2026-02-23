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

  //helper method to print labels for buttons
  Widget _buildButton(String label) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ElevatedButton(
          onPressed: () {
            print(label);
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
                          onPressed: () => print('0'),
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
                          onPressed: () => print("."),
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