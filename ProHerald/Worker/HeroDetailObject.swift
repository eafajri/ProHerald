//
//  HeroDetailObject.swift
//  ProHerald
//
//  Created by erric alfajri on 07/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

import Foundation
import ObjectMapper

class HeroDetailObject: Mappable {
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

    required init(map: Map) {
        
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
