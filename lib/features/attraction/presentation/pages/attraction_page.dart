import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../widgets/attraction_item.dart';
import '../../../../widgets/error_display.dart';
import '../../../../widgets/no_data_display.dart';
import '../../domain/usecases/get_attractions.dart';
import '../bloc/attraction_bloc.dart';

class AttractionPage extends StatelessWidget {
  const AttractionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attractions')),
      body: BlocProvider(
        create: (context) => AttractionBloc(GetIt.I<GetAttractions>())..add(FetchAttractions()),
        child: BlocBuilder<AttractionBloc, AttractionState>(
          builder: (context, state) {
            if (state is AttractionLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AttractionLoaded) {
              return ListView.builder(
                itemCount: state.attractions.length,
                itemBuilder: (context, index) {
                  final attraction = state.attractions[index];
                  if (attraction.isVisible) {
                    return AttractionItem(attraction: attraction);
                  }
                  return const SizedBox.shrink();
                },
              );
            } else if (state is AttractionError) {
              return ErrorDisplay(message: state.message);
            } else {
              return const NoDataDisplay();
            }
          },
        ),
      ),
    );
  }
}


