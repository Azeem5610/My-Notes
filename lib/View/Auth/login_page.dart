import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_app/View/Auth/forgot_password.dart';
import 'package:notes_app/View/home_page.dart';
import 'package:notes_app/Widgets/mybutton.dart';
import 'package:notes_app/View/Auth/signup_page.dart';
import 'package:notes_app/Widgets/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailC=TextEditingController();
  final passC=TextEditingController();
  final formkey=GlobalKey<FormState>();
   bool isLoading=false;
  FirebaseAuth auth=FirebaseAuth.instance;
  void Login(){
     if(formkey.currentState!.validate()) {
       setState(() {
                   isLoading=true;
                 });
     }
                 auth.signInWithEmailAndPassword(email: emailC.text, password: passC.text).then((value){
                  setState(() {
                    isLoading=false;
                  });
                  Utils().toastMessage("User logged in");
                  Navigator.push(context, MaterialPageRoute(builder:(context) => const HomePage(),));
                  
                 }).onError((error, stackTrace) {
                  setState(() {
                    isLoading=false;
                  });
                   Utils().toastMessage(error.toString());
                 },);
          
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Colors.grey[200],
      appBar: AppBar( 
        automaticallyImplyLeading: false,
        backgroundColor: Colors.cyan,
        title: Text("LOGIN",style: TextStyle(fontSize: 23.sp,fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
      ),
      body: Form(
        key:formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [ 
              SizedBox(height:30.h),
              Center(child: Text("WELCOME BACK!",style: TextStyle(fontSize: 23.sp,fontWeight: FontWeight.bold, color: Colors.cyan),)),
              SizedBox(height:30.h),
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
                 validator: (value){
                   if(value!.isEmpty){
                    return "Enter the Email";
                   }else{
                    return null;
                   }
                 },
                ),
              ),
              SizedBox(height:8.h),
          
              Padding(
                padding:  const EdgeInsets.all(14.0),
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
                  isLoading: isLoading,
                  title: "Login", onTap:Login),
              ),
              Align(alignment: Alignment.bottomRight, 
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context) => const ForgotPassword(),));
                },
                child:Text("Forgot Password?",style: TextStyle(fontSize: 16.sp,color: Colors.cyan[700]),)),
              ),
             
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Do not have an account?",style: TextStyle(fontSize: 16.sp),),
                  TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context) => const SignupPage(),));
                },
                child:Text("Sign up",style: TextStyle(fontSize: 17.sp, color: Colors.cyan[700]),)),
                ],
              )
          ],),
        ),
      ),
    );
  }
}


// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:notes_app/forgot_password.dart';
// import 'package:notes_app/home_page.dart';
// import 'package:notes_app/mybutton.dart';
// import 'package:notes_app/signup_page.dart';
// import 'package:notes_app/utils.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final emailC = TextEditingController();
//   final passC = TextEditingController();
//   final formKey = GlobalKey<FormState>();
//   bool isLoading = false;
//   FirebaseAuth auth = FirebaseAuth.instance;

//   void login() {
//     if (formKey.currentState!.validate()) {
//       setState(() {
//         isLoading = true;
//       });
//       auth
//           .signInWithEmailAndPassword(email: emailC.text, password: passC.text)
//           .then((value) {
//         setState(() {
//           isLoading = false;
//         });
//         Utils().toastMessage("User logged in");
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => HomePage()));
//       }).onError((error, stackTrace) {
//         setState(() {
//           isLoading = false;
//         });
//         Utils().toastMessage(error.toString());
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         backgroundColor: Colors.cyan,
//         title: Text(
//           "LOGIN",
//           style: TextStyle(
//               fontSize: 23.sp, fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "WELCOME BACK!",
//                   style: TextStyle(
//                     fontSize: 24.sp,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.cyan[700],
//                   ),
//                 ),
//                 SizedBox(height: 20.h),
//                 Card(
                  
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 5,
//                   child: Padding(
//                     padding: EdgeInsets.all(16.w),
//                     child: Form(
//                       key: formKey,
//                       child: Column(

//                         children: [
                        
//                           TextFormField(
//                             controller: emailC,
//                             decoration: InputDecoration(
//                               hintText: "Enter Email",
//                               prefixIcon: Icon(Icons.email, color: Colors.cyan),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return "Enter the Email";
//                               } else {
//                                 return null;
//                               }
//                             },
//                           ),
//                           SizedBox(height: 15.h),
//                           TextFormField(
//                             controller: passC,
//                             obscureText: true,
//                             decoration: InputDecoration(
//                               hintText: "Enter Password",
//                               prefixIcon:
//                                   Icon(Icons.lock, color: Colors.cyan),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return "Enter the Password";
//                               } else {
//                                 return null;
//                               }
//                             },
//                           ),
//                           SizedBox(height: 20.h),
//                           myButton(
//                             isLoading: isLoading,
//                             title: "Login",
//                             onTap: () {
//                               login();
//                             },
//                           ),
//                           SizedBox(height: 10.h),
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: TextButton(
//                               onPressed: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             ForgotPassword()));
//                               },
//                               child: Text(
//                                 "Forgot Password?",
//                                 style: TextStyle(
//                                     fontSize: 16.sp, color: Colors.cyan[700]),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20.h),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Don't have an account?",
//                       style: TextStyle(fontSize: 16.sp),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => SignupPage()));
//                       },
//                       child: Text(
//                         "Sign up",
//                         style: TextStyle(
//                             fontSize: 17.sp, color: Colors.cyan[700]),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
