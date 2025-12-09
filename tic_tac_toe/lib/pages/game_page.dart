import 'package:flutter/material.dart';

class Tic_Tac_Toe extends StatefulWidget {
  const Tic_Tac_Toe({super.key});

  @override
  State<Tic_Tac_Toe> createState() => _Tic_Tac_ToeState();
}

class _Tic_Tac_ToeState extends State<Tic_Tac_Toe> {
  String lastValue = "X";
  List boardData = ["", "", "", "", "", "", "", "", ""];

  changeValue(){
    if(lastValue == "X"){
      lastValue = "O";
    }else{
      lastValue = "X";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text( 'Tic Tac Toe', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
          Container(
            height: 430,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: 9,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisSpacing: 2,mainAxisSpacing: 2, crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if(boardData[index] == ""){
                        boardData[index] = lastValue;
                        changeValue();
                        setState(() {

                        });
                      }

                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration( color: Colors.blue,),
                      child: Center(
                          child: Text(boardData[index],
                            style: TextStyle(
                                color: Colors.white,fontSize: 24),)),
                    ),
                  );
                },),
            ),
          ),
          Divider(),
          Text("Turn of $lastValue",style: TextStyle(fontSize: 22,color: Colors.black),),
        ],
      ),
    );
  }
}