import 'dart:io';
import 'package:cubit_example/core/model/cats_repository.dart';
import 'package:cubit_example/screens/bloc/home/cats_cubit_page.dart';
import 'package:cubit_example/screens/bloc/home/cats_state_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatsBlocView extends StatefulWidget {
  const CatsBlocView({Key? key}) : super(key: key);

  @override
  _CatsBlocViewState createState() => _CatsBlocViewState();
}

class _CatsBlocViewState extends State<CatsBlocView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatsCubit(
        SampleCatsRepository(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Cats Bloc Home Page",
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<CatsCubit, CatsState>(
                listener: (context, state) {
                  if (state is CatsError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.errorMessage.toString(),
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is CatsInitial) {
                    return Center(
                      child: Platform.isAndroid
                          ? const CircularProgressIndicator()
                          : const CupertinoActivityIndicator(),
                    );
                  } else if (state is CatsLoading) {
                    return Center(
                      child: Platform.isAndroid
                          ? const CircularProgressIndicator()
                          : const CupertinoActivityIndicator(),
                    );
                  } else if (state is CatsCompledet) {
                    return listCiewBuider(state);
                  } else {
                    final error = state as CatsError;
                    return Center(
                      child: Text(error.errorMessage),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView listCiewBuider(CatsCompledet state) {
    return ListView.builder(
      itemCount: state.response.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 10.0,
          ),
          child: Container(
            alignment: Alignment.topCenter,
            height: 300.0,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.indigo,
                  Colors.pink,
                ],
              ),
              image: DecorationImage(
                image: NetworkImage(
                  state.response[index].imageUrl.toString(),
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 5),
                  blurRadius: 10.0,
                  color: Colors.grey.shade800,
                )
              ],
            ),
            child: Text(
              state.response[index].description.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
