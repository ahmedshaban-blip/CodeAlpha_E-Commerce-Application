class ProductModel {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  double? rate; // بدلاً من موديل فرعي
  double? count;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = (json['price'] as num?)?.toDouble();
    description = json['description'];
    category = json['category'];
    image = json['image'];
    count = json['count'] as double?;

    // هنا تفكيك الـ rating مباشرة
    if (json['rating'] != null) {
      rate = (json['rating']['rate'] as num?)?.toDouble();
      count = (json['count'] as num?)?.toDouble();
    }
  }
}


  /*
 {
        "id": 1,
        "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
        "price": 109.95,
        "description": "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
        "category": "men's clothing",
        "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
        "rating": {
            "rate": 3.9,
            "count": 120
        }
    },
    
 
 */

