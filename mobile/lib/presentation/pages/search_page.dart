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
      child: ListView(
        padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
        children: <Widget>[
          TitleBar(userName: "Jamie"),
          listSpacer,
          PasswordBox(),
          SizedBox(height: 15),
          ChangeableSearchOptions()
        ],
      ),
    );
  }
}

class PasswordBox extends StatelessWidget {
  const PasswordBox({
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Container(
        height: 30,
        // color: Colors.black,
        child: BlocProvider(
          create: (context) => ChangeableFilterCubit(MockFilterGetter()),
          child: BlocBuilder<ChangeableFilterCubit, ChangeableFilterState>(
            builder: (context, state) {
              return Column(
                children: [
                  Container(
                    height: 30,
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(width: 10);
                      },
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return selectableFilter("Live shows $index");
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget selectableFilter(String text) {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(text),
        ));
  }
}
