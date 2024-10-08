import 'package:flutter/material.dart';

class btm extends StatefulWidget {
  const btm({super.key});

  @override
  State<btm> createState() => _btmState();
}

class _btmState extends State<btm> {
  int select=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      // bottomNavigationBar: BottomNavigationBar(items: [
      //   BottomNavigationBarItem(icon: IconButton(onPressed: (){}, icon: Icon(Icons.home),)),
      //   BottomNavigationBarItem(icon: IconButton(onPressed: (){}, icon: Icon(Icons.account_circle),)),
      //   BottomNavigationBarItem(icon: IconButton(onPressed: (){}, icon: Icon(Icons.info_outline),))
      // ],
      // backgroundColor: Colors.purple,
      //   onTap: (index){
      //   setState(() {
      //     select=index;
      //   });
      //
      //
      //
      //   },
      //   currentIndex: select,
      //
      // ),
    );
  }
}
