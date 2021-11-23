import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:memegen/app/modules/edit_meme/bindings/edit_meme_binding.dart';
import 'package:memegen/app/modules/edit_meme/views/edit_meme_view.dart';

import '../controllers/list_meme_controller.dart';

class ListMemeView extends GetView<ListMemeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: 150.0,
              floating: false,
              pinned: true,
              automaticallyImplyLeading: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () => Get.back(),
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  "MimGenerator",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            // SliverPersistentHeader(
            //   delegate: _SliverAppBarDelegate(
            //     TabBar(
            //       labelColor: Colors.black87,
            //       unselectedLabelColor: Colors.grey,
            //       tabs: [
            //         Tab(icon: Icon(Icons.info), text: "Tab 1"),
            //         Tab(icon: Icon(Icons.lightbulb_outline), text: "Tab 2"),
            //       ],
            //     ),
            //   ),
            //   pinned: true,
            // ),
          ];
        },
        body: RefreshIndicator(
          onRefresh: () async {
            controller.getMemes();
          },
          child: Container(
            child: Obx(
              () => controller.isDone.isFalse
                  ? Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.memeResponse != null
                          ? controller.memeResponse.length
                          : 5,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => Get.to(() => EditMemeView(),
                              binding: EditMemeBinding(),
                              arguments: [
                                controller.memeResponse[index].url,
                              ]),
                          child: Card(
                            child: Image.network(
                              controller.memeResponse[index].url!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
