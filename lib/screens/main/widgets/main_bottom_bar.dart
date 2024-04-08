import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foundit/theme/colors.dart';

class MainBottomBar extends StatefulWidget {
  final Function(int) index;
  const MainBottomBar({super.key, required this.index});

  @override
  State<MainBottomBar> createState() => _MainBottomBarState();
}

class _MainBottomBarState extends State<MainBottomBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: ThemeColor.primary.withOpacity(0.2),
      ),
      child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: ThemeColor.lightWhite,
          currentIndex: _currentIndex,
          unselectedItemColor: ThemeColor.primary,
          selectedItemColor: ThemeColor.tertiary,
          unselectedLabelStyle: Theme.of(context).textTheme.bodySmall,
          selectedLabelStyle: Theme.of(context).textTheme.bodySmall,
          onTap: (index) {
            widget.index(index);
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/bottom_bar/home_outlined.svg',
                semanticsLabel: 'Home',
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/bottom_bar/home_filled.svg',
                semanticsLabel: 'Home',
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/bottom_bar/chat_outlined.svg',
                semanticsLabel: 'Chat',
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/bottom_bar/chat_filled.svg',
                semanticsLabel: 'Chat',
              ),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/bottom_bar/add_outlined.svg',
                semanticsLabel: 'Create',
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/bottom_bar/add_filled.svg',
                semanticsLabel: 'Create',
              ),
              label: 'Create',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/bottom_bar/user_outlined.svg',
                semanticsLabel: 'Profile',
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/bottom_bar/user_filled.svg',
                semanticsLabel: 'Profile',
              ),
              label: 'Profile',
            ),
          ],
      ),
    );
  }
}
