import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foundit/providers/user_provider.dart';
import 'package:foundit/screens/map/map_screen.dart';
import 'package:foundit/screens/profile/widgets/my_items_view.dart';
import 'package:foundit/theme/colors.dart';
import 'package:foundit/widgets/filled_button_widget.dart';
import 'package:foundit/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Provider.of<UserProvider>(context, listen: false)
        .getUser(FirebaseAuth.instance.currentUser!.uid);
    getImage() {
      final item =
          Provider.of<UserProvider>(context, listen: false).currentUser;
      if (item != null) {
        if (item.photoURL != null) {
          return Image.network(
            fit: BoxFit.contain,
            item.photoURL!,
          );
        }
      }
      return const SizedBox();
    }

    return Consumer<UserProvider>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ThemeColor.mediumGrey,
              ),
              clipBehavior: Clip.antiAlias,
              child: getImage(),
            ),
            const SizedBox(
              height: 12,
            ),
            TextWidget(
              text: provider.currentUser?.name ?? 'Your Name',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: ThemeColor.text,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(
              height: 24,
            ),
            PhysicalModel(
              elevation: 10,
              shadowColor: ThemeColor.lightGrey,
              borderRadius: BorderRadius.circular(16),
              color: ThemeColor.lightWhite,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                width: width,
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: ThemeColor.primary,
                          child: Icon(
                            size: 20,
                            color: ThemeColor.white,
                            Icons.phone,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        TextWidget(
                          text: provider.currentUser?.phoneNo ?? 'Empty',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: ThemeColor.text,
                                  fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Divider(
                      indent: width / 7,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: ThemeColor.primary,
                          child: Icon(
                            size: 20,
                            color: ThemeColor.white,
                            Icons.mail,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextWidget(
                            text: provider.currentUser?.email ??
                                'Your email address',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: ThemeColor.text,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            FilledButtonWidget(
              backgroundColor: ThemeColor.secondary,
              textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ThemeColor.lightWhite,
                    fontWeight: FontWeight.w500,
                  ),
              text: 'My posts..',
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyItemsView(),
                  ),
                );
              },
            ),
            const Spacer(),
            FilledButtonWidget(
              backgroundColor: ThemeColor.tertiary,
              textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ThemeColor.lightWhite,
                    fontWeight: FontWeight.w500,
                  ),
              text: 'Sign out',
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
            ),
            // const SizedBox(height: 20,),
            // FilledButtonWidget(
            //   backgroundColor: ThemeColor.tertiary,
            //   textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            //     color: ThemeColor.lightWhite,
            //     fontWeight: FontWeight.w500,
            //   ),
            //   text: 'Map',
            //   onPressed: () async {
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen()));
            //   },
            // ),
          ],
        ),
      );
    });
  }
}
