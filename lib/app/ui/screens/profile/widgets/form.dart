import 'package:astrotak/app/data/models/location.dart';
import 'package:astrotak/app/data/repositories/location_repository.dart';
import 'package:astrotak/app/logic/location_search/location_search_cubit.dart';
import 'package:astrotak/app/logic/relative/relative_bloc.dart';
import 'package:astrotak/app/ui/screens/profile/profile.dart';
import 'package:astrotak/app/ui/theme/app_colors.dart';
import 'package:astrotak/app/ui/widgets/scroll_glow_remove.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

enum TimeType { AM, PM }

class RelativeForm extends StatefulWidget {
  const RelativeForm({Key? key, required this.pageController}) : super(key: key);

  final PageController pageController;

  @override
  State<RelativeForm> createState() => _RelativeFormState();
}

class _RelativeFormState extends State<RelativeForm> {
  TimeType timeType = TimeType.AM;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? placeError;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController minController = TextEditingController();
  final TextEditingController placeController = TextEditingController();

  String gender = 'Male';
  String relation = 'Brother';

  Location? location;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BlocProvider<LocationSearchCubit>(
        create: (context) => LocationSearchCubit(LocationRepostirory()),
        child: BlocListener<RelativeBloc, RelativeState>(
          listener: (context, state) {
            if (state is RelativeAdded) {
              widget.pageController.animateToPage(0, duration: Duration(milliseconds: 100), curve: Curves.easeOut);
            }
          },
          child: Form(
            key: formKey,
            child: ScrollGlowRemove(
              child: ListView(
                children: [
                  SizedBox(height: 24.0),
                  FormLabel(text: 'Name'),
                  SizedBox(height: 6.0),
                  FormField(
                    controller: nameController,
                    hint: '',
                    validator: (val) {
                      if (val.toString().isEmpty) {
                        return 'Enter valid name';
                      }
                    },
                  ),
                  SizedBox(height: 12.0),
                  FormLabel(text: 'Date of Birth'),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Expanded(
                        child: FormField(
                          controller: dayController,
                          hint: 'DD',
                          length: 2,
                          inputType: TextInputType.number,
                          validator: (val) {
                            if (val.toString().isEmpty) {
                              return 'Invalid DD';
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: FormField(
                          controller: monthController,
                          hint: 'MM',
                          length: 2,
                          inputType: TextInputType.number,
                          validator: (val) {
                            if (val.toString().isEmpty) {
                              return 'Invalid MM';
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: FormField(
                          controller: yearController,
                          hint: 'YYYY',
                          length: 4,
                          inputType: TextInputType.number,
                          validator: (val) {
                            if (val.toString().isEmpty) {
                              return 'Invalid YYYY';
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.0),
                  FormLabel(text: 'Time of Birth'),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Expanded(
                        child: FormField(
                          controller: hourController,
                          hint: 'HH',
                          inputType: TextInputType.number,
                          length: 2,
                          validator: (val) {
                            if (val.toString().isEmpty) {
                              return 'Invalid HH';
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: FormField(
                          controller: minController,
                          hint: 'MM',
                          length: 2,
                          inputType: TextInputType.number,
                          validator: (val) {
                            if (val.toString().isEmpty) {
                              return 'Invalid MM';
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    timeType = TimeType.AM;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 24.0),
                                  decoration: BoxDecoration(
                                    color: timeType == TimeType.AM ? AppColors.blue : Colors.white,
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  height: 52.0,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'AM',
                                    style: TextStyle(color: timeType == TimeType.PM ? Colors.black : Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    timeType = TimeType.PM;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 24.0),
                                  decoration: BoxDecoration(
                                    color: timeType == TimeType.PM ? AppColors.blue : Colors.white,
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  alignment: Alignment.center,
                                  height: 52.0,
                                  child: Text(
                                    'PM',
                                    style: TextStyle(color: timeType == TimeType.AM ? Colors.black : Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.0),
                  FormLabel(text: 'Place of Birth'),
                  SizedBox(height: 8.0),
                  BlocBuilder<LocationSearchCubit, LocationSearchState>(
                    buildWhen: (previous, current) => !(current is RelativeAdded),
                    builder: (context, state) {
                      List<Location> locations = [];

                      if (state is LocationSearchEmpty) {
                        locations = [];
                      }

                      if (state is LocationSearchData) {
                        locations = state.data;
                      }

                      return TypeAheadField(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: placeController,
                          decoration: InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            errorText: placeError,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        onSuggestionSelected: (suggestion) {
                          placeController.text = (suggestion as Location).placeName;
                          location = suggestion;
                        },
                        suggestionsCallback: (pattern) async {
                          await context.read<LocationSearchCubit>().searchLocation(pattern);
                          return locations;
                        },
                        itemBuilder: (context, itemData) => ListTile(
                          title: Text((itemData as Location).placeName),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 6.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 6.0),
                              FormLabel(text: 'Gender'),
                              SizedBox(height: 8.0),
                              DropdownButtonFormField<String>(
                                onChanged: (String? value) {
                                  gender = value.toString();
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                ),
                                hint: Text('Gender'),
                                value: 'Male',
                                items: ['Male', 'Female']
                                    .map(
                                      (e) => DropdownMenuItem<String>(
                                        child: Text(e),
                                        value: e,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 6.0),
                              FormLabel(text: 'Relation'),
                              SizedBox(height: 8.0),
                              DropdownButtonFormField<String>(
                                onChanged: (String? value) {
                                  relation = value.toString();
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                ),
                                value: 'Brother',
                                hint: Text('Relation'),
                                items: ['Mother in Law', 'Brother', 'Sister']
                                    .map(
                                      (e) => DropdownMenuItem<String>(
                                        child: Text(e),
                                        value: e,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          placeError = null;
                          bool parse = true;
                          if (location == null) {
                            setState(() {
                              placeError = 'Please select a city';
                            });
                            parse = false;
                          }
                          if (formKey.currentState!.validate() && parse) {
                            Map<String, dynamic> data = {
                              "birthDetails": {
                                "dobDay": dayController.text.trim(),
                                "dobMonth": monthController.text.trim(),
                                "dobYear": yearController.text.trim(),
                                "tobHour": hourController.text.trim(),
                                "tobMin": minController.text.trim(),
                                "meridiem": timeType.toString().split('.').last,
                              },
                              "birthPlace": {
                                "placeName": location!.placeName,
                                "placeId": location!.placeId,
                              },
                              "firstName": nameController.text.trim().split(' ').first,
                              "lastName": nameController.text.trim().split(' ').last,
                              "relationId": 3,
                              "gender": gender.toUpperCase(),
                            };

                            context.read<RelativeBloc>().add(CreateRelative(data));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.primaryColor,
                        ),
                        child: Text('Save relative'),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FormField extends StatelessWidget {
  const FormField({
    Key? key,
    required this.hint,
    this.length,
    this.validator,
    this.inputType = TextInputType.text,
    required this.controller,
  }) : super(key: key);

  final String hint;
  final int? length;
  final dynamic validator;
  final TextEditingController controller;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: length,
      validator: validator,
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hint,
        isDense: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}