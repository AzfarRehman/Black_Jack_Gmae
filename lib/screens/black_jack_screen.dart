import 'package:black_jack/widgets/cards_grid_view.dart';
import 'package:black_jack/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'dart:math';
class BlackJackScreen extends StatefulWidget {
  const BlackJackScreen({Key? key}) : super(key: key);

  @override
  _BlackJackScreenState createState() => _BlackJackScreenState();
}

class _BlackJackScreenState extends State<BlackJackScreen> {

  bool _isGameStarted = false ;

 // Card Images
  List<Image> myCards = [];

  List<Image> dealersCards = [];

  // Dealer Card

  String ? dealerFirstCard ;
  String ? dealerSecondCard ;

  //Player Card

  String ? playerFirstCard;
  String ? playerSecondCard;

  //Scores
  int dealersScore = 0 ;
  int playerScore= 0;

  //deck of cards

  final Map<String, int> decOfCards = {
    "cards/2.1.png" : 2,
    "cards/2.2.png" : 2,
    "cards/2.3.png" : 2,
    "cards/2.4.png" : 2,
    "cards/3.1.png" : 3,
    "cards/3.2.png" : 3,
    "cards/3.3.png" : 3,
    "cards/3.4.png" : 3,
    "cards/4.1.png" : 4,
    "cards/4.2.png" : 4,
    "cards/4.3.png" : 4,
    "cards/4.4.png" : 4,
    "cards/5.1.png" : 5,
    "cards/5.2.png" : 5,
    "cards/5.3.png" : 5,
    "cards/5.4.png" : 5,
    "cards/6.1.png" : 6,
    "cards/6.2.png" : 6,
    "cards/6.3.png" : 6,
    "cards/6.4.png" : 6,
    "cards/7.1.png" : 7,
    "cards/7.2.png" : 7,
    "cards/7.3.png" : 7,
    "cards/7.4.png" : 7,
    "cards/8.1.png" : 8,
    "cards/8.2.png" : 8,
    "cards/8.3.png" : 8,
    "cards/8.4.png" : 8,
    "cards/9.1.png" : 9,
    "cards/9.2.png" : 9,
    "cards/9.3.png" : 9,
    "cards/9.4.png" : 9,
    "cards/10.1.png": 10,
    "cards/10.2.png": 10,
    "cards/10.3.png": 10,
    "cards/10.4.png": 10,
    "cards/J1.png" : 10,
    "cards/J2.png" : 10,
    "cards/J3.png" : 10,
    "cards/J4.png" : 10,
    "cards/Q1.png" : 10,
    "cards/Q2.png" : 10,
    "cards/Q3.png" : 10,
    "cards/Q4.png" : 10,
    "cards/K1.png" : 10,
    "cards/K2.png" : 10,
    "cards/K3.png" : 10,
    "cards/K4.png" : 10,
    "cards/A1.png" : 11,
    "cards/A2.png" : 11,
    "cards/A3.png" : 11,
    "cards/A4.png" : 11,
  };

  Map<String, int> playingCards = {};
  @override
  void initState() {
    super.initState();

    playingCards.addAll(decOfCards);
  }
 //reset the round & reset the card
  void startNewRound() {
    _isGameStarted = true ;

    //Start new round with full dec of cards
    playingCards = {};
    playingCards.addAll(decOfCards);

    //Reset cards images
     myCards = [];

     dealersCards = [];

     Random random = Random();
     //Random Card One FOR DEALER
    String cardOneKey = playingCards.keys.elementAt(random.nextInt(playingCards.length));//from zero to playingCards.length

    //Remove CardOneKey from Dec
    playingCards.removeWhere((key, value) => key == cardOneKey);


    //Random Card TWO FOR DEALER
    String cardTwoKey = playingCards.keys.elementAt(random.nextInt(playingCards.length));

    //Remove CardTwoKey from Dec
    playingCards.removeWhere((key, value) => key == cardTwoKey);

    //Random Card One FOR Player
    String cardThreeKey = playingCards.keys.elementAt(random.nextInt(playingCards.length));

    //Remove CardThreeKey from Dec
    playingCards.removeWhere((key, value) => key == cardThreeKey);

    //Random Card Two FOR Player

    String cardFourKey = playingCards.keys.elementAt(random.nextInt(playingCards.length));

    //Remove CardFourKey from Dec
    playingCards.removeWhere((key, value) => key == cardFourKey);

    //Assigns cards keys to dealer cards

    dealerFirstCard = cardOneKey;
    dealerSecondCard = cardTwoKey;
    //Assigns cards keys to Players cards

    playerFirstCard = cardThreeKey;
    playerSecondCard = cardFourKey;

    //Adding Dealer card Images to display in gridView
    dealersCards.add(Image.asset(dealerFirstCard!));
    dealersCards.add(Image.asset(dealerSecondCard!));

    //Score for Dealer

    dealersScore = decOfCards[dealerFirstCard]!+ decOfCards[dealerSecondCard]!;

    //Adding Player card Images to display in gridView

    myCards.add(Image.asset(playerFirstCard!));
    myCards.add(Image.asset(playerSecondCard!));

    //Score for Player

    playerScore = decOfCards[playerFirstCard]! + decOfCards[playerSecondCard]!;

    if ( dealersScore <= 14) {
      String thirdDealerCard = playingCards.keys.elementAt(random.nextInt(playingCards.length));

      dealersCards.add(Image.asset(thirdDealerCard));

      playerScore = dealersScore + decOfCards[thirdDealerCard]!;
    }
    setState(() {});




  }

  //add extra card to player

  void addCard() {
    Random  random = Random();
    if(playingCards.length > 0 ){

      String cardKey = playingCards.keys.elementAt(random.nextInt(playingCards.length));
      playingCards.removeWhere((key, value) => key == cardKey);
      myCards.add(Image.asset(cardKey));

      playerScore = playerScore + decOfCards[cardKey]!;
      setState(() {

      });

    }

  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isGameStarted ? SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
                Text("Dealer's Score: $dealersScore", style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: dealersScore <= 21 ? Colors.green[900] : Colors.red[900],
                ),),
              //Dealer's Card
              CardGridView(cards: dealersCards),
            ],
          ),

          Column(
            children:  [
             Text("Player's Score: $playerScore, " ,
               style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: playerScore <= 21 ? Colors.green[900] : Colors.red[900],
          ),),
              // TODO: Add Score
              CardGridView(cards: myCards),

            ],
          ),
          IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomButton(onPressed: (){
                  addCard();
                }, label: "Another Card"),
                CustomButton(onPressed: (){
                  startNewRound();
                }, label: "Next Round"),
              ],
            ),
          ),



        ],
      )) : Center(
        child:CustomButton(onPressed: (){
          startNewRound();
        }, label: "Start Game"),
      ) ,
    );
  }
}


