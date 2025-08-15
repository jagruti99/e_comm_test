class Product {
  int? status;
  String? message;
  Data? data;

  Product({this.status, this.message, this.data});

  Product.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? sku;
  int? isReturn;
  int? celebrityId;
  String? name;
  String? attributeSetId;
  String? price;
  String? finalPrice;
  String? status;
  String? type;
  String? webUrl;
  String? brandName;
  String? brand;
  int? isFollowingBrand;
  String? brandBannerUrl;
  bool? isSalable;
  int? isNew;
  int? isSale;
  int? isTrending;
  int? isBestSeller;
  String? image;
  String? createdAt;
  String? updatedAt;
  dynamic weight;
  String? description;
  dynamic shortDescription;
  dynamic howToUse;
  dynamic manufacturer;
  dynamic keyIngredients;
  dynamic returnsAndExchanges;
  dynamic shippingAndDelivery;
  dynamic aboutTheBrand;
  String? metaTitle;
  dynamic metaKeyword;
  String? metaDescription;
  dynamic sizeChart;
  int? wishlistItemId;
  String? hasOptions;
  List<dynamic>? options;
  List<dynamic>? bundleOptions;
  List<ConfigurableOption>? configurableOption;
  int? remainingQty;
  List<String>? images;
  List<dynamic>? upsell;
  List<dynamic>? related;
  Review? review;

  Data({
    this.id,
    this.sku,
    this.isReturn,
    this.celebrityId,
    this.name,
    this.attributeSetId,
    this.price,
    this.finalPrice,
    this.status,
    this.type,
    this.webUrl,
    this.brandName,
    this.brand,
    this.isFollowingBrand,
    this.brandBannerUrl,
    this.isSalable,
    this.isNew,
    this.isSale,
    this.isTrending,
    this.isBestSeller,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.weight,
    this.description,
    this.shortDescription,
    this.howToUse,
    this.manufacturer,
    this.keyIngredients,
    this.returnsAndExchanges,
    this.shippingAndDelivery,
    this.aboutTheBrand,
    this.metaTitle,
    this.metaKeyword,
    this.metaDescription,
    this.sizeChart,
    this.wishlistItemId,
    this.hasOptions,
    this.options,
    this.bundleOptions,
    this.configurableOption,
    this.remainingQty,
    this.images,
    this.upsell,
    this.related,
    this.review,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    isReturn = json['is_return'];
    celebrityId = json['celebrity_id'];
    name = json['name'];
    attributeSetId = json['attribute_set_id'];
    price = json['price'];
    finalPrice = json['final_price'];
    status = json['status'];
    type = json['type'];
    webUrl = json['web_url'];
    brandName = json['brand_name'];
    brand = json['brand'];
    isFollowingBrand = json['is_following_brand'];
    brandBannerUrl = json['brand_banner_url'];
    isSalable = json['is_salable'];
    isNew = json['is_new'];
    isSale = json['is_sale'];
    isTrending = json['is_trending'];
    isBestSeller = json['is_best_seller'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    weight = json['weight'];
    description = json['description'];
    shortDescription = json['short_description'];
    howToUse = json['how_to_use'];
    manufacturer = json['manufacturer'];
    keyIngredients = json['key_ingredients'];
    returnsAndExchanges = json['returns_and_exchanges'];
    shippingAndDelivery = json['shipping_and_delivery'];
    aboutTheBrand = json['about_the_brand'];
    metaTitle = json['meta_title'];
    metaKeyword = json['meta_keyword'];
    metaDescription = json['meta_description'];
    sizeChart = json['size_chart'];
    wishlistItemId = json['wishlist_item_id'];
    hasOptions = json['has_options'];
    options = json['options'] ?? [];
    bundleOptions = json['bundle_options'] ?? [];
    if (json['configurable_option'] != null) {
      configurableOption = <ConfigurableOption>[];
      json['configurable_option'].forEach((v) {
        configurableOption!.add(ConfigurableOption.fromJson(v));
      });
    }
    remainingQty = json['remaining_qty'];
    images = json['images'] != null ? List<String>.from(json['images']) : [];
    upsell = json['upsell'] ?? [];
    related = json['related'] ?? [];
    review = json['review'] != null ? Review.fromJson(json['review']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sku'] = sku;
    data['is_return'] = isReturn;
    data['celebrity_id'] = celebrityId;
    data['name'] = name;
    data['attribute_set_id'] = attributeSetId;
    data['price'] = price;
    data['final_price'] = finalPrice;
    data['status'] = status;
    data['type'] = type;
    data['web_url'] = webUrl;
    data['brand_name'] = brandName;
    data['brand'] = brand;
    data['is_following_brand'] = isFollowingBrand;
    data['brand_banner_url'] = brandBannerUrl;
    data['is_salable'] = isSalable;
    data['is_new'] = isNew;
    data['is_sale'] = isSale;
    data['is_trending'] = isTrending;
    data['is_best_seller'] = isBestSeller;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['weight'] = weight;
    data['description'] = description;
    data['short_description'] = shortDescription;
    data['how_to_use'] = howToUse;
    data['manufacturer'] = manufacturer;
    data['key_ingredients'] = keyIngredients;
    data['returns_and_exchanges'] = returnsAndExchanges;
    data['shipping_and_delivery'] = shippingAndDelivery;
    data['about_the_brand'] = aboutTheBrand;
    data['meta_title'] = metaTitle;
    data['meta_keyword'] = metaKeyword;
    data['meta_description'] = metaDescription;
    data['size_chart'] = sizeChart;
    data['wishlist_item_id'] = wishlistItemId;
    data['has_options'] = hasOptions;
    data['options'] = options;
    data['bundle_options'] = bundleOptions;
    if (configurableOption != null) {
      data['configurable_option'] =
          configurableOption!.map((v) => v.toJson()).toList();
    }
    data['remaining_qty'] = remainingQty;
    data['images'] = images;
    data['upsell'] = upsell;
    data['related'] = related;
    if (review != null) {
      data['review'] = review!.toJson();
    }
    return data;
  }
}

class ConfigurableOption {
  int? attributeId;
  String? type;
  String? attributeCode;
  List<Attributes>? attributes;

  ConfigurableOption({
    this.attributeId,
    this.type,
    this.attributeCode,
    this.attributes,
  });

  ConfigurableOption.fromJson(Map<String, dynamic> json) {
    attributeId = json['attribute_id'];
    type = json['type'];
    attributeCode = json['attribute_code'];
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(Attributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attribute_id'] = attributeId;
    data['type'] = type;
    data['attribute_code'] = attributeCode;
    if (attributes != null) {
      data['attributes'] = attributes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attributes {
  String? value;
  String? optionId;
  String? attributeImageUrl;
  String? price;
  List<String>? images;
  dynamic colorCode;
  String? swatchUrl;

  Attributes({
    this.value,
    this.optionId,
    this.attributeImageUrl,
    this.price,
    this.images,
    this.colorCode,
    this.swatchUrl,
  });

  Attributes.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    optionId = json['option_id'];
    attributeImageUrl = json['attribute_image_url'];
    price = json['price'];
    images = json['images'].cast<String>();
    colorCode = json['color_code'];
    swatchUrl = json['swatch_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['option_id'] = optionId;
    data['attribute_image_url'] = attributeImageUrl;
    data['price'] = price;
    data['images'] = images;
    data['color_code'] = colorCode;
    data['swatch_url'] = swatchUrl;
    return data;
  }
}

class Review {
  int? totalReview;
  int? ratingCount;

  Review({this.totalReview, this.ratingCount});

  Review.fromJson(Map<String, dynamic> json) {
    totalReview = json['total_review'];
    ratingCount = json['rating_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_review'] = totalReview;
    data['rating_count'] = ratingCount;
    return data;
  }
}
