import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugaswpfront/Cubit/product_cubit.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Timer? _timer;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: () {}, icon: const Icon(Icons.notifications_none)),
          ),
          BlocBuilder<ProductCubit, ProductEvent>(builder: (context, state) {
            if (state is LoadingProduct) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SuccessLoadProduct) {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    return ListTile(
                        title: Text(state.data["data"][index]["name"]),
                        trailing: ElevatedButton(
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              context.read<ProductCubit>().createProduct(
                                  state.data["data"][index]["id"],
                                  prefs.getString("id"));
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    _timer =
                                        Timer(const Duration(seconds: 3), () {
                                      Navigator.of(context).pop();
                                    });

                                    return const AlertDialog(
                                      content: Text("Berhasil Pesan"),
                                    );
                                  });
                            },
                            child: const Text("Pesan")),
                        subtitle:
                            Text(state.data["data"][index]["description"]));
                  });
            } else {
              return const SizedBox();
            }
          }),
        ],
      )),
    ));
  }
}
