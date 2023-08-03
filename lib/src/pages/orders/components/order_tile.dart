import 'package:flutter/material.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/services/ultis_services.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;

  OrderTile({super.key, required this.order});

  final UltisServices ultisServices = UltisServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pedido: ${order.id} '),
              Text(
                ultisServices.formatDateTime(order.createdDateTime),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          children: const [],
        ),
      ),
    );
  }
}