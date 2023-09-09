part of 'reviews_bloc.dart';

abstract class ReviewsEvent extends Equatable {}

class Initial extends ReviewsEvent {
  @override
  List<Object?> get props => [];
}

class FetchData extends ReviewsEvent {
  @override
  List<Object?> get props => [];
}
