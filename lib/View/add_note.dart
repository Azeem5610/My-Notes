import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_app/Widgets/mybutton.dart';
import 'package:notes_app/Widgets/utils.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  bool isLoading=false;
  final addC=TextEditingController();
  final addNote=FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('notes');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        backgroundColor: Colors.cyan,
        title: Text("ADD NOTE",style: TextStyle(fontSize: 23.sp,fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(  
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
          
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField( 
              controller: addC,
               maxLines: 2,
               minLines: 2,
              decoration: InputDecoration( 
                hintText: "Enter your note",
                 focusColor: Colors.cyan,
                border: OutlineInputBorder( 
                  borderRadius: BorderRadius.circular(8.r)
                ),
                focusedBorder: OutlineInputBorder( 
                  borderRadius: BorderRadius.circular(8.r)
                ),          
              ),
            
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: myButton(
              isLoading: isLoading,
              title: "ADD", onTap:() {
              setState(() {
                isLoading=true;
              });

              addNote.add({
                "title":addC.text,

              }).then((value){
                setState(() {
                  isLoading=false;
                });
        
              Utils().toastMessage("Note added");
              Navigator.pop(context);
              }).onError((error, stackTrace) {
                setState(() {
                  isLoading=false;
                });
                Utils().toastMessage(error.toString());
              },);
              
            },),
          )
        ],
      ),
    );
  }
}