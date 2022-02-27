import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/app/functions.dart';
import 'package:recipe_app/domain/bloc/Cubits/search_cubit.dart';
import 'package:recipe_app/domain/bloc/States/app_states.dart';
import 'package:recipe_app/domain/models/models.dart';
import 'package:recipe_app/presentation/resources/routes_manager.dart';
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
          padding: const EdgeInsets.all(ValuesManager.v16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ValuesManager.v20),
                  border: Border.all(
                    color: Colors.blue[ValuesManager.v200.toInt()]!,
                    width: ValuesManager.v3,
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
                      borderRadius: BorderRadius.circular(ValuesManager.v20),
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
              whiteSpaceHeight(ValuesManager.v10),
              state.items != null
                  ? Expanded(
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) => SearchItem(
                                ingredientsearch: state.items![index],
                              ),
                          separatorBuilder: (context, index) =>
                              whiteSpaceHeight(ValuesManager.v5),
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
        color: Colors.grey[ValuesManager.v200.toInt()],
        borderRadius: BorderRadius.circular(ValuesManager.v20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(ValuesManager.v16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(Routes.ingredient, arguments: ingredientsearch);
              },
              child: Hero(
                tag: ingredientsearch.id,
                child: Container(
                  height: ValuesManager.v130,
                  width: ValuesManager.v130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ValuesManager.v20),
                    image: DecorationImage(
                        image: NetworkImage(ingredientsearch.image),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            whiteSpaceWidth(ValuesManager.v10),
            Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: ValuesManager.v100,
                        maxWidth: ValuesManager.v150,
                        minHeight: ValuesManager.v70,
                        maxHeight: ValuesManager.v70,
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
                      StringsManager.seeMore,
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
