// To parse this JSON data, do
//
//     final heroes = heroesFromMap(jsonString);

import 'dart:convert';

class Heroes {
  Heroes({
    this.name,
    this.shortName,
    this.attributeId,
    this.translations,
    this.role,
    this.type,
    this.releaseDate,
    this.iconUrl,
    this.abilities,
    this.talents,
  });

  String name;
  String shortName;
  String attributeId;
  List<String> translations;
  Role role;
  Type type;
  DateTime releaseDate;
  HeroIconUrl iconUrl;
  List<Ability> abilities;
  List<Talent> talents;

  factory Heroes.fromJson(String str) => Heroes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  // Map<String, dynamic> mapToJson() {
  //   var translationsEncode =
  //       jsonEncode(List<dynamic>.from(translations.map((x) => x)));
  //   var iconUrlEncode = jsonEncode(iconUrl.toMap());
  //   var abilitiesEncode = List<dynamic>.from(abilities.map((x) => x.toMap()));
  //   return {
  //     "name": name == null ? null : name,
  //     "short_name": shortName == null ? null : shortName,
  //     "attribute_id": attributeId == null ? null : attributeId,
  //     "translations": translations == null ? null : translationsEncode,
  //     "role": role == null ? null : roleValues.reverse[role],
  //     "type": type == null ? null : typeValues.reverse[type],
  //     "release_date": releaseDate == null
  //         ? null
  //         : "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
  //     "icon_url": iconUrl == null ? null : iconUrlEncode, // iconUrl.toMap(),
  //     "abilities": abilities == null ? null : abilitiesEncode,
  //     // "talents": talents == null ? null : List<dynamic>.from(talents.map((x) => x.toMap())),
  //   };
  // }

  factory Heroes.fromDb(Map<String, dynamic> json) {
    var translationsDecode =
        List<String>.from(jsonDecode(json["translations"]));
    var iconUrlMap = json["icon_url"] == null
        ? null
        : HeroIconUrl.fromMap(jsonDecode(json["icon_url"]));

    var abilitiesData = jsonDecode(json["abilities"]);
    List<Ability> abilitiesMap = List<Ability>();
    for (var perMap in abilitiesData) {
      abilitiesMap.add(Ability.fromJson(perMap));
    }

    var talentsData = jsonDecode(json["talents"]);
    List<Talent> talentsMap = List<Talent>();
    for(var perTalent in talentsData){
      talentsMap.add(Talent.fromJson(perTalent));
    }
    // var talentsData = json["talents"] == null
    //     ? null
    //     : List<Talent>.from(json["talents"].map((x) => Talent.fromMap(x)));

    return Heroes(
      name: json["name"] == null ? null : json["name"],
      shortName: json["short_name"] == null ? null : json["short_name"],
      attributeId: json["attribute_id"] == null ? null : json["attribute_id"],
      translations: json["translations"] == null ? null : translationsDecode,
      iconUrl: iconUrlMap,
      abilities: abilitiesMap,
      talents: talentsMap,
    );
  }

  factory Heroes.fromMap(Map<String, dynamic> json) {
    var translationsMap = json["translations"] == null
        ? null
        : List<String>.from(json["translations"].map((x) => x));
    var iconUrlMap =
        json["icon_url"] == null ? null : HeroIconUrl.fromMap(json["icon_url"]);
    var releaseDateMap = json["release_date"] == null
        ? null
        : DateTime.parse(json["release_date"]);
    var abilitiesMap = json["abilities"] == null
        ? null
        : List<Ability>.from(json["abilities"].map((x) => Ability.fromMap(x)));
    var talentsMap = json["talents"] == null
        ? null
        : List<Talent>.from(json["talents"].map((x) => Talent.fromMap(x)));
    return Heroes(
      name: json["name"] == null ? null : json["name"],
      shortName: json["short_name"] == null ? null : json["short_name"],
      attributeId: json["attribute_id"] == null ? null : json["attribute_id"],
      translations: translationsMap,
      role: json["role"] == null ? null : roleValues.map[json["role"]],
      type: json["type"] == null ? null : typeValues.map[json["type"]],
      releaseDate: releaseDateMap,
      iconUrl: iconUrlMap,
      abilities: abilitiesMap,
      talents: talentsMap,
    );
  }

  Map<String, dynamic> toMap() {
    var translationsEncode = translations == null
        ? null
        : jsonEncode(List<dynamic>.from(translations.map((x) => x)));
    var iconUrlEncode = iconUrl == null ? null : jsonEncode(iconUrl.toMap());
    var abilitiesEncode = abilities == null
        ? null
        : jsonEncode(
            List<dynamic>.from(abilities.map((x) => jsonEncode(x.toMap()))));
    var talentsEncode = talents == null
        ? null
        : jsonEncode(
            List<dynamic>.from(talents.map((x) => jsonEncode(x.toMap()))));
    return {
      "name": name == null ? null : name,
      "short_name": shortName == null ? null : shortName,
      "attribute_id": attributeId == null ? null : attributeId,
      "translations": translationsEncode,
      "role": role == null ? null : roleValues.reverse[role],
      "type": type == null ? null : typeValues.reverse[type],
      "release_date": releaseDate == null
          ? null
          : "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
      "icon_url": iconUrlEncode,
      "abilities": abilitiesEncode,
      "talents": talentsEncode,
    };
  }
}

class Ability {
  Ability({
    this.owner,
    this.name,
    this.title,
    this.description,
    this.icon,
    this.hotkey,
    this.cooldown,
    this.manaCost,
    this.trait,
  });

  String owner;
  String name;
  String title;
  String description;
  dynamic icon;
  String hotkey;
  int cooldown;
  int manaCost;
  bool trait;

  factory Ability.fromJson(String str) => Ability.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ability.fromDb(Map<String, dynamic> json) => Ability(
        owner: json["owner"] == null ? null : jsonDecode(json["owner"]),
        name: json["name"] == null ? null : jsonDecode(json["name"]),
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        icon: json["icon"],
        hotkey: json["hotkey"] == null ? null : json["hotkey"],
        cooldown: json["cooldown"] == null ? null : json["cooldown"],
        manaCost: json["mana_cost"] == null ? null : json["mana_cost"],
        trait: json["trait"] == null ? null : json["trait"],
      );

  factory Ability.fromMap(Map<String, dynamic> json) => Ability(
        owner: json["owner"] == null ? null : json["owner"],
        name: json["name"] == null ? null : json["name"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        icon: json["icon"],
        hotkey: json["hotkey"] == null ? null : json["hotkey"],
        cooldown: json["cooldown"] == null ? null : json["cooldown"],
        manaCost: json["mana_cost"] == null ? null : json["mana_cost"],
        trait: json["trait"] == null ? null : json["trait"],
      );

  Map<String, dynamic> toMap() => {
        "owner": owner == null ? null : owner,
        "name": name == null ? null : name,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "icon": icon,
        "hotkey": hotkey == null ? null : hotkey,
        "cooldown": cooldown == null ? null : cooldown,
        "mana_cost": manaCost == null ? null : manaCost,
        "trait": trait == null ? null : trait,
      };
}

class HeroIconUrl {
  HeroIconUrl({
    this.the92X93,
  });

  String the92X93;

  factory HeroIconUrl.fromJson(String str) =>
      HeroIconUrl.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HeroIconUrl.fromMap(Map<String, dynamic> json) => HeroIconUrl(
        the92X93: json["92x93"] == null ? null : json["92x93"],
      );

  Map<String, dynamic> toMap() => {
        "92x93": the92X93 == null ? null : the92X93,
      };
}

enum Role { SPECIALIST, ASSASSIN, WARRIOR, SUPPORT, MULTICLASS }

final roleValues = EnumValues({
  "Assassin": Role.ASSASSIN,
  "Multiclass": Role.MULTICLASS,
  "Specialist": Role.SPECIALIST,
  "Support": Role.SUPPORT,
  "Warrior": Role.WARRIOR
});

class Talent {
  Talent({
    this.name,
    this.title,
    this.description,
    this.icon,
    this.iconUrl,
    this.ability,
    this.sort,
    this.cooldown,
    this.manaCost,
    this.level,
  });

  String name;
  String title;
  String description;
  String icon;
  TalentIconUrl iconUrl;
  String ability;
  int sort;
  int cooldown;
  dynamic manaCost;
  int level;

  factory Talent.fromJson(String str) => Talent.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Talent.fromMap(Map<String, dynamic> json) => Talent(
        name: json["name"] == null ? null : json["name"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        icon: json["icon"] == null ? null : json["icon"],
        iconUrl: json["icon_url"] == null
            ? null
            : TalentIconUrl.fromMap(json["icon_url"]),
        ability: json["ability"] == null ? null : json["ability"],
        sort: json["sort"] == null ? null : json["sort"],
        cooldown: json["cooldown"] == null ? null : json["cooldown"],
        manaCost: json["mana_cost"],
        level: json["level"] == null ? null : json["level"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "icon": icon == null ? null : icon,
        "icon_url": iconUrl == null ? null : iconUrl.toMap(),
        "ability": ability == null ? null : ability,
        "sort": sort == null ? null : sort,
        "cooldown": cooldown == null ? null : cooldown,
        "mana_cost": manaCost,
        "level": level == null ? null : level,
      };
}

class TalentIconUrl {
  TalentIconUrl({
    this.the64X64,
  });

  String the64X64;

  factory TalentIconUrl.fromJson(String str) =>
      TalentIconUrl.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TalentIconUrl.fromMap(Map<String, dynamic> json) => TalentIconUrl(
        the64X64: json["64x64"] == null ? null : json["64x64"],
      );

  Map<String, dynamic> toMap() => {
        "64x64": the64X64 == null ? null : the64X64,
      };
}

enum Type { MELEE, RANGED }

final typeValues = EnumValues({"Melee": Type.MELEE, "Ranged": Type.RANGED});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
