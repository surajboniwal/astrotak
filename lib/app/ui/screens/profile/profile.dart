import 'package:astrotak/app/data/repositories/relative_repository.dart';
import 'package:astrotak/app/logic/relative/relative_bloc.dart';
import 'package:astrotak/app/ui/screens/navigation/widgets/app_bar.dart';
import 'package:astrotak/app/ui/screens/profile/widgets/form.dart';
import 'package:astrotak/app/ui/screens/profile/widgets/relative_body.dart';
import 'package:astrotak/app/ui/screens/profile/widgets/relative_header.dart';
import 'package:astrotak/app/ui/screens/profile/widgets/topbar.dart';
import 'package:astrotak/app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RelativeBloc>(
      create: (context) => RelativeBloc(RelativeRepository())..add(LoadRelative()),
      child: Scaffold(
        appBar: AstroAppBar(profile: true),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              SizedBox(
                height: 36.0,
                child: TabBar(
                  indicatorColor: AppColors.primaryColor,
                  labelColor: AppColors.primaryColor,
                  unselectedLabelColor: Colors.grey.shade500,
                  indicatorSize: TabBarIndicatorSize.tab,
                  padding: EdgeInsets.zero,
                  tabs: [
                    Tab(
                      text: 'My Profile',
                    ),
                    Tab(
                      text: 'Order History',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 36.0,
                              child: TabBar(
                                labelStyle: TextStyle(fontSize: 13.0),
                                indicator: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(3.0),
                                ),
                                unselectedLabelColor: Colors.grey.shade500,
                                tabs: [
                                  Tab(
                                    text: 'Basic Profile',
                                  ),
                                  Tab(
                                    text: 'Friends and Family Profile',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                Center(
                                  child: Text('Basic Profile'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: Column(
                                    children: [
                                      TopBar(),
                                      Expanded(
                                        child: PageView(
                                          physics: NeverScrollableScrollPhysics(),
                                          controller: pageController,
                                          children: [
                                            BlocBuilder<RelativeBloc, RelativeState>(
                                              builder: (context, state) {
                                                if (state is RelativeLoading) {
                                                  return Center(
                                                    child: CircularProgressIndicator(
                                                      color: AppColors.primaryColor,
                                                    ),
                                                  );
                                                }

                                                if (state is RelativeError) {
                                                  return Center(
                                                    child: Text(state.message),
                                                  );
                                                }

                                                if (state is RelativeLoaded) {
                                                  return Column(
                                                    children: [
                                                      SizedBox(height: 24.0),
                                                      Header(),
                                                      RelativeBody(
                                                        data: state.data,
                                                        pageController: pageController,
                                                      ),
                                                    ],
                                                  );
                                                }

                                                return Text('Something went wrong please try again');
                                              },
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        pageController.animateToPage(
                                                          0,
                                                          duration: Duration(milliseconds: 100),
                                                          curve: Curves.easeOut,
                                                        );
                                                        RelativeFormState.clearState();
                                                      },
                                                      icon: Icon(Icons.chevron_left),
                                                    ),
                                                    Text('Add new profile'),
                                                  ],
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                    child: RelativeForm(
                                                      pageController: pageController,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Text(
                        'Order History',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FormLabel extends StatelessWidget {
  const FormLabel({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.grey,
      ),
    );
  }
}
