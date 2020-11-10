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
    Map<String, dynamic> iconUrl;
    List<Ability> abilities;
    List<Talent> talents;

    factory Heroes.fromJson(String str) => Heroes.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Heroes.fromMap(Map<String, dynamic> json) => Heroes(
        name: json["name"],
        shortName: json["short_name"],
        attributeId: json["attribute_id"],
        translations: List<String>.from(json["translations"].map((x) => x)),
        role: roleValues.map[json["role"]],
        type: typeValues.map[json["type"]],
        releaseDate: DateTime.parse(json["release_date"]),
        iconUrl: json["icon_url"].values.toList(),
        abilities: List<Ability>.from(json["abilities"].map((x) => Ability.fromMap(x))),
        talents: List<Talent>.from(json["talents"].map((x) => Talent.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "short_name": shortName,
        "attribute_id": attributeId,
        "translations": List<dynamic>.from(translations.map((x) => x)),
        "role": roleValues.reverse[role],
        "type": typeValues.reverse[type],
        "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "icon_url": iconUrl,
        "abilities": List<dynamic>.from(abilities.map((x) => x.toMap())),
        "talents": List<dynamic>.from(talents.map((x) => x.toMap())),
    };
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

    factory Ability.fromMap(Map<String, dynamic> json) => Ability(
        owner: json["owner"],
        name: json["name"],
        title: json["title"],
        description: json["description"],
        icon: json["icon"],
        hotkey: json["hotkey"] == null ? null : json["hotkey"],
        cooldown: json["cooldown"] == null ? null : json["cooldown"],
        manaCost: json["mana_cost"] == null ? null : json["mana_cost"],
        trait: json["trait"],
    );

    Map<String, dynamic> toMap() => {
        "owner": owner,
        "name": name,
        "title": title,
        "description": description,
        "icon": icon,
        "hotkey": hotkey == null ? null : hotkey,
        "cooldown": cooldown == null ? null : cooldown,
        "mana_cost": manaCost == null ? null : manaCost,
        "trait": trait,
    };
}

// class HeroIconUrl {
//     HeroIconUrl({
//         this.the92X93,
//     });

//     String the92X93;

//     factory HeroIconUrl.fromJson(String str) => HeroIconUrl.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory HeroIconUrl.fromMap(Map<String, dynamic> json) => HeroIconUrl(
//         the92X93: json["92x93"],
//     );

//     Map<String, dynamic> toMap() => {
//         "92x93": the92X93,
//     };
// }

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
        // this.iconUrl,
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
    // TalentIconUrl iconUrl;
    String ability;
    int sort;
    int cooldown;
    dynamic manaCost;
    int level;

    factory Talent.fromJson(String str) => Talent.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Talent.fromMap(Map<String, dynamic> json) => Talent(
        name: json["name"],
        title: json["title"],
        description: json["description"],
        icon: json["icon"],
        // iconUrl: TalentIconUrl.fromMap(json["icon_url"]),
        ability: json["ability"],
        sort: json["sort"],
        cooldown: json["cooldown"] == null ? null : json["cooldown"],
        manaCost: json["mana_cost"],
        level: json["level"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "title": title,
        "description": description,
        "icon": icon,
        // "icon_url": iconUrl.toMap(),
        "ability": ability,
        "sort": sort,
        "cooldown": cooldown == null ? null : cooldown,
        "mana_cost": manaCost,
        "level": level,
    };
}

// class TalentIconUrl {
//     TalentIconUrl({
//         this.the64X64,
//     });

//     String the64X64;

//     factory TalentIconUrl.fromJson(String str) => TalentIconUrl.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory TalentIconUrl.fromMap(Map<String, dynamic> json) => TalentIconUrl(
//         the64X64: json["64x64"],
//     );

//     Map<String, dynamic> toMap() => {
//         "64x64": the64X64,
//     };
// }

enum Type { MELEE, RANGED }

final typeValues = EnumValues({
    "Melee": Type.MELEE,
    "Ranged": Type.RANGED
});

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
