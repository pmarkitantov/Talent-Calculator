//
//  MockTalents.swift
//  Talent Calculator
//
//  Created by Pavel Markitantov on 27/03/2024.
//

import Foundation

let mockTalents: [Talent] = [
    Talent(name: "Огненный шар", icon: "spell_fire_firebolt", baseDescription: "Наносит урон огнем по области", maxPoints: 3, requiredPoints: 0, row: 1, column: 1),
    Talent(name: "Ледяная стрела", icon: "inv_spear_02", baseDescription: "Замораживает врага, нанося урон холодом", maxPoints: 3, requiredPoints: 5, row: 1, column: 2),
    Talent(name: "Целительное прикосновение", icon: "spell_holy_searinglight", baseDescription: "Восстанавливает здоровье цели", maxPoints: 1, requiredPoints: 10, row: 2, column: 1),
    Talent(name: "Защитный барьер", icon: "spell_holy_ashestoashes", baseDescription: "Создает защитный барьер, поглощающий урон", maxPoints: 2, requiredPoints: 15, row: 7, column: 2),
    Talent(name: "Магический взрыв", icon: "spell_fire_lavaspawn", baseDescription: "Наносит массовый урон всем врагам вокруг", maxPoints: 3, requiredPoints: 20, row: 3, column: 1)
]
