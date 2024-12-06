import 'package:authblocproject/app_view.dart';
import 'package:authblocproject/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:authblocproject/screens/auth/components/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool signInRequest = false;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  String? errorMsg;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
       // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: MyTextField(
                  controller: emailController, 
                  hintText: 'Email', 
                  obscureText: false, 
                  keyboardType: TextInputType.emailAddress, 
                  prefixIcon: const Icon(CupertinoIcons.mail_solid), 
                  validator: (val){
                    if(val!.isEmpty){
                      return 'Please fill in this field';
                    } else if(!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(val)){
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },  
                  errorMsg: errorMsg,
                  ),
              ),
            ),
          const SizedBox(height: 20,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: MyTextField(
                  controller: passwordController, 
                  hintText: 'Password', 
                  obscureText: obscurePassword, 
                  keyboardType: TextInputType.visiblePassword, 
                  prefixIcon: const Icon(CupertinoIcons.lock_fill), 
                  validator: (val){
                    if(val!.isEmpty){
                      return 'Please fill in this field';
                    } else if(!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$').hasMatch(val)){
                      return 'Please enter a valid email address';
                    }
                    return null;
                  }, 
                  suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        obscurePassword= !obscurePassword;
                        if(obscurePassword){
                          iconPassword = CupertinoIcons.eye_fill;
                        }else{
                          iconPassword = CupertinoIcons.eye_slash_fill;
                        }
                      });

                    }, icon: Icon(iconPassword)), 
                  errorMsg: errorMsg,
                  ),
              ),
          ),
          const SizedBox(height: 20,),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,),
          !signInRequest ? 
          SizedBox(
            width: MediaQuery.of(context).size.width *0.5,
            child: TextButton(
              onPressed: (){
                if (_formKey.currentState!.validate()){
                  context.read<SignInBloc>().add(SignInRequired(
                    emailController.text, 
                    passwordController.text));

                }
              },
              style: TextButton.styleFrom(
                elevation: 3.0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
                )
              ), 
              child:const Padding(
                padding: EdgeInsets.symmetric( horizontal: 20, vertical: 10),
                child: Text(
                  textAlign: TextAlign.center,
                  'Sign In', 
                  style: TextStyle( 
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                    ),
              )
              ),
          )
          :const CircularProgressIndicator()
        ],
      ));
  }
}