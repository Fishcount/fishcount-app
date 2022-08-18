import 'package:fishcount_app/model/EmailModel.dart';
import 'package:fishcount_app/model/enums/EnumTipoEmail.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'EmailController.dart';

class EmailForm extends StatefulWidget {
  final EmailModel? emailModel;

  const EmailForm({
    Key? key,
    this.emailModel,
  }) : super(key: key);

  @override
  State<EmailForm> createState() => _EmailFormState();
}


class _EmailFormState extends State<EmailForm> {
  final TextEditingController _emailController = TextEditingController();
  EnumTipoEmail mainEnum = EnumTipoEmail.ADICIONAL;
  bool hasChanged = false;

  @override
  Widget build(BuildContext context) {
    _emailController.text =
        widget.emailModel != null ? widget.emailModel!.descricao : _emailController.text;

    return Scaffold(
      appBar: CustomAppBar.build(),
      body: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 30),
              child: const Text(
                "Email",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 50),
              child: TextFieldWidget(
                labelText: "Email",
                controller: _emailController,
                hintText: "Digite seu email",
                prefixIcon: const Icon(Icons.account_balance_wallet_sharp),
                focusedBorderColor: Colors.blueGrey,
                iconColor: Colors.blueGrey,
                obscureText: false,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5, top: 20),
              alignment: Alignment.centerLeft,
              child: const Text("Tipo do Email:"),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: getSelectTipoEmail(context),
            ),
            Container(
              padding: const EdgeInsets.only(top: 40),
              child: ElevatedButtonWidget(
                  textSize: 18,
                  radioBorder: 20,
                  horizontalPadding: 30,
                  verticalPadding: 10,
                  textColor: Colors.white,
                  buttonColor: Colors.blue,
                  buttonText:
                      widget.emailModel != null ? "Atualizar" : "Salvar",
                  onPressed: () {
                    EmailModel email = EmailModel(
                        widget.emailModel != null
                            ? widget.emailModel!.id
                            : null,
                        _emailController.text,
                        mainEnum.name);
                    EmailController().salvarEmail(context, email);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  DropdownButton<EnumTipoEmail> getSelectTipoEmail(BuildContext context) {
    mainEnum = widget.emailModel != null && !hasChanged
        ? EnumTipoEmailHelper().getEnum(widget.emailModel!.tipoEmail)
        : mainEnum;

    return DropdownButton<EnumTipoEmail>(
      isExpanded: true,
      alignment: Alignment.centerLeft,
      value: mainEnum,
      borderRadius: BorderRadius.circular(20),
      underline: Container(
        height: 2,
        color: Colors.blueAccent,
      ),
      items: EnumTipoEmail.values
          .map<DropdownMenuItem<EnumTipoEmail>>((tipoEmail) {
        return DropdownMenuItem<EnumTipoEmail>(
          value: tipoEmail,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: SizedBox(
                      width: 170,
                      child: Text(tipoEmail.name),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
      onChanged: (EnumTipoEmail? newValue) {
        setState(() {
          mainEnum = newValue!;
          hasChanged = true;
        });
      },
    );
  }
}
