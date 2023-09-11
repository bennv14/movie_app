part of 'recommendations_bloc.dart';

abstract class RecommendationsEvent extends Equatable {}

class InitialRecommendationsEvent extends RecommendationsEvent {
  @override
  List<Object?> get props => [];
}

class FetchDataRecommendationsEvent extends RecommendationsEvent {
  @override
  List<Object?> get props => [];
}
