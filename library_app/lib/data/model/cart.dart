class Cart {
  String image;
  String name;
  String author;
  double star;
  String description;
  int count;
  int cost;
  String username;
  Cart(
      {this.image,
      this.name,
      this.author,
      this.star,
      this.description,
      this.count,
      this.cost,
      this.username});
}

List<Cart> cartList = [];
