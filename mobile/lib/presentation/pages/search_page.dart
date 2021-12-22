import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/cubit/changeable_filter/changeable_filter_cubit.dart';
import 'package:vibration/presentation/widgets/carousel.dart';
import 'package:vibration/presentation/widgets/mix_tile.dart';
import 'package:vibration/presentation/widgets/title_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vibration/theme.dart';

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
          color: PresentationUtils.backgroundGrey,
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
        // color: Colors.black,
        child: BlocProvider(
          create: (context) => ChangeableFilterCubit(MockFilterGetter()),
          child: BlocBuilder<ChangeableFilterCubit, ChangeableFilterState>(
            builder: (context, state) {
              if (state is ChangeableFilterChanged) return PopulatedFilter(state);
              return Text("Loading");
            },
          ),
        ),
      ),
    );
  }
}

class PopulatedFilter extends StatelessWidget {
  const PopulatedFilter(this.state, {Key? key}) : super(key: key);

  final ChangeableFilterChanged state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 30,
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: 10);
            },
            itemCount: state.names.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return selectableFilter(state.names[index]);
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(color: PresentationUtils.backgroundGrey),
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          height: PresentationUtils.getHeight(context) * 0.3,
          width: PresentationUtils.getWidth(context),
          child: Container(
            child: MixTile(state.mixes.getRandom()),
            margin: EdgeInsets.all(5),
          ),
        )
      ],
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
