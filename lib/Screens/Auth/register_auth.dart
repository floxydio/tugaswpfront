import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tugaswpfront/Cubit/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterAuth extends StatefulWidget {
  const RegisterAuth({Key? key}) : super(key: key);

  @override
  State<RegisterAuth> createState() => _RegisterAuthState();
}

class _RegisterAuthState extends State<RegisterAuth> {
  final _formKey = GlobalKey<FormState>();

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    namaController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Form(
              key: _formKey,
              child: Column(
                  children: [
                    SizedBox(height: 30,),
                    Text("Hello, Please Sign Up Your Account First", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                    SizedBox(height: 70,),
                    TextFormField(
                      controller: namaController,
                      decoration: const InputDecoration(
                        labelText: 'Nama',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This Field is Required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This Field is Required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This Field is Required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: () {
                            context.read<AuthCubit>().registerUser(
                                context,
                                namaController.text.toString(),
                                emailController.text.toString(),
                                passwordController.text.toString());
                          },
                          child: const Text("Sign Up")),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ])),
        ),
      )),
    );
  }
}
