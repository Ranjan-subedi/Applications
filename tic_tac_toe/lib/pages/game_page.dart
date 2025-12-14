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

// Check Winner
  checkWinner(){
    if(boardData[0]==boardData[1] && boardData[1]==boardData[2]){
      print("Winner is $lastValue");
    }else if(boardData[3]==boardData[4] && boardData[4]==boardData[5]){
      print("Winner is $lastValue");
    }else if(boardData[6]==boardData[7]&& boardData[7]==boardData[]){
      print("Winner is $lastValue");
    }else if(boardData[0]==boardData[3] && boardData[3]==boardData[6]){
      print("Winner is $lastValue");
    }else if(boardData[1]==boardData[4] && boardData[4]==boardData[7]){
      print("Winner is $lastValue");
    }else if(boardData[2]==boardData[5] && boardData[5]==boardData[8]){
      print("Winner is $lastValue");
      }else if(boardData[0]==boardData[4] && boardData[4]==boardData[8]){
      print("Winner is $lastValue");
      }else if(boardData[2]==boardData[4] && boardData[4]==boardData[6]){
      print("Winner is $lastValue");
      }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkWinner(); 
     }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0F0D),
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text("Tic-Tac-Toe",style: TextStyle(
            letterSpacing: 2,
            fontWeight: FontWeight.bold,fontSize: 40),),
        centerTitle: true,
        backgroundColor: Color(0xFF091F1B),
        foregroundColor: Color(0xFF00FFA3),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 430,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: 9,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisSpacing: 4,mainAxisSpacing: 4, crossAxisCount: 3),
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
                      decoration: BoxDecoration( color: Color(0xFF10312B),
                      borderRadius: BorderRadius.circular(16)
                      ),
                      child: Center(
                          child: Text(boardData[index],
                            style: TextStyle(
                                color: boardData[index]=="X" ? Color(0xFF00FF88): Color(0xFFFF005C),fontSize: 32, fontWeight: FontWeight.bold),)),
                    ),
                  );
                },),
            ),
          ),
          Divider(),
          Text("Turn of $lastValue",style: TextStyle(fontSize: 28,color: Color(0xFF00FFA3),fontWeight: FontWeight.w600,letterSpacing: 1.5),),

          SizedBox(
            height: 20,
          ),
          Text("Winner",style: TextStyle(
            fontSize: 18,color: Color(0xFF00FFA3),
          )),
          Container(
            color: Colors.white24,
            height: 40,
            width: MediaQuery.of(context).size.width*0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("O 1",style: TextStyle(
                  fontSize: 18,color: Color(0xFF00FFA3),
                ),),
                Text("X 1",style: TextStyle(
                  fontSize: 18,color: Color(0xFFFF005C),

                ),)


              ],
            ),
          )
        ],
      ),
    );
  }
}