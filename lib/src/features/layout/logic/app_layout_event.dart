part of 'app_layout_bloc.dart';

sealed class AppLayoutEvent extends Equatable {
  const AppLayoutEvent();

  @override
  List<Object> get props => [];
}

final class AnimatePageTo extends AppLayoutEvent{
  int pageIndex;
  AnimatePageTo(this.pageIndex);
}





