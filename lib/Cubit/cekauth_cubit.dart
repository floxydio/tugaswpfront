import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugaswpfront/Screens/User/user_screen.dart';

abstract class TokenAuth extends Equatable {
  const TokenAuth();

  @override
  List<Object> get props => [];
}

class TokenInitial extends TokenAuth {}

class TokenCubit extends Cubit<TokenAuth> {
  TokenCubit() : super(TokenInitial());

  void checkLoginIfAvailable(BuildContext ctx) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString("token") != null) {
      Navigator.pushReplacement(
          ctx, MaterialPageRoute(builder: (_) => const UserPage()));
    } else {
      Scaffold.of(ctx)
          .showBottomSheet((context) => const Text("No Token Available"));
    }
  }
}
