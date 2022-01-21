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
        return Card(
          child: Text(
            state.response[index].imageUrl.toString(),
          ),
        );
      },
    );
  }
}
