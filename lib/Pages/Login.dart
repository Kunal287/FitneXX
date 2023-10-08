import 'package:bmi_app/Pages/Dashboard.dart';
import 'package:bmi_app/Providers/AuthenticationProvider.dart';
import 'package:bmi_app/Pages/Signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginPage extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }

}

class _LoginPageState extends State<LoginPage>{


  TextEditingController email=TextEditingController();
  TextEditingController pass=TextEditingController();
  late AuthenticationProvider provider;
  bool isSeen=false;
  void initState(){
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider=Provider.of<AuthenticationProvider>(context,listen: false);
    });
  }

  @override
  Widget build(BuildContext context) {

     return Scaffold(
       backgroundColor:Colors.black,
       body:SingleChildScrollView(

         child: Column(
           children: [
             SizedBox(
               height: 50,
             ),
             Text("Welcome",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),),
             SizedBox(
               height: 25,
             ),
             Text("Sign in to continue",style:TextStyle(fontSize: 20,color: Colors.white),),
             SizedBox(
               height: 50,
             ),
             Padding(
               padding: const EdgeInsets.all(16.0),
               child: TextField(decoration: InputDecoration(fillColor: Colors.white,
                   labelStyle: TextStyle(color: Colors.white),
                   labelText: 'Enter Email',
                   suffixIcon: Icon(Icons.mail,color: Colors.white),
                   enabledBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.all(Radius.circular(8.0)),
                     borderSide: BorderSide(
                         width: 3, color: Color.alphaBlend(Colors.white, Colors.black)), //<-- SEE HERE
                   )),style: TextStyle(color: Colors.white),controller:email),
             ),
             SizedBox(
               height: 10,
             ),
             Padding(
               padding: const EdgeInsets.all(16.0),
               child: TextField(decoration: InputDecoration(fillColor: Colors.white,
                   labelStyle: TextStyle(color: Colors.white),
                   labelText: 'Enter Password',suffixIcon: IconButton(onPressed: (){
                     if(isSeen!=true){
                       setState(() {
                         isSeen=true;
                       });

                     }else{
                       setState(() {
                         isSeen=false;
                       });
                     }

                   },icon: Icon(isSeen==true?CupertinoIcons.eye_fill:CupertinoIcons.eye_slash_fill,color: Colors.white,),),
                   enabledBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.all(Radius.circular(8.0)),
                     borderSide: BorderSide(
                         width: 3, color: Color.alphaBlend(Colors.white, Colors.black)), //<-- SEE HERE
                   )),style: TextStyle(color: Colors.white),controller:pass,   obscureText:isSeen==true?false:true,obscuringCharacter: "*"),
             ),
             Align(alignment:Alignment.centerRight,child:Padding(padding:EdgeInsets.only(right: 16.0),child: InkWell(onTap:(){print("ok");},child: Text("Forgot Password?",style:TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)))),
             SizedBox(
               height: 30,
             ),
            // ElevatedButton(onPressed: (){}, child: Text('Sign In'),style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Color.fromRGBO(255, 0, 0, 1)),elevation: MaterialStateProperty.resolveWith((states) => 8.0),fixedSize: MaterialStateProperty.resolveWith((states) => Size(0.8*MediaQuery.of(context).size.width, 50),))),
             InkWell(
               onTap:(){

                 try{
                   print("in try");
                   FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: pass.text).then((value){
                     print("in then");
                     Navigator.push(context, MaterialPageRoute(builder: (
                         context) => Dashboard()));
                     Fluttertoast.showToast(
                       msg: "Login Successful",
                     );
                     print("Logged in");

                     provider.setCredentials(email.text);
                   }).onError((error, stackTrace){print("error is $error");
                   Fluttertoast.showToast(
                     msg: "Please Enter correct email and password",
                   );
                   });
                   Navigator.push(context, MaterialPageRoute(builder: (
                       context) => Dashboard()));
                 }catch(e){
                   Fluttertoast.showToast(
                     msg: "Please check your internet",
                   );
                 }

                 },
               borderRadius: BorderRadius.all(Radius.circular(8.0)),
               child: Container(
                 child: Center(child: Text("Sign in",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
                 height: 50,
                 width: 0.8*MediaQuery.of(context).size.width,
                 decoration: BoxDecoration(
                   color: Color.fromRGBO(255, 0, 0, 1),
                   borderRadius: BorderRadius.all(Radius.circular(16.0))
                 ),
               ),
             ),
             SizedBox(
               height: 30,
             ),
             SizedBox(
               height: 50,
             ),
             InkWell(
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
                 },
                 child: Text("Don't have an account? Sign Up",style: TextStyle(fontSize: 20,color: Colors.white),)),
             
           ],
         ),
       ) ,

     );
  }

  void setCredentials() async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    pref.setString('Email',email.text.trim() );
  }

}