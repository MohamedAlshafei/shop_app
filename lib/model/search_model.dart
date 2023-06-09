class SearchModel {
  bool? status;
  Null message;
  Data? data;

  SearchModel({this.status, this.message, this.data});

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ?  Data.fromJson(json['data']) : null)!;
  }

}

class Data {
  int? currentPage;
  List<Product>? data;
  String? firstPageUrl;
  // int? from;
  int? lastPage;
  String? lastPageUrl;
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  // Data(
  //     {required this.currentPage,
  //     required this.data,
  //     required this.firstPageUrl,
  //     required this.from,
  //     required this.lastPage,
  //     required this.lastPageUrl,
  //     this.nextPageUrl,
  //     required this.path,
  //     required this.perPage,
  //     this.prevPageUrl,
  //     required this.to,
  //     required this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((element) {
        data!.add( Product.fromJson(element));
      });
    }
    firstPageUrl = json['first_page_url'];
    // from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  
}

class Product {
  int? id;
  double? price;
  double? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  // Product(
  //     {this.id,
  //     this.price,
  //     this.oldPrice,
  //     this.discount,
  //     this.image,
  //     this.name,
  //     this.description,
  //     this.images,
  //     this.inFavorites,
  //     this.inCart});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    data['images'] = this.images;
    data['in_favorites'] = this.inFavorites;
    data['in_cart'] = this.inCart;
    return data;
  }
}