import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_hub/src/core/cloudinary_service.dart';
import 'package:pharmacy_hub/src/core/enums.dart';
import 'package:pharmacy_hub/src/features/cart/data/models/cart_model.dart';
import 'package:pharmacy_hub/src/features/cart/logic/cart_bloc.dart';
import 'package:pharmacy_hub/src/features/home/data/models/product_model.dart';

part 'add_prescription_event.dart';
part 'add_prescription_state.dart';

class AddPrescriptionBloc
    extends Bloc<AddPrescriptionEvent, AddPrescriptionState> {
  AddPrescriptionBloc() : super(const AddPrescriptionState()) {
    on<AddImageEvent>(_addImage);
  }

  FutureOr<void> _addImage(
      AddImageEvent event, Emitter<AddPrescriptionState> emit) async {
    emit(state.copyWith(uploadReqState: ReqState.loading));

    try {
      final String url = await CloudinaryService().uploadImage();

      if (url.isEmpty) {
        emit(state.copyWith(
          uploadReqState: ReqState.success,
        ));
        return;
      }
      log(url);
      int randomNumber = math.Random().nextInt(10000);
      log(randomNumber.toString());
      ProductModel model = ProductModel(
        id: randomNumber,
        quantity: 1,
        pictureUrl: url,
        name: 'Price will confirm on delivery',
        category: '0',
        price: 0,
        categoryId: 0,
        diseaseId: 0,
        activeIngredientId: 0,
        pharmacies: [],
      );
      log(model.toString());
      event.context
          .read<CartBloc>()
          .add(AddProductToCartLocal(CartItem.fromProduct(model)));
      emit(state.copyWith(
        uploadReqState: ReqState.success,
      ));
    } catch (e) {
      emit(state.copyWith(uploadReqState: ReqState.error));
    }
  }
}


