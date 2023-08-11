import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../bloc/netflix_bloc.dart';
import '../cubit/animation_status_cubit.dart';
import '../utils/utils.dart';
import 'profile_icon.dart';

class NetflixHeader extends SliverPersistentHeaderDelegate {
  final double scrollOffset;
  final String? name;
  final Duration _duration = const Duration(milliseconds: 150);
  late final bottom = scrollOffset < 64.00 ? scrollOffset : 64.00;

  NetflixHeader({required this.scrollOffset, this.name});

  String selectedCategory = 'Categories'; // Giá trị mặc định là 'Categories'

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final status = context.watch<AnimationStatusCubit>();
    final backButtonOpacity =
        status.state != AnimationStatus.reverse ? 1.0 : 0.0;
    final canPop = GoRouter.of(context).canPop();

    final location = GoRouterState.of(context).location;
    final isTvShowsPage = location.contains('tvshows');
    final opacity = isTvShowsPage
        ? (status.state == AnimationStatus.completed ? 1.0 : 0.0)
        : (status.state == AnimationStatus.forward ? 0.0 : 1.0);

    final backdrop =
        Colors.black.withOpacity((scrollOffset / 100).clamp(0, .8).toDouble());

    final topViewPadding = MediaQuery.of(context).viewPadding.top;

    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          width: MediaQuery.of(context).size.width,
          child: Container(
            color: backdrop,
            padding: EdgeInsets.only(top: topViewPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                canPop
                    ? Row(
                        children: [
                          AnimatedOpacity(
                            duration: _duration,
                            opacity: backButtonOpacity,
                            child: IconButton(
                                onPressed: () {
                                  context.pop();
                                },
                                icon: const Icon(LucideIcons.arrowLeft)),
                          ),
                          Text(
                            name ?? '',
                            style: Theme.of(context).textTheme.headlineSmall,
                          )
                        ],
                      )
                    : AnimatedOpacity(
                        duration: _duration,
                        opacity: opacity,
                        child: Image.asset(
                          'assets/netflix_symbol.png',
                          height: 72.0,
                        ),
                      ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(LucideIcons.cast)),
                    IconButton(
                        onPressed: () {}, icon: const Icon(LucideIcons.search)),
                    IconButton(
                      onPressed: () => context.go('/profile'),
                      icon: Builder(builder: (context) {
                        final state = context.read<ProfileSelectorBloc>().state;
                        return ProfileIcon(
                          color: profileColors[state.profile],
                          iconSize: IconTheme.of(context).size,
                        );
                      }),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 16.0,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Opacity(
                opacity: opacity,
                child: DropdownButton<String>(
                  items: ['Categories', 'Cartoons', 'TV Shows', 'Movies']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                  value: selectedCategory, // Sử dụng giá trị được chọn
                  onChanged: (newValue) {
                    // Cập nhật giá trị được chọn
                    selectedCategory = newValue!;
                    // Xử lý theo giá trị được chọn
                    if (newValue == 'Categories') {
                      // Handle Categories selection
                    } else if (newValue == 'Cartoons') {
                      // Handle Cartoons selection
                    } else if (newValue == 'Movies') {
                      // Handle Movies selection
                    } else if (newValue == 'TV Shows') {
                      // Handle TV Shows selection
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 164.8 - bottom;

  @override
  double get minExtent => 164.8 - bottom;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class RectCustomClipper extends CustomClipper<Rect> {
  const RectCustomClipper({required this.bottom});

  final double bottom;

  @override
  Rect getClip(Size size) => Rect.fromLTWH(0, bottom, size.width, size.height);

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) =>
      oldClipper != this;
}
