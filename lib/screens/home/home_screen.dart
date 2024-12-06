import 'package:authblocproject/app_view.dart';
import 'package:authblocproject/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          IconButton(onPressed: (){
            context.read<SignInBloc>().add(SignOutRequired());

          }, icon: Icon(Icons.logout))
        ],
      ),
      backgroundColor: Colors.grey,
      body: Center(
        child: Container(
          child: const Text('My Home Screen', style: TextStyle(color: Colors.black),),
        ),
      )
    );
  }
}