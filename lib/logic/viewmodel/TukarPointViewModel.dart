import 'package:flutter/material.dart';
import 'package:bpulsa/model/TukarPointModel.dart';

class TukarPointViewModel {
  
  List<TukarPointModel> productsItems;

  TukarPointViewModel({this.productsItems});

  getTukarPoints() => <TukarPointModel>[
        TukarPointModel(
            brand: "Levis",
            description: "Print T-shirt",
            image:
                "https://mosaic02.ztat.net/vgs/media/pdp-zoom/LE/22/1D/02/2A/12/LE221D022-A12@16.1.jpg",
            name: "THE PERFECT hubla",
            price: "£19.99",
            rating: 4.0,
            quantity: 0,
        ),
        TukarPointModel(
          brand: "adidas Performance",
          description: "Pool sliders",
          image:
              "https://mosaic02.ztat.net/vgs/media/catalog-lg/AD/58/1D/00/9Q/12/AD581D009-Q12@13.jpg",
          name: "AQUALETTE",
          price: "£13.49",
          rating: 5.0,
        ),
       
      ];
}
