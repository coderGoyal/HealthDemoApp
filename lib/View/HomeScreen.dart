import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:fitbasix/Models/ExcerciseListModel.dart';
import 'package:fitbasix/Services/ApiServices.dart';
import 'package:fitbasix/Utils/KStyles.dart';
import 'package:fitbasix/View/DetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer_pro/sizer.dart';

import 'WorkoutTile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final APIservices _webservices = APIservices();
  List<ExcerciseListModel> _allExcersize = [];
  bool loading = true;
  List<String> items =
      []; // Your list of items fetched from the API // Number of items to display initially
  bool showLoadMoreButton = true;
  bool isLoadingMore = false;
  int visibleItemCount = 10;
  // Whether to show the "Load More" button

  fetchData() async {
    await _webservices.fetchAllExcersize().then((value) {
      if (value != null) {
        _allExcersize = value;
        loading = false;
      } else {
        Fluttertoast.showToast(msg: "Unable to load excersizes");
        loading = false;
      }
      setState(() {});
    });
  }

  void loadMoreData() {
    // Simulating API call or loading more data from a data source
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        visibleItemCount += 10; // Increase the visibleItemCount by 10
        isLoadingMore = false;
      });
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Exercises",
          style: TextStyle(fontSize: 12.sp, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
          width: 100.0.w,
          height: 100.0.h,
          padding: EdgeInsets.symmetric(horizontal: 5.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              // SizedBox(
              //   height: MediaQuery.of(context).padding.top + 2.0.h,
              // ),
              // Text(
              //   "Exercises",
              //   style: KStyles.superHeading,
              // ),
              Expanded(
                  child: loading
                      ? ListView.builder(
                          padding: EdgeInsets.only(top: 3.0.h),
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: visibleItemCount,
                          itemBuilder: (context, index) =>
                              getShimmerPlaceholder(),
                        )
                      :
                      // ListView.builder(
                      //     padding: EdgeInsets.only(top: 3.0.h),
                      //     physics: const BouncingScrollPhysics(),
                      //     shrinkWrap: true,
                      //     itemCount: 10,
                      //     itemBuilder: (context, index) {
                      //       return GestureDetector(
                      //         onTap: () {
                      //           Get.to(
                      //             () => DetailScreen(
                      //                 id: _allExcersize[index].id ?? "-1"),
                      //             transition: Transition.fadeIn,
                      //           );
                      //         },
                      //         child: WorkoutTile(
                      //           model: _allExcersize[index],
                      //         ),
                      //       );
                      //     }),
                      ListView.builder(
                          padding: EdgeInsets.only(top: 3.0.h),
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: visibleItemCount +
                              1, // Add 1 for the "Load More" button
                          itemBuilder: (context, index) {
                            if (index == visibleItemCount) {
                              // Render the "Load More" button
                              return ElevatedButton(
                                child: Text('Load More'),
                                onPressed: () {
                                  if (!isLoadingMore) {
                                    setState(() {
                                      isLoadingMore = true;
                                    });
                                    loadMoreData();
                                  }
                                },
                              );
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => DetailScreen(
                                        id: _allExcersize[index].id ?? "-1"),
                                    transition: Transition.fadeIn,
                                  );
                                },
                                child: WorkoutTile(
                                  model: _allExcersize[index],
                                ),
                              );
                            }
                          },
                        )),
            ],
          )),
    );
  }

  Container getShimmerPlaceholder() {
    return Container(
      margin: EdgeInsets.only(bottom: 3.0.h),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeShimmer(
                  height: 1.0.h,
                  width: double.infinity,
                  radius: 4,
                  highlightColor: const Color(0xffF9F9FB),
                  baseColor: const Color(0xffE6E8EB),
                ),
                SizedBox(
                  height: 3.0.h,
                ),
                FadeShimmer(
                  height: 1.0.h,
                  width: double.infinity,
                  radius: 4,
                  highlightColor: const Color(0xffF9F9FB),
                  baseColor: const Color(0xffE6E8EB),
                ),
                SizedBox(
                  height: 3.0.h,
                ),
                FadeShimmer(
                  height: 1.0.h,
                  width: double.infinity,
                  radius: 4,
                  highlightColor: const Color(0xffF9F9FB),
                  baseColor: const Color(0xffE6E8EB),
                )
              ],
            ),
          ),
          SizedBox(
            width: 5.0.w,
          ),
        ],
      ),
    );
  }
}
