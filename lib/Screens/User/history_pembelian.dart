import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tugaswpfront/Cubit/product_cubit.dart';

class HistoryPembelian extends StatefulWidget {
  const HistoryPembelian({Key? key}) : super(key: key);

  @override
  State<HistoryPembelian> createState() => _HistoryPembelianState();
}

class _HistoryPembelianState extends State<HistoryPembelian> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: SafeArea(child:
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
                title: Text(state.data["data"][index]["nama_produk"]),
                trailing: Text(state.data["data"][index]["harga"]),
              );
            },
          );
        } else {
          return const Center(child: Text("Error"));
        }
      }))),
    );
  }
}
