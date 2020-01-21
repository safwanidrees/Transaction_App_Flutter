import 'package:flutter/material.dart';


class ChartBar extends StatelessWidget {
  final String label; //weed day
  final double spendingAmount;
  final double spendingPctOfTotal; //percentage of tootal amount

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    
    return LayoutBuilder(builder: (ctx, constraints){
       return Column(
        children: <Widget>[
          //fittedbox can wrap the text in small size if it is big
          Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                  child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
          SizedBox(
            height:  constraints.maxHeight * 0.05,
          ), //space between them
          Container(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              //stack widget allow to place element of top of each overlapping each other
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 20,
                      ),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(20)),
                ),
                FractionallySizedBox(
                  //it is same as container but its allow us to change heigth fractionally
                  heightFactor: spendingPctOfTotal, //it shpow percentagge
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(child: Text(label)))
          // FittedBox(
          //   child: Text('\$${spendingAmount.toStringAsFixed(0)}'),  //it show no decimal places
          // ),
          // SizedBox(
          //   height: 4,
          // ),
          // Container(
          //   height: 60,
          //   width: 10,
          //   child: Stack(
          //     children: <Widget>[
          //       Container(
          //         decoration: BoxDecoration(
          //           border: Border.all(color: Colors.grey, width: 1.0),
          //           color: Color.fromRGBO(220, 220, 220, 1),
          //           borderRadius: BorderRadius.circular(10),
          //         ),
          //       ),
          //       FractionallySizedBox(
          //         heightFactor: spendingPctOfTotal,
          //         child: Container(
          //           decoration: BoxDecoration(
          //             color: Theme.of(context).primaryColor,
          //             borderRadius: BorderRadius.circular(10),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: 4,
          // ),
          // Text(label),
        ],
      );
    },);
   
  }
}
