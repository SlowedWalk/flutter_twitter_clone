import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/app/common/common.dart';
import 'package:twitter_clone/app/features/explore/controllers/explore_controller.dart';
import 'package:twitter_clone/app/features/explore/widgets/search_tile.dart';
import 'package:twitter_clone/app/theme/theme.dart';

class ExploreView extends ConsumerStatefulWidget {
  const ExploreView({super.key});

  @override
  ConsumerState createState() => _ExploreViewState();
}

class _ExploreViewState extends ConsumerState<ExploreView> {
  final searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final appBarTextFieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(
          color: Pallet.searchBarColor
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: SizedBox(
            height: 50,
          child: TextField(
            controller: searchController,
            onSubmitted: (value) {
              setState(() {
                isShowUsers = true;
              });
            },
            autofocus: true,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10).copyWith(left: 20),
              fillColor: Pallet.searchBarColor,
              filled: true,
              enabledBorder: appBarTextFieldBorder,
              focusedBorder: appBarTextFieldBorder,
              hintText: 'Search Twittify'
            ),
          ),
        ),
      ),
      body: isShowUsers ? ref.watch(searchUserProvider(searchController.text)).when(
          data: (users) {
            return ListView.builder(
              itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = users[index];
                  return SearchTile(userModel: user);
                },
            );
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Center(child: CircularProgressIndicator())) : const SizedBox(),
    );
  }
}
