class MyModel{
final List <dynamic> exchange;
  final dynamic id, name, price, website, createdAt, description, logoUrl;

  MyModel(
      this.id,
      this.name,
      this.price,
      this.website,
      this.createdAt,
      this.description,
      this.logoUrl,
      this.exchange,
      );

}


class SelectedCoinModel{

  final dynamic price, createdAt;

  SelectedCoinModel(

      this.price,
      this.createdAt,
      );

}