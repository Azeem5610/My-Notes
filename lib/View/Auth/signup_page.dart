import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_app/View/Auth/login_page.dart';
import 'package:notes_app/Widgets/mybutton.dart';
import 'package:notes_app/Widgets/utils.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
   final emailC=TextEditingController();
  final passC=TextEditingController();
  final nameC=TextEditingController();
  final formkey=GlobalKey<FormState>();
  bool isLoading=false;
  FirebaseAuth auth=FirebaseAuth.instance;
  void signUp() async {
  if (formkey.currentState!.validate()) {
    setState(() {
      isLoading = true;
    });

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: emailC.text,
        password: passC.text,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': nameC.text,
        'email': emailC.text,
      }).then((value) {
        setState(() {
          isLoading=false;
        });
        Utils().toastMessage("Sign Up successfully");
      Navigator.pop(context);
      },).onError((error, stackTrace) {
        setState(() {
          isLoading=false;
        });
         Utils().toastMessage(error.toString());
      },);   
    }
  }





  // void signUp(){
  //   if(formkey.currentState!.validate()) {
  //     setState(() {
  //     isLoading=true;
  //   });
  //   }
  //   auth.createUserWithEmailAndPassword(email: emailC.text, password: passC.text).then((value){
  //     setState(() {
  //       isLoading=false;
  //     });
  //     Utils().toastMessage("user added");
  //     Navigator.pop(context);
  //   }).onError((error, stackTrace) {
  //     setState(() {
  //       isLoading=false;
  //     });
  //     Utils().toastMessage(error.toString());
  //   },);
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Colors.grey[200],
      appBar: AppBar( 
        automaticallyImplyLeading: false,
        backgroundColor: Colors.cyan,
        title: Text("SIGN UP",style: TextStyle(fontSize: 23.sp,fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
      ),
      body: Form(
        key:formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [ 
              SizedBox(height:30.h),
              Center(child: Text("WELCOME TO OUR PAGE!",style: TextStyle(fontSize: 23.sp,fontWeight: FontWeight.bold, color: Colors.cyan),)),
              SizedBox(height:30.h),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: TextFormField( 
                  controller:nameC,
                  decoration: InputDecoration( 
                    prefixIcon: const Icon(Icons.person,color: Colors.cyan,),
                    hintText: "Enter Name",
                    border: OutlineInputBorder( 
                       borderRadius: BorderRadius.circular(12)
                    )
                    
                  ),
                 validator: (value) {
                   if(value!.isEmpty){
                    return "Enter the name";
                   }else{
                    return null;
                   }
                 },
                ),
              ),
               SizedBox(height:8.h),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: TextFormField( 
                  controller:emailC,
                  decoration: InputDecoration( 
                    prefixIcon: const Icon(Icons.email,color: Colors.cyan,),
                    hintText: "Enter Email",
                    border: OutlineInputBorder( 
                       borderRadius: BorderRadius.circular(12)
                    )
                    
                  ),
                 validator: (value) {
                   if(value!.isEmpty){
                     return "Enter the email";
                   }else{
                    return null;
                   }
                 },
                ),
              ),
              SizedBox(height:8.h),
          
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: TextFormField( 
                  controller:passC,
                   obscureText: true,
                  obscuringCharacter: "*",
                  decoration: InputDecoration( 
                    prefixIcon: const Icon(Icons.lock,color: Colors.cyan,),
                    hintText: "Enter Password",
                    border: OutlineInputBorder( 
                       borderRadius: BorderRadius.circular(12)
                    )
                    
                  ),
                 validator: (value) {
                   if(value!.isEmpty){
                    return "Enter the Password";
                   }else{
                    return null;
                   }
                 },
                ),
              ),
              SizedBox(height:8.h),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: myButton(
                  
                  title: "Sign up",
                  isLoading: isLoading,
                 onTap:signUp
                 ),
              ),
             
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",style: TextStyle(fontSize: 16.sp),),
                  TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context) => const LoginPage(),));
                },
                child:Text("Login",style: TextStyle(fontSize: 17.sp, color: Colors.cyan[700]),)),
                ],
              )
          ],),
        ),
      ),
    );
  }
}