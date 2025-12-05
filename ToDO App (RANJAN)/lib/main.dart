import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    ));

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = TextEditingController();
  String task = "";

  List todo = [
    ['your work here', true],
    // ['man you are too late', false],
    // ['are you going for a or not!', true],
    // ['are you free or not  ?', true]
  ];



  // List<bool> isdonelist = List.generate(todo.length, (index) => false);
  @override
  // bool isdone = false;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.menu),
            Text(
              'Todo app',
              style: TextStyle(
                color: Colors.white60,
                fontWeight: FontWeight.w900,
                fontSize: 30,
                letterSpacing: 2,
                shadows: [
                  Shadow(
                    color: Colors.purple.withOpacity(0.3),
                    offset: Offset(2, 2),
                    blurRadius: 3,
                  ),
                  Shadow(
                    color: Colors.pink.withOpacity(0.3),
                    offset: Offset(-2, -2),
                    blurRadius: 3,
                  ),
                ],
              ),
            ),
            Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRect(
                child: ClipRRect(
                  child: Icon(
                    Icons.people,
                  ),
                ),
              ),
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(4),
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.purple[300],
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    iconColor: Colors.purple,
                    title: Text(
                      todo[index][0],
                      style: TextStyle(
                          fontSize: 18,
                          decoration: todo[index][1]
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                    subtitle: Text(
                      'Hold Icons to delete',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),

                    // if task is done check the box else leave it.
                    leading: Checkbox(
                        activeColor: Colors.amber.shade300,
                        // hoverColor: Colors.blue,
                        side: BorderSide(color: Colors.amber.shade300),
                        checkColor: Colors.indigo.shade300,
                        value: todo[index][1],
                        onChanged: (value) {
                          setState(() {
                            todo[index][1] = value!;
                          });
                        }),

                    // we are adding delete btn at the last
                    trailing: Icon(
                      Icons.delete,
                      color: Colors.amber.shade600,
                    ),
                    // we made it longpress to dodge unwanted touch to delete btn
                    onLongPress: () {
                      setState(() {
                        todo.removeAt(index);
                      });
                    },
                  ),
                );
              },
              itemCount: todo.length,
            ),
          ),
        ],
      ),


      // it will take empty box also we have to prevent it with the help of Form validation
      floatingActionButton: Row(
        children: [
          Expanded(
              child: Container(
                  padding: EdgeInsets.all(9),
                  margin: EdgeInsets.only(left: 20),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(255, 207, 195, 209),
                        hintText: 'enter your text',
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14))),
                  ))),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                todo.add([_controller.text, false]);
                _controller.clear();
              });
            },
            child: Icon(Icons.add_to_queue),
          ),
        ],
      ),
    );
  }
}
