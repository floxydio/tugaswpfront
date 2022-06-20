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

    context.read<ProductCubit>().loadProduct();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
  }

  var baseLink = "http://192.168.43.6:2000";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          height: 100,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text("BuahPedia",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const HistoryPembelian()));
                },
                icon: const Icon(Icons.notifications_none)),
          ]),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            children: [
              BlocBuilder<ProductCubit, ProductEvent>(
                  builder: (context, state) {
                if (state is LoadingProduct) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SuccessLoadProduct) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Mau Cari apa hari ini....",
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.search)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          const Text("Rekomendasi Buah",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const ScrollPhysics(),
                              child: Row(
                                children: [
                                  for (int index = 0; index < 3; index++)
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            baseLink +
                                                "/products/" +
                                                state.data["data"][index]
                                                    ["image"],
                                            width: 150,
                                            height: 120,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              state.data["data"][index]
                                                  ["nama_produk"],
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600)),
                                          Text(
                                              state.data["data"][index]["harga"]
                                                  .toString(),
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey)),
                                          SizedBox(
                                            width: 150,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.orange),
                                                onPressed: () {},
                                                child: const Text("Pesan")),
                                          )
                                        ],
                                      ),
                                    ),
                                ],
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          const Text("Buah Termurah",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const ScrollPhysics(),
                            child: Row(
                              children: [
                                for (int index = 0; index < 3; index++)
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          baseLink +
                                              "/products/" +
                                              state.data["data"][index]
                                                  ["image"],
                                          width: 150,
                                          height: 120,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            state.data["data"][index]
                                                ["nama_produk"],
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600)),
                                        Text(
                                            state.data["data"][index]["harga"]
                                                .toString(),
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey)),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.orange),
                                              onPressed: () {},
                                              child: const Text("Pesan")),
                                        )
                                      ],
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ]),
                  );
                } else {
                  return const SizedBox();
                }
              }),
            ],
          )),
        ));
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;
  final double height;

  CustomAppBar({
    required this.child,
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: Colors.orange,
      alignment: Alignment.center,
      child: child,
    );
  }
}
