part of 'pagination_bloc.dart';

abstract class PaginationEvent extends Equatable {
  const PaginationEvent();

  @override
  List<Object> get props => [];
}

class GetProductsEvent extends PaginationEvent {

  final String categoryId ;

   const GetProductsEvent(this.categoryId);
}
