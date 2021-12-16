import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/cubit/changeable_filter/changeable_filter_cubit.dart';
import 'package:vibration/presentation/widgets/title_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    final Container listSpacer = Container(
      height: screenHeight * 0.02,
    );

    return Material(
      child: ChangeableSearchOptions(),
      // child: Column(
      //   children: [
      //     ListView(
      //       padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
      //       children: <Widget>[
      //         TitleBar(userName: "Jamie"),
      //         listSpacer,
      //         SearchBox(),
      //         SizedBox(height: 15),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            icon: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Icon(
                Icons.search_sharp,
                color: Colors.grey,
              ),
            ),
            border: InputBorder.none,
            hintText: 'search',
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}

class ChangeableSearchOptions extends StatelessWidget {
  const ChangeableSearchOptions({Key? key}) : super(key: key);

  void _filterPressed(String name, BuildContext context) {
    context.read<ChangeableFilterCubit>().filterChanged(name);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangeableFilterCubit(MockFilterGetter()),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Container(
          width: 30,
          height: 300,
          child: ListView(
            children: [
              ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 10);
                },
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return selectableFilter(
                    "Live shows $index",
                    context,
                    _filterPressed,
                  );
                },
              ),
              BlocBuilder<ChangeableFilterCubit, ChangeableFilterState>(builder: (
                context,
                state,
              ) {
                return ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 1,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 1,
                      );
                    },
                    itemCount: 10);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectableFilter(
    String text,
    BuildContext context,
    Function(String, BuildContext) onPressed,
  ) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(text),
        ),
      ),
      onTap: () {
        onPressed(text, context);
      },
    );
  }
}
