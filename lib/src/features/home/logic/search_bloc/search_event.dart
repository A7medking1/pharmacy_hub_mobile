part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchForEvent extends SearchEvent{
  String? text;
  bool getMore;
  SearchForEvent([this.text,this.getMore = false]);
}
