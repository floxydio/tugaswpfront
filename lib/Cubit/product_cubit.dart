import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductEvent {}

class LoadingProduct extends ProductEvent {}

class LoadingHistoryProduct extends ProductEvent {}

class SuccessHistoryProduct extends ProductEvent {
  final Map<String, dynamic> data;

  @override
  const SuccessHistoryProduct(this.data);
}

class SuccessLoadProduct extends ProductEvent {
  final Map<String, dynamic> data;

  @override
  const SuccessLoadProduct(this.data);
}

class ProductCubit extends Cubit<ProductEvent> {
  ProductCubit() : super(ProductInitial());

  void loadProduct() async {
    emit(LoadingProduct());
    try {
      var response = await Dio().get("/products",
          options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      if (response.statusCode == 200) {
        emit(SuccessLoadProduct(response.data));
      }
    } catch (e) {
      print(e);
    }
  }

  void createProduct(productId, userId) async {
    var response = await Dio().post("/product-history",
        data: FormData.fromMap({"user_id": userId, "product_id": productId}),
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }));
    print(response.data);
  }

  void historyProductByUser(id) async {
    emit(LoadingHistoryProduct());
    try {
      var response = await Dio().get("/product-history/$id");
      if (response.statusCode == 200) {
        emit(SuccessHistoryProduct(response.data));
      }
    } catch (e) {
      print(e);
    }
  }
}
