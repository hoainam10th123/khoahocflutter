
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget{

  buildImageAvarta(){
    return const AssetImage('assets/images/user.png');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: buildImageAvarta(),
                maxRadius: 25,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nguyen Hoai Nam Nguyen Hoai Nam Nguyen Hoai Nam',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,),
                      Row(
                        children: [
                          Text('1 minute ago'),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(Icons.public, size: 15,)
                        ],
                      )
                    ],
                  )
              ),

            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                child: RichText(
                  text: TextSpan(
                    text:'acccccccccccccccc',
                    style: DefaultTextStyle.of(context).style,
                  ),
                ),
              )

            ],
          )
        ],
      ),
    );
  }
}