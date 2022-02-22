import 'dart:math';

import 'package:astrotak/app/data/models/category.dart';
import 'package:astrotak/app/data/repositories/question_repository.dart';
import 'package:astrotak/app/logic/category/category_bloc.dart';
import 'package:astrotak/app/logic/category_suggestion/category_suggestion_cubit.dart';
import 'package:astrotak/app/ui/screens/navigation/widgets/info_bar.dart';
import 'package:astrotak/app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AskSection extends StatelessWidget {
  AskSection({Key? key}) : super(key: key);

  static const List<String> points = [
    'Personalized responses provided by our team of Vedic astrologers within 24 hours.',
    'Qualified and experienced astrologers will look into your birth chart and provide the right guidance.',
    'You can seek answers to any part of your life and for most pressing issues.',
    'Our team of Vedic astrologers will not just provide answers but also suggest a remidial solution.',
  ];

  final TextEditingController questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CategoryBloc(QuestionRepository())..add(LoadCategories())),
        BlocProvider(create: (context) => CategorySuggestionCubit()),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoBar(
                      text: 'Wallet Balance : \u{20B9} 0',
                      buttonText: 'Add Money',
                    ),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ask a Question',
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 6.0),
                          Text(
                            'Seek accurate answers to your life problems and get guidance towards the right path. Whether the problem is related to love, self, life, business, money, education or work, our astrologers will do an in depth study of your birth chart to provide personalized responses along with remedies',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Choose category',
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  offset: Offset(0.2, 1.2),
                                  blurRadius: 1.0,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: BlocBuilder<CategoryBloc, CategoryState>(
                              builder: (context, state) {
                                List<Category> categories = [];
                                String? hint;
                                Category? value;

                                if (state is CategoryLoading) {
                                  categories = [];
                                  hint = 'Loading';
                                  value = null;
                                }

                                if (state is CategoryLoaded) {
                                  categories = state.data;
                                  hint = null;
                                  value = state.data.first;
                                }

                                if (state is CategoryError) {
                                  categories = [];
                                  hint = state.message;
                                  value = null;
                                }

                                context.read<CategorySuggestionCubit>().selectCategory(value);

                                return DropdownButtonFormField<Category>(
                                  hint: Text(hint.toString()),
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  value: value,
                                  items: categories
                                      .map(
                                        (e) => DropdownMenuItem<Category>(
                                          child: Text(e.name),
                                          value: e,
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    if (value == null) return;
                                    context.read<CategorySuggestionCubit>().selectCategory(null);
                                    context.read<CategorySuggestionCubit>().selectCategory(value);
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 12.0),
                          TextField(
                            controller: questionController,
                            maxLines: 3,
                            maxLength: 150,
                            decoration: InputDecoration(
                              hintText: 'Type a question here',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.primaryColor,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Ideas what to Ask (Select Any)',
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          BlocBuilder<CategorySuggestionCubit, CategorySuggestionState>(
                            builder: (context, state) {
                              if (state is CategorySuggestionEmpty) {
                                return Container();
                              }

                              if (state is CategorySuggestionNoIdeas) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 24.0),
                                    Text('No suggestions for this category'),
                                    SizedBox(height: 24.0),
                                  ],
                                );
                              }

                              if (state is CategorySuggestionSelected) {
                                return ListView.separated(
                                  itemCount: state.category.suggestions.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) => Divider(
                                    color: Colors.grey.shade300,
                                    thickness: 1.5,
                                  ),
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                                    child: InkWell(
                                      onTap: () {
                                        questionController.text = state.category.suggestions[index];
                                      },
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: Row(
                                        children: [
                                          Transform.rotate(
                                            angle: 90.0 * (pi / 360),
                                            child: Container(
                                              height: 24.0,
                                              width: 24.0,
                                              color: AppColors.primaryColor,
                                              alignment: Alignment.center,
                                              child: Transform.rotate(
                                                angle: -90.0 * (pi / 360),
                                                child: Text(
                                                  '?',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 12.0),
                                          Expanded(
                                            child: Text(
                                              state.category.suggestions[index],
                                              style: TextStyle(
                                                color: Colors.grey.shade800,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Text('Failed to load ideas');
                            },
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            'Seeking accurate answers to difficult questions troubling your mind? Ask credible astrologers to know what future has in store for you.',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(height: 12.0),
                          Container(
                            padding: EdgeInsets.all(12.0),
                            color: AppColors.primaryColor.withOpacity(0.15),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: points.length,
                              itemBuilder: (context, index) => Row(
                                children: [
                                  CircleAvatar(
                                    radius: 4.0,
                                    backgroundColor: AppColors.primaryColor,
                                  ),
                                  SizedBox(width: 12.0),
                                  Expanded(
                                    child: Text(
                                      points[index],
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 80.0),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      onPressed: () {},
                      child: Icon(Icons.menu),
                      backgroundColor: AppColors.primaryColor,
                    ),
                  ),
                  InfoBar(
                    text: '\u{20B9} 150 ( 1 Question on Love )',
                    buttonText: 'Ask Now',
                    borderRadius: 6.0,
                    height: 48.0,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
