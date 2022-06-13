import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugaswpfront/Cubit/product_cubit.dart';

class HistoryPembelian extends StatefulWidget {
  const HistoryPembelian({Key? key}) : super(key: key);

  @override
  State<HistoryPembelian> createState() => _HistoryPembelianState();
}

class _HistoryPembelianState extends State<HistoryPembelian> {
  void getIdUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    context.read<ProductCubit>().historyProductByUser(prefs.getInt("id"));
  }

  @override
  Widget build(BuildContext context) {
    getIdUser();
    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const Text(
            "History Pembelian",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 40,
          ),
          BlocBuilder<ProductCubit, ProductEvent>(builder: (context, state) {
            if (state is LoadingHistoryProduct) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SuccessHistoryProduct) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: state.data["data"].length,
                itemBuilder: (ctx, index) {
                  return ListTile(
                    title: Text(state.data["data"][index]["nama"]),
                    trailing:
                        Text(state.data["data"][index]["harga"].toString()),
                  );
                },
              );
            } else {
              return const Center(child: Text("Error"));
            }
          }),
        ],
      ))),
    );
  }
}
