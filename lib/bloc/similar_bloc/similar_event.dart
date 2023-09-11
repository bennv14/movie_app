part of 'similar_bloc.dart';

abstract class SimilarEvent extends Equatable {}

class InitialSimilarEvent extends SimilarEvent {
  @override
  List<Object?> get props => [];
}

class FetchDataSimilarEvent extends SimilarEvent {
  @override
  List<Object?> get props => [];
}
