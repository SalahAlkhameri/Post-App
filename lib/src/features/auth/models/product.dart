



class Product{
  int? id;
  String? title;
  String? description;

  Product.f({
    required this.id,
    required this.title,
    required this.description,
  });
  Product(Map<String,dynamic> item){
    id=item["id"];
    title=item["title"];
    description=item["description"];
  }
  factory Product.fromJson(Map<String, dynamic> json) => Product.f(
    id: json['id'],
    title: json['name'],
    description: json['price'],
  );
  // Product.add(String this.title, String this.description);


  Map<String, dynamic> toJson() => {
    'id': id,
    'name': title,
    'description': description,
  };

  // factory Product.fromJson(Map<String, dynamic> json) {
  //   return  Product.f(
  //     id: json['id'],
  //     title: json['name'],
  //     description: json['description'],
  //   );
  }

// }







