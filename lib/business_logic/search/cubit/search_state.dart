part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState{}
class SearchSuccesState extends SearchState{}
class SearchErrorState extends SearchState{}