//
//  HeroDetailObject.swift
//  ProHerald
//
//  Created by erric alfajri on 07/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

import Foundation
import ObjectMapper

class HeroDetailObject: NSObject, NSCoding, Mappable {
    var heroId: Int?
    
    var localizedName: String?
    var name: String?
    var icon: String?
    var img: String?
    var roles: [String] = []
    var primary_attr: String?
    var attack_type: String?
    
    var baseAgi: Int?
    var baseArmor: Int?
    var baseAttackMin: Int?
    var baseAttackMax: Int?
    var baseHealth: Int?
    var baseHealthRegen: Float?
    
    var baseInt: Int?
    var baseMr: Int?
    var baseMana: Int?
    var baseManaRegen: Float?
    var baseStr: Int?
    
    var attackRange: Int?
    var moveSpeed: Int?
    var projectileSpeed: Int?
    var attackRate: Float?
    var turnRate: Float?
    var legs: Int?
    
    required init(map: Map) { }
    
    required init?(coder: NSCoder) {
        self.heroId = coder.decodeObject(forKey: "hero_id") as? Int
        self.localizedName = coder.decodeObject(forKey: "localized_name") as? String
        self.name = coder.decodeObject(forKey: "name") as? String
        self.icon = coder.decodeObject(forKey: "icon") as? String
        self.img = coder.decodeObject(forKey: "img") as? String
        self.roles = coder.decodeObject(forKey: "roles") as? [String] ?? []
        self.primary_attr = coder.decodeObject(forKey: "primary_attr") as? String
        self.attack_type = coder.decodeObject(forKey: "attack_type") as? String
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.heroId, forKey: "hero_id")
        coder.encode(self.localizedName, forKey: "localized_name")
        coder.encode(self.name, forKey: "name")
        coder.encode(self.icon, forKey: "icon")
        coder.encode(self.img, forKey: "img")
        coder.encode(self.roles, forKey: "roles")
        coder.encode(self.primary_attr, forKey: "primary_attr")
        coder.encode(self.attack_type, forKey: "attack_type")
    }
    
    func mapping(map: Map) {
        self.heroId             <- map["hero_id"]
        
        self.localizedName      <- map["localized_name"]
        self.name               <- map["name"]
        self.icon               <- map["icon"]
        self.img                <- map["img"]
        self.roles              <- map["roles"]
        self.primary_attr       <- map["primary_attr"]
        self.attack_type        <- map["attack_type"]
        
        self.baseAgi           <- map["base_agi"]
        self.baseArmor         <- map["base_armor"]
        self.baseAttackMin    <- map["base_attack_min"]
        self.baseAttackMax    <- map["base_attack_max"]
        self.baseHealth        <- map["base_health"]
        self.baseHealthRegen  <- map["base_health_regen"]
        
        self.baseInt           <- map["base_int"]
        self.baseMr            <- map["base_mr"]
        self.baseMana          <- map["base_mana"]
        self.baseManaRegen    <- map["base_mana_regen"]
        self.baseStr           <- map["base_str"]
        
        self.attackRange       <- map["attack_range"]
        self.moveSpeed         <- map["move_speed"]
        self.projectileSpeed   <- map["projectile_speed"]
        self.attackRate        <- map["attack_rate"]
        self.turnRate          <- map["turn_rate"]
        self.legs               <- map["legs"]
    }
}
