import 'package:orders_accountant/app/widgets/progress_bar.dart';
import 'package:orders_accountant/core/constants/common_libs.dart';
import 'package:orders_accountant/domain/models/order.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({
    Key? key,
    required this.orders,
  }) : super(key: key);

  final List<Order> orders;

  double get sum {
    double sum = 0;
    for (int i = 0; i < orders.length; i++) {
      sum += orders[i].price;
    }
    return sum;
  }

  double get revenue {
    double revenue = 0;
    for (int i = 0; i < orders.length; i++) {
      revenue += orders[i].revenue;
    }
    return revenue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListCard(orders: orders, title: ''),
        Container(height: 16),
        _buildSum(),
        Container(height: 16),
      ],
    );
  }

  _buildSum() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Виручка за день: ',
                    style: textStyles.bodySmall.semiBold.c(colors.steelGrey),
                  ),
                ),
                Text(
                  ' ${sum.toStringAsFixed(2)} грн',
                  style: textStyles.body,
                ),
              ],
            ),
            Container(height: 4),
            Container(height: 1, color: colors.greyMedium),
            Container(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Прибуток за день:',
                    style: textStyles.bodySmall.semiBold.c(colors.steelGrey),
                  ),
                ),
                Text(
                  '${revenue.toStringAsFixed(2)} грн',
                  style: textStyles.bodySmall,
                ),
              ],
            ),
            Container(height: 4),
            Container(height: 1, color: colors.greyMedium),
            Container(height: 4),
          ],
        ));
  }
}

class ListCard extends StatelessWidget {
  const ListCard({
    super.key,
    required this.orders,
    required this.title,
  });

  final List<Order> orders;
  final String title;

  @override
  Widget build(BuildContext context) {
    final Color paintColor = colors.steelGrey;

    final length = orders.length;

    //find max price to build percentages

    orders.sort((a, b) => (a.createdAt.compareTo(b.createdAt)));

    double maxPrice = 0;
    for (int i = 0; i < orders.length; i++) {
      if (orders[i].price > maxPrice) maxPrice = orders[i].price;
    }

    return RepaintBoundary(
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: colors.greyMedium,
                spreadRadius: 3,
                blurRadius: 12,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          //height: 332,
          width: double.infinity,
          child: IntrinsicHeight(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  //height: double.infinity,
                  decoration: BoxDecoration(
                      color: colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                      border: Border.all(color: colors.greyMedium, width: 1)),
                  child: Column(
                    children: [
                      Container(
                        height: 52,
                      ),
                      if (length == 0)
                        Container(
                            alignment: Alignment.topLeft,
                            height: 80,
                            padding: const EdgeInsets.only(top: 29, left: 39),
                            child: Text('...список пустий',
                                style: textStyles.body)),
                      for (int i = 0; i < orders.length; i++)
                        OrderItem(
                            order: orders.elementAt(i),
                            progress:
                                (orders.elementAt(i).price / maxPrice) * 100),
                      Container(height: 24)
                    ],
                  ),
                ),
                Container(
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: paintColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(child: SizedBox()),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: colors.midnightBlue.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(8)),
                          child: Container(
                            height: 21,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                                color: colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: colors.white,
                                    spreadRadius: 3,
                                    blurRadius: 3,
                                    offset: const Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ]),
                            alignment: Alignment.center,
                            child: Text('0 / 0',
                                style:
                                    textStyles.bodySmall.c(colors.steelGrey)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,
    required this.order,
    required this.progress,
  });

  final Order order;
  final double progress;

  @override
  Widget build(BuildContext context) {
    late Color color;
    switch (order.status) {
      case OrderStatus.completed:
        color = colors.steelGrey;
        break;
      case OrderStatus.pending:
        color = colors.lavenderGrey;
        break;
      default:
        colors.lavenderGrey;
    }

    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            height: 42.25,
            child: Row(
              children: [
                Text(
                    order.customer.isEmpty
                        ? 'Замовлення №${order.id}'
                        : order.customer,
                    style: textStyles.body.c(color)),
                Expanded(child: Container()),
                Text(
                  '${order.price} грн',
                  style: textStyles.body,
                )
              ],
            ),
          ),
          ProgressBar(
              maxPoints: 100,
              livePoints: progress,
              color: color,
              secondColor: colors.greyMedium,
              width: 1.75),
        ],
      ),
    );
  }
}
