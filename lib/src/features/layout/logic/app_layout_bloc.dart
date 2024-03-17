import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'app_layout_event.dart';
part 'app_layout_state.dart';

class AppLayoutBloc extends Bloc<AppLayoutEvent, AppLayoutState> {
  AppLayoutBloc() : super(AppLayoutInitial()) {
    on<AnimatePageTo>(_animatePageTo);
  }

  CarouselController carouselController = CarouselController();
  int currentTap = 0;

  FutureOr<void> _animatePageTo(AnimatePageTo event, Emitter<AppLayoutState> emit) async {
    carouselController.animateToPage(event.pageIndex, duration: const Duration(milliseconds: 200), curve: Curves.fastLinearToSlowEaseIn);
    currentTap = event.pageIndex;
    emit(TapChangeState());
  }

  void onTapChange(int pageIndex,CarouselPageChangedReason _) {
    currentTap = pageIndex;
    emit(TapChangeState());
  }
}
