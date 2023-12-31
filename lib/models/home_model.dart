class HomeModel{
  bool status=true;
  HomeDataModel ? data;

 HomeModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    data=HomeDataModel.fromJson(json['data']);
  }
}


class HomeDataModel{
  List<BannerModel>banners=[];
  List<ProductModel>products=[];
  HomeDataModel.fromJson(Map<String,dynamic>json){

 json['banners'].forEach((element)
{
  banners.add(BannerModel.fromJson(element));
});
json['products'].forEach((element)
{
  products.add(ProductModel.fromJson(element));
});

  }
}

class BannerModel{
int id=0;
String image='';

BannerModel.fromJson(Map<String,dynamic>json)
{
  //List<dynamic> jjj = json["banners"];
  id=json['id'];
  image=json['image'];
}
}

class ProductModel{
  int id=0;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image='';
  String name='';
  bool inFavorites=true;
  bool inCart=true;

  ProductModel.fromJson(Map<String,dynamic>json){
   id=json['id'];
   price=json['price'];
   oldPrice=json['old_price'];
   discount=json['discount'];
   image=json['image'];
   name=json['name'];
   inFavorites=json['in_favorites'];
   inCart=json['in_cart'];
  }
}