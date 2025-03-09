import 'package:flutter/material.dart';

class medioPago extends StatelessWidget {
  const medioPago({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medio de Pago'),
        backgroundColor: Colors.red[300],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Opción de Tarjeta de Crédito o Débito
          ListTile(
            leading: Icon(Icons.credit_card, color: Colors.red[400]),
            title: const Text(
              'Tarjeta de Crédito o Débito',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Acción para seleccionar este método de pago
            },
            tileColor: Colors.red[50],
          ),
          const Divider(),
          // Opción de PayPal
          ListTile(
            leading: const Icon(Icons.account_balance_wallet, color: Colors.red),
            title: const Text(
              'PayPal',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Acción para seleccionar PayPal
            },
          ),
          const Divider(),
          // Opción de Transferencia Bancaria
          ListTile(
            leading: const Icon(Icons.account_balance, color: Colors.red),
            title: const Text(
              'Transferencia Bancaria',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Acción para seleccionar Transferencia Bancaria
            },
          ),
        ],
      ),
    );
  }
}
