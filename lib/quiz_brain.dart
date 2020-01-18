import 'package:quizz_app/question.dart';

class QuizBrain {
  int _questionNumber = 0;
  int _score = 0;

  List<Question> _questionBank = [
    Question(
        description: 'Some cats are actually allergic to humans', answer: true),
    Question(
        description: 'You can lead a cow down stairs but not up stairs.',
        answer: false),
    Question(
        description:
            'Approximately one quarter of human bones are in the feet.',
        answer: true),
    Question(description: 'A slug\'s blood is green.', answer: true),
    Question(
        description: 'Buzz Aldrin\'s mother\'s maiden name was \"Moon\".',
        answer: true),
    Question(
        description: 'It is illegal to pee in the Ocean in Portugal.',
        answer: true),
    Question(
        description:
            'No piece of square dry paper can be folded in half more than 7 times.',
        answer: false),
    Question(
        description:
            'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
        answer: true),
    Question(
        description:
            'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
        answer: false),
    Question(
        description:
            'The total surface area of two human lungs is approximately 70 square metres.',
        answer: true),
    Question(
        description: 'Google was originally called \"Backrub\".', answer: true),
    Question(
        description:
            'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
        answer: true),
    Question(
        description:
            'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.',
        answer: true)
  ];

  bool hasMoreQuestion() {
    return this._questionNumber < (this._questionBank.length - 1);
  }

  void nextQuestion() {
    if (hasMoreQuestion()) {
      this._questionNumber++;
    }
  }

  String getQuestionText() {
    return this._questionBank[this._questionNumber].description;
  }

  bool getCorrectAnswer() {
    return this._questionBank[this._questionNumber].answer;
  }

  int getTotalQuestions() {
    return this._questionBank.length;
  }

  int getScore() {
    return _score;
  }

  void incrementScore() {
    if (this._score < this._questionBank.length) {
      _score++;
    }
  }

  bool hasWin() {
    if (!hasMoreQuestion()) {
      return this._score >= (this._questionBank.length / 2);
    }
    return false;
  }

  void resetGame() {
    this._questionNumber = 0;
    this._score = 0;
  }
}
