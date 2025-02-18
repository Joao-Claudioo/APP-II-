import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/modules/insert_boleto/insert_boleto_controller.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/input_text/input_text_widget.dart';
import 'package:payflow/shared/widgets/set_buttons/set_label_button.dart';

class InsertBoleto extends StatefulWidget {
  const InsertBoleto({ Key? key}) : super(key: key);

  @override
  _InsertBoletoState createState() => _InsertBoletoState();
}

class _InsertBoletoState extends State<InsertBoleto> {
  final controller = InsertBoletoController();

  final moneyInputTextController = MoneyMaskedTextController(
    leftSymbol: "R\$", decimalSeparator: ",");

  final dueDateInputTextController = MaskedTextController(mask: "00/00/0000");
  final barcodeInputTextController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(color: AppColors.input,),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 93, vertical: 24),
              child: Text(
              "Preencher os dados do boleto",
              style: TextStyles.titleBoldHeading,
              textAlign: TextAlign.center,
              ),
            ),
            Form(
              key: controller.formKey,
              child: Column(children: [InputTextWidget(
              label: "Nome do boleto",
              icon: Icons.description_outlined,
              validator: controller.validateName,
              onChanged: (value) {
                controller.onChanged(name: value);
                },
            ),
            InputTextWidget(
              controller: dueDateInputTextController,
              label: "Vencimento",
              icon: FontAwesomeIcons.timesCircle,
              validator: controller.validateVencimento,
              onChanged: (value) {
                controller.onChanged(dueDate: value);
              },
            ),
            InputTextWidget(
              controller: moneyInputTextController,
              label: "Valor",
              icon: FontAwesomeIcons.wallet,
              validator: (_) => controller.validateValor(moneyInputTextController.numberValue),
              onChanged: (value) {
                controller.onChanged(
                  value: moneyInputTextController.numberValue);
                },
            ),
            InputTextWidget(
              controller: barcodeInputTextController,
              label: "Código",
              icon: FontAwesomeIcons.barcode,
              validator: controller.validateCodigo,
              onChanged: (value) {
                controller.onChanged(
                  barcode: value);
                  },
            )],))
          ],
        ),
      ),
    bottomNavigationBar: SetLabelButtons(
    enableSecondaryColor: true,
    labelPrimary: "Cancelar", 
    onTapPrimary: () {
      Navigator.pop(context);
    }, 
    labelSecondary: "Cadastrar", 
    onTapSecondary: () async {
      await controller.cadastrarBoleto();
      Navigator.pop(context);
    },
    ),
    );
  }
} 