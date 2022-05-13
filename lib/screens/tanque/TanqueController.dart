import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/constants/exceptions/ExceptionsMessage.dart';
import 'package:fishcount_app/screens/generic/AbstractController.dart';
import 'package:fishcount_app/screens/tanque/TanqueForm.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../model/TanqueModel.dart';

class TanqueController extends AbstractController {
  Widget resolverListaTanques(
      BuildContext context, AsyncSnapshot<List<TanqueModel>> snapshot) {
    if (onHasValue(snapshot)) {
      return _listaTanques(context, snapshot.data!);
    }
    if (onDoneRequestWithEmptyValue(snapshot)) {
      return getNotFoundWidget(context, ExceptionsMessage.usuarioSemTanque,
          AppPaths.cadastroTanquePath);
    }
    if (onError(snapshot)) {
      return getDefaultErrorMessage(context, ExceptionsMessage.serverError);
    }
    return getCircularProgressIndicator();
  }

  Widget _listaTanques(BuildContext context, List<TanqueModel> tanques) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.7,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: tanques.length,
          itemBuilder: (context, index) {
            TanqueModel tanque = tanques[index];
            return Container(
              margin: const EdgeInsets.only(top: 15),
              alignment: Alignment.center,
              height: 70,
              decoration: const BoxDecoration(
                //  borderRadius: BorderRadius.circular(10),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                  left: BorderSide(
                    color: Colors.black26,
                  ),
                  right: BorderSide(
                    color: Colors.black26,
                  ),
                  top: BorderSide(
                    color: Colors.black26,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            /*  NavigatorUtils.pushReplacement(
                              context,
                              (
                                lote: tanque,
                              ),
                            );*/
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: Text(
                              tanque.descricao.toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        /*Container(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            tanque.!.length.toString() + " Tanques",
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),*/
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          right: 7,
                          top: 12,
                          bottom: 12,
                        ),
                        width: 30,
                        decoration: const BoxDecoration(
                          //color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          child: const Icon(
                            LineIcons.edit,
                            color: Colors.black,
                            size: 25,
                          ),
                          onTap: () {
                            NavigatorUtils.push(
                              context,
                              TanqueForm(
                                tanque: tanque,
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          right: 6,
                          top: 12,
                          bottom: 12,
                        ),
                        width: 30,
                        decoration: const BoxDecoration(
                          //color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          child: const Icon(
                            LineIcons.trash,
                            color: Colors.red,
                            size: 25,
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
