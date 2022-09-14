import 'package:center_source_task_flutter/common/reusablewidgets.dart';
import 'package:center_source_task_flutter/provider/mainprovider.dart';
import 'package:center_source_task_flutter/utils/validation_helper.dart';
import 'package:center_source_task_flutter/views/fullimage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    getPageStatus();
    super.initState();
  }

  getPageStatus() async {
    await Future.microtask(() => context.read<MainProvider>().pageInit());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sample Search"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Consumer<MainProvider>(
          builder: (BuildContext context, value, _) {
            return Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.5, color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                      shape: BoxShape.rectangle),
                  child: TextField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    inputFormatters: ValidationHelpers.inputFormatter('name'),
                    decoration: const InputDecoration(
                      hintText: "Search  image",
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(Icons.search, color: Colors.black),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();

                      value.loadImages(
                          context: context, text: searchController.text);
                    },
                    child: const Text("Search")),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Scrollbar(
                    child: CustomScrollView(

                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      slivers: [
                        SliverPadding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                          sliver: SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              String imageUrl = value.searchImagesModel
                                      ?.hits![index].previewURL ??
                                  "";
                              String largeImageUrl = value.searchImagesModel
                                      ?.hits![index].largeImageURL ??
                                  "";

                              return InkWell(
                                  onTap: () {
                                    largeImageUrl != null
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => FullImage(
                                                  imageUrl: largeImageUrl),
                                            ))
                                        : ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                            content: Text(
                                                "Image Could not be processed"),
                                          ));
                                  },
                                  child: imageUrl != null && imageUrl.isNotEmpty
                                      ? ReusableWidgets.imageContainer(
                                          imageUrl: imageUrl)
                                      : SizedBox());
                            },
                                childCount:
                                    value.searchImagesModel?.hits?.length),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              crossAxisSpacing: 5,
                              mainAxisExtent: 250,
                              mainAxisSpacing: 5,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: ReusableWidgets.paginationLoader(false),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
