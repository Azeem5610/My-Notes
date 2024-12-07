import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_app/View/add_note.dart';
import 'package:notes_app/View/Auth/login_page.dart';
import 'package:notes_app/Widgets/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final firestore = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('notes').snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('notes');
  final auth = FirebaseAuth.instance;
  final editC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 20.h, left: 12.w),
        child: FloatingActionButton(
          backgroundColor: Colors.cyan[700],
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddNote(),
                ));
          },
          elevation: 8.0,
          child: Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          "My Notes",
          style: TextStyle(
              fontSize: 23.sp, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              iconSize: 30,
              color: Colors.red,
              onPressed: () {
                auth.signOut().then((value) {
                  Utils().toastMessage('Logged out');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Text("Some error occurred.");
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              
              itemBuilder: (context, index) {
                String title = snapshot.data!.docs[index]['title'];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.cyan[100],
                    child: ListTile(
                      title: Text(
                        snapshot.data!.docs[index]['title'],
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      trailing: PopupMenuButton(
                        color: Colors.grey[100],
                        icon: Icon(Icons.more_vert, color: Colors.cyan[700]),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            
                            child: ListTile(
                              leading: Icon(Icons.edit, color: Colors.cyan[700]),
                              title: Text("Edit",style: TextStyle(fontSize: 16.sp),),
                              onTap: () {
                                editC.text = title;
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.grey[300],
                                      actions: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 7.h),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Edit Note :",
                                                style: TextStyle(
                                                    fontSize: 19.sp,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                maxLines: 2,
                                                minLines: 2,
                                                controller: editC,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder( 
                                                    borderRadius: BorderRadius.circular(10)
                                                  ),
                                                  hintText: "Edit your note",
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w800,
                                                        fontSize: 16.sp,
                                                        color: Colors.cyan[600]),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    ref
                                                        .doc(snapshot.data!.docs[
                                                            index]
                                                        .id)
                                                        .update({
                                                      'title': editC.text,
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Update",
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        color: Colors.cyan[600],
                                                        fontWeight: FontWeight.w800,
                                                        ),
                                                        
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          PopupMenuItem(
                            child: ListTile(
                              leading: const Icon(Icons.delete, color: Colors.red),
                              title: Text("Delete",style: TextStyle(fontSize: 16.sp,),),
                              onTap: () {
                                ref.doc(snapshot.data!.docs[index].id).delete();
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

//   Future<void>showDialogue(String title,String id){
//     Navigator.pop(context);
//     editC.text=title;
//     return showDialog(context: context, builder:(context) {
//            return AlertDialog( 
//                 actions: [ 
//                     Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                        SizedBox(height:7.h),
//                        Padding(
//                          padding: const EdgeInsets.all(8.0),
//                                child: Text("Edit",style: TextStyle(fontSize: 19.sp,fontWeight: FontWeight.bold),),
//                      ),
//                           Padding(
//                        padding: const EdgeInsets.all(8.0),
//                         child: TextField( 
//                        controller: editC,
//                         decoration: InputDecoration( 

//                         ),
//                         onChanged: (value) {
                            
//                             },
//                       ),
//                         ),
//                          Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                            children: [ 
                                      
//                               TextButton(onPressed:() {
//                                  Navigator.pop(context);
//                                  }, child: Text("Cancel",style: TextStyle(fontSize: 16.sp,color: Colors.cyan[600]),)),
//                               TextButton(onPressed:() {
//                                    ref.doc(id).update({
//                                       'title':editC.text
//                                    });
//                                Navigator.pop(context); 
//                                }, child: Text("Update",style: TextStyle(fontSize: 16.sp,color: Colors.cyan[600]),)),

//                                     ],)
//                                       ],
//                                     ),
                                   
//                                   ],
//                                 );
//                               },);
//   }
// }