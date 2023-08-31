// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/favorites/favorites_Screen.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/compoment/components.dart';
import 'package:shop_app/shared/style/color.dart';

// ignore: use_key_in_widget_constructors
class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit, ShopSearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      //suffixPressed:(){},
                      controller: searchController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ('enter text to search');
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (String text) {
                        ShopSearchCubit.get(context).getSearch(text);
                      },
                      decoration: InputDecoration(
                        label: Text('Search'),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.search,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is ShopSearchLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),

                    if (state is ShopSearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildFavItem(
                              ShopSearchCubit.get(context)
                                  .model!
                                  .data!
                                  .data![index],
                              context,
                              isOldPrice: false),
                          separatorBuilder: (context, index) => myDiveder(),
                          itemCount: 16//ShopSearchCubit.get(context).model!.data!.data!.length,
                        ),
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
