import 'package:credit_card_input_form/constains.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/card_type.dart';
import 'components/card_utilis.dart';
import 'components/input_formatters.dart';

class AddNewCardScreen extends StatefulWidget {
  const AddNewCardScreen({Key? key}) : super(key: key);

  @override
  State<AddNewCardScreen> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  TextEditingController cardNumberContriller = TextEditingController();
  CardType cardType = CardType.Invalid;
  void getCardTypeFrmNum() {
    if (cardNumberContriller.text.length <= 6) {
      String cardNumber = CardUtils.getCleanedNumber(cardNumberContriller.text);
      CardType type = CardUtils.getCardTypeFrmNumber(cardNumber);
      if (type != cardType) {
        setState(() {
          cardType = type;
        });
      }
    }
  }

  @override
  void initState() {
    cardNumberContriller.addListener(() {
      getCardTypeFrmNum();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Card"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          children: [
            const Spacer(),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: cardNumberContriller,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(19),
                      CardNumberInputFormatter()
                    ],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Card Number",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SvgPicture.asset("assets/icons/card.svg"),
                        ),
                        suffixIcon: CardUtils.getCardIcon(cardType)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Full Name",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: SvgPicture.asset("assets/icons/user.svg"),
                            ))),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                            hintText: "CVV",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: SvgPicture.asset("assets/icons/Cvv.svg"),
                            )),
                      )),
                      const SizedBox(
                        width: defaultPadding,
                      ),
                      Expanded(
                          child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(5),
                          FilteringTextInputFormatter.digitsOnly,
                          CardMonthInputFormatter()
                        ],
                        decoration: InputDecoration(
                            hintText: "MM/YY",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child:
                                  SvgPicture.asset("assets/icons/calender.svg"),
                            )),
                      )),
                    ],
                  )
                ],
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            // scan button
            OutlinedButton.icon(
                onPressed: () {},
                icon: SvgPicture.asset("assets/icons/scan.svg"),
                label: const Text("Scan")),
            const SizedBox(
              height: defaultPadding,
            ),
            ElevatedButton(onPressed: () {}, child: const Text("Add Card")),
            const SizedBox(
              width: defaultPadding,
            ),
          ],
        ),
      )),
    );
  }
}
