class Order {
  String image;
  String name;
  String author;
  double star;
  String registrationDate;
  String expirationDate;
  int status;
  int count;
  int cost;
  String username;
  Order({
    this.image,
    this.name,
    this.author,
    this.star,
    this.registrationDate,
    this.expirationDate,
    this.status,
    this.count,
    this.cost,
    this.username,
  });
}

List<Order> orderList = [];
