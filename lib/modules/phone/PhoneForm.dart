import 'package:fishcount_app/constants/Formatters.dart';
import 'package:fishcount_app/model/PhoneModel.dart';
import 'package:fishcount_app/model/enums/EnumTipoTelefone.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:flutter/material.dart';

import 'PhoneController.dart';

class PhoneForm extends StatefulWidget {
  final PhoneModel? telefoneModel;

  const PhoneForm({
    Key? key,
    this.telefoneModel,
  }) : super(key: key);

  @override
  State<PhoneForm> createState() => _PhoneFormState();
}

class _PhoneFormState extends State<PhoneForm> {
  final TextEditingController _telefoneController = TextEditingController();

  EnumTipoTelefone mainEnum = EnumTipoTelefone.ADICIONAL;
  bool hasChanged = false;

  @override
  Widget build(BuildContext context) {
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
                "Telefone",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 50),
              child: TextFieldWidget(
                controller: _telefoneController,
                hintText: "Telefone",
                labelText: widget.telefoneModel != null ? widget.telefoneModel!.phoneNumber : "",
                prefixIcon: const Icon(Icons.account_balance_wallet_sharp),
                focusedBorderColor: Colors.blueGrey,
                iconColor: Colors.blueGrey,
                obscureText: false,
                inputMask: Formatters.phoneMask,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5, top: 20),
              alignment: Alignment.centerLeft,
              child: const Text("Tipo do Telefone:"),
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
                  buttonText: _resolverSaveOrUpdate(),
                  onPressed: () => _saveTelefone(context)),
            ),
          ],
        ),
      ),
    );
  }

  String _resolverSaveOrUpdate() =>
      widget.telefoneModel != null ? "Atualizar" : "Salvar";

  void _saveTelefone(BuildContext context) {
    PhoneModel telefone = PhoneModel(
      widget.telefoneModel != null ? widget.telefoneModel!.id : null,
      _telefoneController.text,
      mainEnum.name,
    );

    PhoneController().salvarTelefone(context, telefone);
  }

  DropdownButton<EnumTipoTelefone> getSelectTipoEmail(BuildContext context) {
    mainEnum = widget.telefoneModel != null && !hasChanged
        ? EnumTipoTelefoneHelper().getEnum(widget.telefoneModel!.phoneType)
        : mainEnum;

    return DropdownButton<EnumTipoTelefone>(
      isExpanded: true,
      alignment: Alignment.centerLeft,
      value: mainEnum,
      borderRadius: BorderRadius.circular(20),
      underline: Container(
        height: 2,
        color: Colors.blueAccent,
      ),
      items: EnumTipoTelefone.values
          .map<DropdownMenuItem<EnumTipoTelefone>>((tipoEmail) {
        return DropdownMenuItem<EnumTipoTelefone>(
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
      onChanged: (EnumTipoTelefone? newValue) {
        setState(() {
          mainEnum = newValue!;
          hasChanged = true;
        });
      },
    );
  }
}
