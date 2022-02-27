import 'package:astrotak/app/data/models/relative.dart';
import 'package:astrotak/app/data/repositories/relative_repository.dart';
import 'package:astrotak/app/logic/relative/relative_bloc.dart';
import 'package:astrotak/app/ui/screens/profile/widgets/form.dart';
import 'package:astrotak/app/ui/theme/app_colors.dart';
import 'package:astrotak/app/ui/widgets/scroll_glow_remove.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RelativeBody extends StatelessWidget {
  const RelativeBody({
    Key? key,
    required this.data,
    required this.pageController,
  }) : super(key: key);

  final List<Relative> data;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ScrollGlowRemove(
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          itemCount: data.length + 1,
          separatorBuilder: (context, index) => SizedBox(height: 12.0),
          itemBuilder: (context, index) {
            if (index == data.length) {
              return Column(
                children: [
                  SizedBox(height: 36),
                  ElevatedButton.icon(
                    onPressed: () {
                      pageController.animateToPage(1, duration: Duration(milliseconds: 100), curve: Curves.easeOut);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.primaryColor,
                    ),
                    icon: Icon(Icons.add),
                    label: Text('Add New Profile'),
                  ),
                ],
              );
            }

            Relative relative = data[index];

            return Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.6, 0.6),
                    spreadRadius: 1.0,
                    color: Colors.grey.shade400,
                  ),
                ],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${relative.firstName} ${relative.lastName}',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${relative.birthDetails.dobDay}-${relative.birthDetails.dobMonth}-${relative.birthDetails.dobYear}',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${relative.birthDetails.tobMin}:${relative.birthDetails.tobHour}',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            relative.relation,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              RelativeFormState.parseRelative(relative);
                              pageController.animateToPage(
                                1,
                                duration: Duration(milliseconds: 100),
                                curve: Curves.easeOut,
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              color: AppColors.primaryColor,
                            ),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () async {
                              await RelativeRepository().deleteRelative(relative.uuid);
                              context.read<RelativeBloc>().add(LoadRelative());
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
