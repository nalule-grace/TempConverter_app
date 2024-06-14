import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  String _conversionType = 'F to C';
  final TextEditingController _controller = TextEditingController();
  double _result = 0.0;
  List<String> _history = [];

  void _convert() {
    double input = double.parse(_controller.text);
    double converted;
    if (_conversionType == 'F to C') {
      converted = (input - 32) * 5 / 9;
    } else {
      converted = input * 9 / 5 + 32;
    }
    setState(() {
      _result = double.parse(converted.toStringAsFixed(2));
      _history.add('$_conversionType: ${input.toStringAsFixed(2)} is $_result');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Temperature here',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color.fromARGB(255, 251, 213, 243),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Fahrenheit to Celcius'),
                    leading: Radio<String>(
                      value: 'F to C',
                      groupValue: _conversionType,
                      onChanged: (String? value) {
                        setState(() {
                          _conversionType = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Celcius to Fahrenheit'),
                    leading: Radio<String>(
                      value: 'C to F',
                      groupValue: _conversionType,
                      onChanged: (String? value) {
                        setState(() {
                          _conversionType = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _convert,
              style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 226, 168, 200), // Button color
              ),
              child: Text('Convert'),
            ),
            SizedBox(height: 16),
            Text(
              'Result: $_result',
              style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 104, 9, 79)),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 16),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 128, 26, 77)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  itemCount: _history.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_history[index]),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
