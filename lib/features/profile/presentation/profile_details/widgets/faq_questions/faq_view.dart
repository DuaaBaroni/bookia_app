import 'package:bookia_app/core/constants/app_images.dart';
import 'package:bookia_app/core/functions/navigations.dart';
import 'package:bookia_app/core/widgets/main_button.dart';
import 'package:bookia_app/features/profile/presentation/profile_details/view/profile_details.dart';
import 'package:bookia_app/features/profile/presentation/profile_details/widgets/faq_questions/header_card.dart';
import 'package:bookia_app/features/profile/presentation/profile_details/widgets/faq_questions/question_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class BookQuestionsView extends StatefulWidget {
  const BookQuestionsView({super.key});

  @override
  State<BookQuestionsView> createState() => _BookQuestionsViewState();
}

class _BookQuestionsViewState extends State<BookQuestionsView> {
  /// List of questions
  final List<Map<String, dynamic>> questions = [
    {
      "question": "What genre do you enjoy the most?",
      "icon": Icons.menu_book,
      "options": ["Romance", "Mystery", "Fantasy", "Self Development"],
    },
    {
      "question": "How often do you read?",
      "icon": Icons.schedule,
      "options": ["Daily", "Weekly", "Sometimes"],
    },
    {
      "question": "Do you prefer short or long books?",
      "icon": Icons.description,
      "options": ["Short & Engaging", "Long & Detailed"],
    },
    {
      "question": "What mood are you in today?",
      "icon": Icons.auto_awesome,
      "options": [
        "Feel-Good & Happy",
        "Dark & Thought-Provoking",
        "Inspirational & Motivating",
        "Adventurous & Exciting",
      ],
    },
  ];

  /// Store selected answers
  late List<String?> selectedAnswers;

  @override
  void initState() {
    super.initState();
    selectedAnswers = List.filled(questions.length, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const HeaderCard(),
                    const Gap(20),

                    /////
                    ...List.generate(questions.length, (index) {
                      final q = questions[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: QuestionCard(
                          questionNumber: '${index + 1} of ${questions.length}',
                          question: q["question"],
                          icon: q["icon"],
                          options: List<String>.from(q["options"]),
                          selectedValue: selectedAnswers[index],
                          onChanged: (value) {
                            setState(() {
                              selectedAnswers[index] = value;
                            });
                          },
                        ),
                      );
                    }),
                    const Gap(100),
                  ],
                ),
              ),
            ),

            /// Bottom Button
            Padding(
              padding: const EdgeInsets.all(10),
              child: MainButton(
                text: "Get My Recommendations",
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
