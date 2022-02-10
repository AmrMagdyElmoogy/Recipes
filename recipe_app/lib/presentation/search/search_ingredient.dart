import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/app/functions.dart';
import 'package:recipe_app/domain/bloc/Cubits/search_cubit.dart';
import 'package:recipe_app/domain/bloc/States/app_states.dart';
import 'package:recipe_app/domain/models/models.dart';
import 'package:recipe_app/presentation/resources/string_manager.dart';
import 'package:recipe_app/presentation/resources/value_manager.dart';

class SearchIngredient extends StatefulWidget {
  const SearchIngredient({Key? key}) : super(key: key);

  @override
  _SearchIngredientState createState() => _SearchIngredientState();
}

class _SearchIngredientState extends State<SearchIngredient> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isTapped = false;
    return BlocConsumer<SearchCubit, IngredientSearchStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SearchCubit cubit = BlocProvider.of<SearchCubit>(context);
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  border: Border.all(
                    color: Colors.blue[200]!,
                    width: 3,
                  ),
                ),
                child: TextFormField(
                  style: Theme.of(context).textTheme.bodyText1,
                  controller: textEditingController,
                  cursorColor: Colors.black,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: StringsManager.inYourFridge,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: isTapped == true
                          ? const BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.blue,
                            )
                          : const BorderSide(
                              style: BorderStyle.none,
                            ),
                    ),
                  ),
                  onChanged: (text) {
                    if (text[text.length - 1] == ' ') {
                      cubit.search(text);
                    }
                  },
                  onTap: () {
                    setState(() {
                      isTapped = !isTapped;
                    });
                  },
                ),
              ),
              whiteSpaceHeight(10),
              state.items != null
                  ? Expanded(
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) => SearchItem(
                                ingredientsearch: state.items![index],
                              ),
                          separatorBuilder: (context, index) =>
                              whiteSpaceHeight(5),
                          itemCount: state.items!.length),
                    )
                  : Center(
                      child: noFavoritiesItem(context),
                    ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}

class SearchItem extends StatelessWidget {
  final IngredientSearch ingredientsearch;
  const SearchItem({Key? key, required this.ingredientsearch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(ingredientsearch.image),
                    fit: BoxFit.cover),
              ),
            ),
            whiteSpaceWidth(10),
            Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 100,
                        maxWidth: 150,
                        minHeight: 70,
                        maxHeight: 70,
                      ),
                      child: Text(
                        ingredientsearch.title,
                        style: Theme.of(context).textTheme.bodyText1,
                      )),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(ValuesManager.v50),
                      ),
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white),
                    ),
                    onPressed: () {
                      //Navigator.of(context).pushReplacementNamed(Routes.home);
                    },
                    child: Text(
                      'See more',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
