import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_admin_dashboard/super_admin_dashboard/shared/components/components.dart';
import '../../project_shared/constants.dart';
import '../../project_shared/network/dio.dart';
import '../admin_subcategory/admin_sub_categories.dart';
import '../category_model.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class AdminCategoriesScreen extends StatelessWidget {
  const AdminCategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CategoryCubit()..getCategories(),
        child: BlocConsumer<CategoryCubit, CategoryStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetCategorySuccessState) {
              return Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 100,
                          child: Text(
                            '     Total Categories : ${CategoryCubit.get(context).categoriesModel.data!.length}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 80,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                                flex: 1,
                                child: Container(
                                    alignment: Alignment.center,
                                    width: 130,
                                    child: const Text(
                                      '#ID',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ))),
                            Flexible(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 130,
                                  child: const Text(
                                    'Image',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )),
                            Flexible(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 130,
                                  child: const Text(
                                    'Category Name',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )),
                            Flexible(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 180,
                                  child: const Text(
                                    'SubCategories Number',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )),
                            Flexible(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 130,
                                  child: const Text(
                                    'Actions',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )),
                            SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    if (CategoryCubit.get(context)
                            .categoriesModel
                            .data!
                            .length !=
                        0)
                      _buildCategories(
                          CategoryCubit.get(context).categoriesModel, context)
                  ],
                ),
              );
            } else if (state is GetCategoryLoadingState)
              return Center(child: CircularProgressIndicator());
            else
              return Container();
          },
        ));
  }
}

Widget _buildCategories(AdminCategory category, context) {
  return Expanded(
    child: ListView.separated(
      // shrinkWrap: true,
      itemBuilder: (context, index) {
        print(baseUrl + category.data![index].image.toString());
        return Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
              color: myLightBG,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                    flex: 1,
                    child: Container(
                        alignment: Alignment.center,
                        width: 130,
                        child: Text(
                          '#$index',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ))),
                Flexible(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      width: 130,
                      child: Image.asset('assets/images/logo.png',width: 55,),
                      // child: FadeInImage.assetNetwork(
                      //   placeholder: '',
                      //   image: baseUrl+category.data![index].image.toString(),
                      //   width: 50,
                      //   fit: BoxFit.cover,
                      //   placeholderErrorBuilder: (BuildContext,
                      //       Object exception, StackTrace? stackTrace) {
                      //     return Container(
                      //       color: Colors.grey.shade100,
                      //       child: const Icon(
                      //         Icons.image_not_supported_outlined,
                      //         size: 40,
                      //         color: Colors.white,
                      //       ),
                      //     );
                      //   },
                      // ),
                    )),
                Flexible(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      width: 130,
                      child: Text(
                        category.data![index].name.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                Flexible(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      width: 180,
                      child: Text(
                        category.data![index].children!.length.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                Flexible(
                    flex: 1,
                    child: Container(
                        alignment: Alignment.center,
                        width: 130,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  navigateTo(context, AdminSubCategoriesScreen(category.data![index]));
                                },
                                icon: Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: Colors.grey,
                                )),
                          ],
                        ))),
                SizedBox(),
              ],
            ),
          ),
        );
      },
      itemCount: category.data!.length,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 10,
        );
      },
    ),
  );
}
