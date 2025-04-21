//  for better ui
// alternative  code is commented bellow

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  String result = '';
  String bmiCategory = '';

  void _calculateBMI() {
    if (_formKey.currentState!.validate()) {
      final weight = double.parse(_weightController.text);
      final height = double.parse(_heightController.text);
      final bmi = weight / (height * height);

      setState(() {
        result = bmi.toStringAsFixed(1);
        if (bmi < 18.5) {
          bmiCategory = 'Underweight';
        } else if (bmi < 25) {
          bmiCategory = 'Normal weight';
        } else if (bmi < 30) {
          bmiCategory = 'Overweight';
        } else {
          bmiCategory = 'Obese';
        }
      });
    }
  }

  void _clearFields() {
    _heightController.clear();
    _weightController.clear();
    setState(() {
      result = '';
      bmiCategory = '';
    });
  }

  Color _getBMIColor() {
    if (result.isEmpty) return Colors.grey;
    final bmi = double.parse(result);
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 25) return Colors.green;
    if (bmi < 30) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.indigo.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.indigo.withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.monitor_weight_outlined,
                          size: 60, color: Colors.indigo),
                      const SizedBox(height: 16),
                      Text(
                        'Body Mass Index',
                        style:
                        Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Enter your height and weight to calculate your BMI',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Result Display
                if (result.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: _getBMIColor().withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _getBMIColor(), width: 2),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Your BMI',
                          style: TextStyle(
                            fontSize: 18,
                            color: _getBMIColor(),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          result,
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: _getBMIColor(),
                          ),
                        ),
                        Text(
                          bmiCategory,
                          style: TextStyle(
                            fontSize: 18,
                            color: _getBMIColor(),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: const Text(
                      'Enter your details to calculate BMI',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),

                const SizedBox(height: 40),

                // Input Fields
                TextFormField(
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Height (m)',
                    helperText: 'e.g. 1.75',
                    prefixIcon: const Icon(Icons.height),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your height';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Weight (kg)',
                    helperText: 'e.g. 70',
                    prefixIcon: const Icon(Icons.line_weight),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your weight';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 30),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 3,
                        ),
                        onPressed: _calculateBMI,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calculate, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              'CALCULATE BMI',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: _clearFields,
                      child: const Text("Clear"),
                    )
                  ],
                ),

                const SizedBox(height: 20),
                const Text(
                  'Formula: BMI = weight (kg) / [height (m)]²',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}







// import 'package:flutter/material.dart';
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final _heightController = TextEditingController();
//   final _weightController = TextEditingController();
//   var result = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.indigo.shade200,
//       appBar: AppBar(
//         title: Text('BMI calculator'),
//         centerTitle: true,
//         backgroundColor: Colors.indigo,
//       ),
//       body: Center(
//         child: Container(
//           width: 300,
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   radius: 40,
//                   backgroundColor: Colors.transparent,
//                   child: ClipRRect(child: Icon(Icons.sports_kabaddi, size: 40)),
//                 ),
//                 SizedBox(height: 60),
//                 Container(
//                   width: double.infinity,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     color: Colors.white30,
//                     border: Border.all(color: Colors.indigo, width: 2),
//                   ),
//                   child: Center(child:
//                   result == '' ?
//                   Text('Please enter your height and weight') :
//                       Text('Your BMI is $result')),
//                 ),
//
//                 SizedBox(height: 40),
//                 TextFormField(
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your height';
//                     } else {
//                       return null;
//                     }
//                   },
//                   controller: _heightController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     hintText: 'Enter your height(meter)',
//                     labelText: 'Height',
//                     floatingLabelBehavior: FloatingLabelBehavior.always,
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your weight';
//                     }
//                     if(double.tryParse(value)== null){
//                       return 'Please enter a valid weight';
//                     }
//                       return null;
//                   },
//                   controller: _weightController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     hintText: 'Enter your Weight(kg)',
//                     labelText: 'Weight',
//                     floatingLabelBehavior: FloatingLabelBehavior.always,
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//
//                 SizedBox(height: 20),
//
//                 Container(
//                   width: double.infinity,
//                   child: ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(9.0),
//                       ),
//                       iconColor: Colors.white,
//                       backgroundColor: Colors.indigo,
//                       foregroundColor: Colors.white,
//                     ),
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         var w1 = double.parse(
//                           _weightController.text.toString(),
//                         );
//                         var h1 = double.parse(
//                           _heightController.text.toString(),
//                         );
//                         var bmi = w1 / (h1 * h1);
//                         // Calculate BMI
//                         setState(() {
//                           result = bmi.toStringAsFixed(2);
//                         });
//                       }
//                     },
//                     icon: Icon(Icons.calculate),
//                     label: Text('Calculate'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
