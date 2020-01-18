import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:quizz_app/quiz_brain.dart';

QuizBrain quizBrain = new QuizBrain();

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(answer) {
    Icon icon;
    if (answer == quizBrain.getCorrectAnswer()) {
      quizBrain.incrementScore();
      icon = Icon(Icons.check, color: Colors.green);
    }
    else {
      icon = Icon(Icons.close, color: Colors.red);
    }

    setState(() {
      scoreKeeper.add(icon);
    });

    if (quizBrain.hasMoreQuestion()) {
      quizBrain.nextQuestion();
    } else {
      int score = quizBrain.getScore();
      int totalQuestion = quizBrain.getTotalQuestions();

      Alert(
        context: context,
        type: quizBrain.hasWin() ? AlertType.success : AlertType.error,
        title: 'Quiz finished',
        desc: 'You have made $score/$totalQuestion',
        closeFunction: this.resetGame,
        style: AlertStyle(
          isOverlayTapDismiss: false,
        ),
        buttons: [
          DialogButton(
            child: Text(
              'Ok',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              this.resetGame();
              Navigator.pop(context);
            },
            width: 120,
          )
        ],
      ).show();
    }
  }

  void resetGame() {
    setState(() {
      scoreKeeper = [];
    });
    quizBrain.resetGame();// Close Alert
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
                textColor: Colors.white,
                color: Colors.green,
                child: Text(
                  'True',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () => checkAnswer(true)),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              onPressed: () => checkAnswer(false),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
        //TODO: Add a Row here as your score keeper
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
