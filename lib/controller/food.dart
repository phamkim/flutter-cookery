class Food extends CookStep {
  String name;
  String img;
  String level;
  String title;
  String des;
  List<CookStep> cookSteps;
  var time;
  Food({
    this.img,
    this.name,
    this.time,
    this.title,
    this.level,
    this.cookSteps,
    this.des,
  });
  factory Food.fromJson(Map<dynamic, dynamic> json) {
    final resultJson = json['cook_steps'];
    final parsed = resultJson.cast<Map<String, dynamic>>();
    return Food(
        level: json['level'] ?? '',
        name: json['name'] ?? '',
        title: json['title'] ?? '',
        img: json['img'] ?? '',
        time: json['time'] ?? '',
        des: json['des'] ?? '',
        cookSteps:
            parsed.map<CookStep>((json) => CookStep.fromJson(json)).toList());
  }
}

class Component {
  String name;
  String quantity;
  String unit;
  Component({
    this.name,
    this.quantity,
    this.unit,
  });
  factory Component.fromJson(Map<dynamic, dynamic> json) {
    return Component(
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? '',
      unit: json['unit'] ?? '',
    );
  }
}

class CookStep {
  int step;
  String des;
  List pictures;
  CookStep({
    this.pictures,
    this.step,
    this.des,
  });
  factory CookStep.fromJson(Map<dynamic, dynamic> json) {
    return CookStep(
      pictures: json['pictures'] ?? '',
      step: json['step'] ?? '',
      des: json['des'] ?? '',
    );
  }
}
