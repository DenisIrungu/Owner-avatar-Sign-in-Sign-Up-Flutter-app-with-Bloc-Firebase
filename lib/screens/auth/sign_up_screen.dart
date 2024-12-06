import 'package:authblocproject/app_view.dart';
import 'package:authblocproject/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:authblocproject/screens/auth/components/my_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  IconData iconPassWord = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  bool signUpRequest = false;

  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsSpecialChar = false;
  bool containsNumber = false;
  bool contain8Length = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          setState(() {
            signUpRequest = false;
          });
          //Navigator.pop(context);
        } else if (state is SignUpLoading) {
          setState(() {
            signUpRequest = true;
          });
        } else if (state is SignUpFailure) {
          setState(() {
            return;
          });
        }
      },
      child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(CupertinoIcons.mail_solid),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please enter your emai..l';
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                          .hasMatch(val)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: obscurePassword,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(CupertinoIcons.lock_fill),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please set your Password';
                      } else if (!RegExp(
                              r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
                          .hasMatch(val)) {
                        return 'Please enter a valid PassWord';
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                            if (obscurePassword) {
                              iconPassWord = CupertinoIcons.eye_fill;
                            } else {
                              iconPassWord = CupertinoIcons.eye_slash_fill;
                            }
                          });
                        },
                        icon: Icon(iconPassWord)),
                    onChanged: (val) {
                      if (val!.contains(RegExp(r'[A-Z]'))) {
                        setState(() {
                          containsUpperCase = true;
                        });
                      } else {
                        setState(() {
                          containsUpperCase = false;
                        });
                      }
                      if (val.contains(RegExp(r'[a-z]'))) {
                        setState(() {
                          containsLowerCase = true;
                        });
                      } else {
                        setState(() {
                          containsLowerCase = false;
                        });
                      }
                      if (val.contains(RegExp(r'[0-9]'))) {
                        setState(() {
                          containsNumber = true;
                        });
                      } else {
                        setState(() {
                          containsNumber = false;
                        });
                      }
                      if (val.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                        containsSpecialChar = true;
                      } else {
                        containsSpecialChar = false;
                      }
                      if (val.length >= 8) {
                        setState(() {
                          contain8Length = true;
                        });
                      } else {
                        contain8Length = false;
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '● 1 UpperCase',
                          style: TextStyle(
                              color: containsUpperCase
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.onBackground),
                        ),
                        Text(
                          '● 1 LowerCase',
                          style: TextStyle(
                              color: containsLowerCase
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.onBackground),
                        ),
                        Text(
                          '● 1 Number',
                          style: TextStyle(
                              color: containsNumber
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.onBackground),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '● 1 Special Character',
                          style: TextStyle(
                              color: containsSpecialChar
                                  ?
                                  // ignore: deprecated_member_use
                                  Colors.green
                                  : Theme.of(context).colorScheme.onBackground),
                        ),
                        Text(
                          '● 8 Character',
                          style: TextStyle(
                              color: contain8Length
                                  ?
                                  // ignore: deprecated_member_use
                                  Colors.green
                                  : Theme.of(context).colorScheme.onBackground),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: MyTextField(
                    controller: nameController,
                    hintText: 'Name',
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    prefixIcon: const Icon(CupertinoIcons.person_2_fill),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please enter your name';
                      } else if (val.length > 30) {
                        return 'Name too long';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                !signUpRequest
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                MyUser myUser = MyUser.empty;
                                myUser = myUser.copyWith(
                                  email: emailController.text,
                                  name: nameController.text,
                                );
                                setState(() {
                                  context.read<SignUpBloc>().add(SignUpRequired(
                                      myUser, passwordController.text));
                                });
                              }
                            },
                            style: TextButton.styleFrom(
                                elevation: 3.0,
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            )),
                      )
                    : const CircularProgressIndicator()
              ],
            ),
          )),
    );
  }
}
