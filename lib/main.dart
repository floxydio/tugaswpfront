import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tugaswpfront/Cubit/cekauth_cubit.dart';
import 'package:tugaswpfront/Cubit/login_cubit.dart';
import 'package:tugaswpfront/Cubit/product_cubit.dart';

void main() => runApp(MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ProductCubit()),
          BlocProvider(create: (_) => TokenCubit()),
          BlocProvider(create: (_) => AuthCubit())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: BoardingScreen(),
        )));

class BoardingScreen extends StatefulWidget {
  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  Timer? cekLogin;

  @override
  void initState() {
    super.initState();
    cekLogin = Timer.periodic(const Duration(seconds: 1), (timer) {
      context.read<TokenCubit>().checkLoginIfAvailable(context);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cekLogin?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
