import 'package:bloc_listener/core/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, required this.title});
  final CounterCubit cubit = CounterCubit();
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Listener'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocListener<CounterCubit, int>(
            listenWhen: (previous, current) {
              if (current >= 5) {
                return true;
              } else {
                return false;
              }
            },
            bloc: cubit,
            listener: ((context, state) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 2),
                  content: Text('showing snackbar $state'),
                ),
              );
            }),
            child: BlocBuilder<CounterCubit, int>(
              bloc: cubit,
              buildWhen: (previous, current) {
                if (current >= 5) {
                  return true;
                } else {
                  return false;
                }
              },
              builder: ((context, state) {
                return Center(
                  child: Text(
                    '$state',
                    style: const TextStyle(fontSize: 50, color: Colors.amber),
                  ),
                );
              }),
            ),
          ),
          // StreamBuilder(
          //   stream: cubit.stream,
          //   initialData: cubit.initialData,
          //   builder: ((context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Center(
          //         child: Text(
          //           'Loading....',
          //           style: TextStyle(fontSize: 50),
          //         ),
          //       );
          //     } else {
          //       return Center(
          //         child: Text(
          //           '${cubit.state}',
          //           style: const TextStyle(fontSize: 50),
          //         ),
          //       );
          //     }
          //   }),
          // ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () => cubit.decrement(),
                padding: const EdgeInsets.all(0.0),
                icon: const Icon(
                  Icons.remove,
                  size: 45,
                  color: Colors.amber,
                ),
              ),
              IconButton(
                onPressed: () => cubit.increment(),
                padding: const EdgeInsets.all(0.0),
                icon: const Icon(
                  Icons.add,
                  size: 45,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
