import 'package:flutter/material.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/orders/components/order_status_widget.dart';
import 'package:greengrocer/src/services/ultis_services.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;

  OrderTile({super.key, required this.order});

  final UtilsServices ultisServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: order.status == 'pending_payment' &&
              order.overdueDateTime.isAfter(DateTime.now()),
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
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  // items do pedido
                  Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 150,
                        child: ListView(
                            children: order.items.map((orderItem) {
                          return _OrderItemWidget(
                            ultisServices: ultisServices,
                            orderItem: orderItem,
                          );
                        }).toList()),
                      )),

                  // espaço entre eles
                  VerticalDivider(
                    color: Colors.grey.shade300,
                    thickness: 2,
                    width: 8,
                  ),

                  // Status do pedido
                  Expanded(
                      flex: 2,
                      child: OrderStatusWidget(
                        // validando se a data é antes da que esta hoje
                        isOverdue:
                            order.overdueDateTime.isBefore(DateTime.now()),
                        status: order.status,
                      )),
                ],
              ),
            ),

            // Total
            Text.rich(
              TextSpan(
                style: const TextStyle(
                  fontSize: 20,
                ),
                children: [
                  const TextSpan(
                    text: 'Total ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ultisServices.priceToCurrency(order.total),
                  ),
                ],
              ),
            ),

            // botão de pagamento
            Visibility(
              visible: order.status == 'pending_payment' &&
                  order.overdueDateTime.isAfter(DateTime.now()),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Image.asset(
                  'assets/app_images/pix.png',
                  height: 18,
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                label: const Text('Ver QR Code Pix'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _OrderItemWidget extends StatelessWidget {
  const _OrderItemWidget({
    required this.ultisServices,
    required this.orderItem,
  });

  final UtilsServices ultisServices;
  final CartItemModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Text(
            '${orderItem.quantity} ${orderItem.item.unit} ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: Text(orderItem.item.itemName)),
          Text(
            ultisServices.priceToCurrency(
              orderItem.totalPrice(),
            ),
          ),
        ],
      ),
    );
  }
}
