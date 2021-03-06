import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugaswpfront/Screens/Admin/admin_screen.dart';
import 'package:tugaswpfront/Screens/Auth/login_auth.dart';
import 'package:tugaswpfront/Screens/User/user_screen.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class SuccessAuth extends AuthState {
  final String message;
  const SuccessAuth(this.message);
}

class FailedAuth extends AuthState {
  final String message;
  const FailedAuth(this.message);
}

class SuccessRegister extends AuthState {
  final String message;
  const SuccessRegister(this.message);
}

class FailedRegister extends AuthState {
  final String message;
  const FailedRegister(this.message);
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  var baseLink = "http://192.168.8.26:2000";

  void loginUser(BuildContext context, String email, String password) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await Dio().post(baseLink + "/login",
          data: FormData.fromMap({
            "email": email,
            "password": password,
          }),
          options: Options(
              followRedirects: true,
              validateStatus: (status) {
                return status! < 500;
              }));

      print(response.data);
      if (response.statusCode == 200) {
        emit(SuccessAuth(response.data["message"]));
        if (response.data["role"] == 0) {
          prefs.setString("token", "sc1#1");
          prefs.setInt("id", response.data["data"]["id"]);
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const UserPage()));
        } else {
          prefs.setString("token", "sc1#1");
          prefs.setInt("id", response.data["data"]["id"]);
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const UserPage()));
        }
      } else if (response.statusCode != 200) {
        emit(FailedAuth(response.data["message"]));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void registerUser(
      BuildContext context, String nama, String email, String password) async {
    print(nama);
    print(email);
    print(password);
    try {
      var response = await Dio().post(baseLink + "/register",
          data: FormData.fromMap({
            "nama": nama,
            "email": email,
            "password": password,
          }),
          options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      if (response.statusCode == 200) {
        emit(SuccessRegister(response.data["message"]));
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const LoginAuth()));
      } else if (response.statusCode != 200) {
        emit(FailedRegister(response.data["message"]));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
