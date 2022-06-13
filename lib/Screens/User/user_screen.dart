import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugaswpfront/Cubit/product_cubit.dart';
import 'package:tugaswpfront/Screens/User/history_pembelian.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ProductCubit>().loadProduct();

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const HistoryPembelian()));
                },
                icon: const Icon(Icons.notifications_none)),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Product List",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<ProductCubit, ProductEvent>(builder: (context, state) {
            if (state is LoadingProduct) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SuccessLoadProduct) {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: state.data["data"].length,
                  itemBuilder: (ctx, index) {
                    return Card(
                      child: ListTile(
                        title: Text(state.data["data"][index]["nama_produk"]),
                        trailing: ElevatedButton(
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              context.read<ProductCubit>().createProduct(
                                  state.data["data"][index]["id"],
                                  prefs.getInt("id"));
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
                      ),
                    );
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
