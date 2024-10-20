import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
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
                    return ListTile(
                      leading: Image.network(attraction.imageUrl),
                      title: Text(attraction.name),
                      subtitle: Text(attraction.address),
                    );
                  }

                  return const SizedBox.shrink();
                },
              );
            } else if (state is AttractionError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('No data'));
            }
          },
        ),
      ),
    );
  }
}


