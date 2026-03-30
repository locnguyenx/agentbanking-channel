import 'package:flutter/material.dart';
import 'package:agent_api/agent_api.dart';
import 'package:agentbanking_channel/core/utils/openapi_validators.dart';
import 'package:uuid/uuid.dart';

class JomPayForm extends StatefulWidget {
  final Function(JomPayExternalRequest) onSubmit;

  const JomPayForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _JomPayFormState createState() => _JomPayFormState();
}

class _JomPayFormState extends State<JomPayForm> {
  final _formKey = GlobalKey<FormState>();
  final _billerController = TextEditingController();
  final _ref1Controller = TextEditingController();
  final _ref2Controller = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _billerController,
              decoration: const InputDecoration(
                labelText: 'Biller Code',
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Please enter biller code';
                return OpenApiValidators.regex(v, r'^[0-9]{3,10}$');
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _ref1Controller,
              decoration: const InputDecoration(
                labelText: 'Ref-1 (Account Number)',
                border: OutlineInputBorder(),
              ),
              validator: (v) => OpenApiValidators.length(v, minLen: 5, maxLen: 20),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _ref2Controller,
              decoration: const InputDecoration(
                labelText: 'Ref-2 (Optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount (RM)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (v) => OpenApiValidators.minMax(v, min: 0.01),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final req = JomPayExternalRequest((b) => b
                    ..billerCode = _billerController.text
                    ..ref1 = _ref1Controller.text
                    ..ref2 = _ref2Controller.text.isEmpty ? null : _ref2Controller.text
                    ..amount = num.parse(_amountController.text)
                    ..currency = JomPayExternalRequestCurrencyEnum.MYR
                    ..idempotencyKey = const Uuid().v4()
                  );
                  widget.onSubmit(req);
                }
              },
              child: const Text('PROCEED', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
