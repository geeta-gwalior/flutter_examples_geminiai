

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';


class save extends StatefulWidget {
  const save({super.key});

  @override
  State<save> createState() => _saveState();
}

class _saveState extends State<save> {
  TextEditingController us=TextEditingController();
  TextEditingController em=TextEditingController();
  TextEditingController pwd=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add user"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: const EdgeInsets.symmetric(horizontal: 25),
          child: TextField(
            controller: us,
            decoration: InputDecoration(
              hintText: "enter username",
              suffixIcon: Icon(Icons.verified_user_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              )
            ),
          ),
          ),
          SizedBox(height: 30,),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: em,
              decoration: InputDecoration(
                  hintText: "enter email",
                  suffixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  )
              ),
            ),
          ),
          SizedBox(height: 30,),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                controller: pwd,
                decoration: InputDecoration(
                    hintText: "enter password",
                    suffixIcon: Icon(Icons.verified_user_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    )
                ),
              ),
            ),
          SizedBox(height: 30,),
          ElevatedButton(onPressed: (){
            CollectionReference c=FirebaseFirestore.instance.collection("users");
            c.add({
              "uname":us.text,
              "email":em.text,
              "password":pwd.text,
            }).then((value)=>{
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp1()))
            });
            }, child: Text('SAVE'))
        ],
      ),
    );
  }
}
