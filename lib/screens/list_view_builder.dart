
import 'dart:developer';

import 'package:flutter/material.dart';

class ListViewBuilderScreen extends StatefulWidget {
  const ListViewBuilderScreen({super.key});

  @override
  State<ListViewBuilderScreen> createState() => _ListViewBuilderScreenState();
}

class _ListViewBuilderScreenState extends State<ListViewBuilderScreen> {
  final List<int> imagesId = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      log(' ${scrollController.position.pixels}, ${scrollController.position.maxScrollExtent} ',);
      if ( (scrollController.position.pixels + 500) >= scrollController.position.maxScrollExtent ) {
        add5();
      }
    });
  }

  void add5() {
    final lastId = imagesId.last;
    imagesId.addAll(
      [1, 2, 3, 4, 5].map((e) => lastId + e),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        removeTop: true,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          controller: scrollController,
          itemCount: imagesId.length,
          itemBuilder: (
            BuildContext context,
            int index,
          ) {
            return FadeInImage(
              fit: BoxFit.cover,
              placeholder: const AssetImage('assets/loading-cargando.gif'),
              image: NetworkImage(
                  'https://picsum.photos/500/300?image=${imagesId[index]}',),
              width: double.infinity,
              height: 300,
            );
          },
        ),
      ),
    );
  }
}
