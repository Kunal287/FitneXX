import 'package:bmi_app/Pages/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Signup extends StatefulWidget{
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController pass=TextEditingController();
  TextEditingController mob=TextEditingController();
  bool isSeen=false;
 void initState(){
   super.initState();
   Firebase.initializeApp();
 }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            crossAxisAlignment :CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Align(alignment:Alignment.topLeft,child: IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
              }, icon: Icon(CupertinoIcons.arrow_left,color: Colors.white,size: 30,))),
              SizedBox(
                height: 20,
              ),
              Text("Sign Up",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
              SizedBox(
                height: 20,
              ),
              Text("PLease type your information below",style: TextStyle(color: Colors.white,fontSize: 15),),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left:16,right: 16,bottom: 8),
                child: TextField(decoration: InputDecoration(fillColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Name',
                    suffixIcon: Icon(CupertinoIcons.person,color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(
                          width: 3, color: Color.alphaBlend(Colors.white, Colors.black)), //<-- SEE HERE
                    )),style: TextStyle(color: Colors.white),controller: name,),
              ),
              Padding(
                padding: const EdgeInsets.only(left:16,right: 16,top:4,bottom: 8),
                child: TextField(decoration: InputDecoration(fillColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Email',
                    suffixIcon: Icon(CupertinoIcons.mail,color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(
                          width: 3, color: Color.alphaBlend(Colors.white, Colors.black)), //<-- SEE HERE
                    )),style: TextStyle(color: Colors.white),controller: email,),
              ),
              Padding(
                padding: const EdgeInsets.only(left:16,right: 16,top:4,bottom: 8),
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

                    },icon: Icon(isSeen==true?CupertinoIcons.eye:CupertinoIcons.eye_slash,color: Colors.white,),),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(
                          width: 3, color: Color.alphaBlend(Colors.white, Colors.black)), //<-- SEE HERE
                    )),style: TextStyle(color: Colors.white), controller: pass,  obscureText:isSeen==true?false:true,obscuringCharacter: "*"),
              ),
              Padding(
                padding: const EdgeInsets.only(left:16,right: 16,top:4,bottom: 8),
                child: TextField(decoration: InputDecoration(fillColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Phone',
                    suffixIcon: Icon(CupertinoIcons.phone,color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(
                          width: 3, color: Color.alphaBlend(Colors.white, Colors.black)), //<-- SEE HERE
                    )),style: TextStyle(color: Colors.white),controller: mob,keyboardType: TextInputType.number,),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap:(){

                    try {
                      print("in try");
                      if(name.text!="" && mob.text!="") {
                      FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: email.text,
                          password: pass.text,).then((value)  async{
                            SharedPreferences prefs=await SharedPreferences.getInstance();
                            prefs.setString('${FirebaseAuth.instance.currentUser!.email}', mob.text.toString());
                            Navigator.push(context, MaterialPageRoute(
                            builder: (context) => LoginPage()));
                        //showLoginDialog(context);
                        Fluttertoast.showToast(
                          msg: "Signup Successful",
                        );

                        print("Logged in");
                        FirebaseAuth.instance.currentUser!.updateDisplayName(name.text);
                        try{
                          FirebaseAuth.instance.currentUser!.updatePhoneNumber(mob as PhoneAuthCredential);
                        }catch(e){
                          print(e);
                        }

                      }).onError((error, stackTrace) {
                        Fluttertoast.showToast(
                          msg: "Please Enter correct details",
                        );
                        print("error is $error");

                      });
                    }else{
                        Fluttertoast.showToast(
                          msg: "Please Enter correct details",
                        );
                      }
                  }catch (e) {
                      Fluttertoast.showToast(
                        msg: "Please check your internet",
                      );
                    }
                },
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                child: Container(
                  child: Center(child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
                  height: 50,
                  width: 0.8*MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 0, 0, 1),
                      borderRadius: BorderRadius.all(Radius.circular(16.0))
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));},
                  child: Text("Already have an Account? Sign In",style: TextStyle(color: Colors.white,fontSize: 17),))
            ],
          ),
        ),
      ),
    );
  }

}