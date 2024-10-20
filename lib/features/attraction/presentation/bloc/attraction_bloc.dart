import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/datasources/failure.dart';
import '../../domain/entities/attraction.dart';
import '../../domain/usecases/get_attractions.dart';

// Events
abstract class AttractionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAttractions extends AttractionEvent {}

// State
abstract class AttractionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AttractionInitial extends AttractionState {}
class AttractionLoading extends AttractionState {}
class AttractionLoaded extends AttractionState {
  final List<Attraction> attractions;
  AttractionLoaded(this.attractions);

  @override
  List<Object?> get props => [attractions];
}
class AttractionError extends AttractionState {
  final String message;
  AttractionError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class AttractionBloc extends Bloc<AttractionEvent, AttractionState> {
  final GetAttractions getAttractions;

  AttractionBloc(this.getAttractions) : super(AttractionInitial()) {
    on<FetchAttractions>((event, emit) async {
      emit(AttractionLoading());
      final result = await getAttractions();
      result.fold(
            (failure) {
          if (failure is ServerFailure) {
            emit(AttractionError('Server error: ${failure.message}'));
          } else if (failure is NetworkFailure) {
            emit(AttractionError('Network error: ${failure.message}'));
          }
        },
            (attractions) {
          emit(AttractionLoaded(attractions));
        },
      );
    });
  }
}

