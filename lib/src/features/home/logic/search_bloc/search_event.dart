part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchForEvent extends SearchEvent {
  final String text;

  const SearchForEvent({
    this.text = '',
  });
}

class FetchMoreDataEvent extends SearchEvent {
  final String text;

  const FetchMoreDataEvent({required this.text});
}
