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
    
    var base_agi: Int?
    var base_armor: Int?
    var base_attack_min: Int?
    var base_attack_max: Int?
    var base_health: Int?
    var base_health_regen: Float?
    
    var base_int: Int?
    var base_mr: Int?
    var base_mana: Int?
    var base_mana_regen: Float?
    var base_str: Int?

    var attack_range: Int?
    var move_speed: Int?
    var projectile_speed: Int?
    var attack_rate: Float?
    var turn_rate: Float?
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
        
        self.base_agi           <- map["base_agi"]
        self.base_armor         <- map["base_armor"]
        self.base_attack_min    <- map["base_attack_min"]
        self.base_attack_max    <- map["base_attack_max"]
        self.base_health        <- map["base_health"]
        self.base_health_regen  <- map["base_health_regen"]
        
        self.base_int           <- map["base_int"]
        self.base_mr            <- map["base_mr"]
        self.base_mana          <- map["base_mana"]
        self.base_mana_regen    <- map["base_mana_regen"]
        self.base_str           <- map["base_str"]
        
        self.attack_range       <- map["attack_range"]
        self.move_speed         <- map["move_speed"]
        self.projectile_speed   <- map["projectile_speed"]
        self.attack_rate        <- map["attack_rate"]
        self.turn_rate          <- map["turn_rate"]
        self.legs               <- map["legs"]
    }
}
