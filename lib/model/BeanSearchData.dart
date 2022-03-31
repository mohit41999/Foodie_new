class BeanSearchData {
  bool? status;
  String? message;
  List<Data>? data;

  BeanSearchData({this.status, this.message, this.data});

  BeanSearchData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  List<RecentSearch>? recentSearch;
  List<Trending>? trending;
  List<KitchenRecommandation>? kitchenRecommandation;

  Data({this.recentSearch, this.trending, this.kitchenRecommandation});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['recent_search'] != null) {
      recentSearch = [];
      print("!@#   ${json['recent_search']}");
      try {
        json['recent_search'].forEach((v) {
          recentSearch!.add(RecentSearch.fromJson(v));
        });
      } catch (e) {
        print(e);
      }
    }
    if (json['trending'] != null) {
      trending = [];
      json['trending'].forEach((v) {
        trending!.add(Trending.fromJson(v));
      });
    }
    if (json['kitchen_recommandation'] != null) {
      kitchenRecommandation = [];
      try {
        json['kitchen_recommandation'].forEach((v) {
          kitchenRecommandation!.add(new KitchenRecommandation.fromJson(v));
        });
      } catch (e) {
        print(json['kitchen_recommandation']);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recentSearch != null) {
      data['recent_search'] =
          this.recentSearch!.map((v) => v.toJson()).toList();
    }
    if (this.trending != null) {
      data['trending'] = this.trending!.map((v) => v.toJson()).toList();
    }
    if (this.kitchenRecommandation != null) {
      data['kitchen_recommandation'] =
          this.kitchenRecommandation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecentSearch {
  String? keyword;

  RecentSearch({this.keyword});

  RecentSearch.fromJson(Map<String, dynamic> json) {
    keyword = json['keyword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['keyword'] = this.keyword;
    return data;
  }
}

class Trending {
  String? kitchenname;

  Trending({this.kitchenname});

  Trending.fromJson(Map<String, dynamic> json) {
    kitchenname = json['kitchenname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kitchenname'] = this.kitchenname;
    return data;
  }
}

class KitchenRecommandation {
  String? kitchenId;
  String? kitchenname;

  String? address;
  String? cuisinetype;
  String? mealtype;
  String? discount;
  String? image;
  String? averageRating;
  String? totalReview;
  String? time;
  String? isFavourite;

  KitchenRecommandation(
      {this.kitchenId,
      this.kitchenname,
      this.address,
      this.cuisinetype,
      this.mealtype,
      this.discount,
      this.image,
      this.averageRating,
      this.totalReview,
      this.isFavourite,
      this.time});

  KitchenRecommandation.fromJson(Map<String, dynamic> json) {
    kitchenId = json['kitchen_id'];
    kitchenname = json['kitchenname'];
    address = json['address'];
    cuisinetype = json['cuisinetype'];
    mealtype = json['mealtype'];
    discount = json['discount'];
    image = json['image'];
    isFavourite = json['is_favourite'];
    averageRating = json['average_rating'];
    totalReview = json['total_review'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kitchen_id'] = this.kitchenId;
    data['kitchenname'] = this.kitchenname;
    data['address'] = this.address;
    data['cuisinetype'] = this.cuisinetype;
    data['mealtype'] = this.mealtype;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['is_favourite'] = this.isFavourite;
    data['average_rating'] = this.averageRating;
    data['total_review'] = this.totalReview;
    data['time'] = this.time;
    return data;
  }
}
