//
//  EnItemDetail.swift
//  PalworldYeon
//
//  Created by yeon on 4/12/24.
//
import Foundation

// Define the details of each item
struct ItemDetail: Codable {
    var rank: String
    var price: String
    var weight: String
    var maxStackCount: String
    var foundInTreasureBox: String
    var satiety: String
    var sanity: String
    var workableAmount: String?
    var product: String?
}

// Define a struct for crafting ingredients
struct CraftingIngredient: Codable {
    var image: String
    var name: String
    var quantity: String
}

// Define a struct for production info, optional if not provided
struct ProductionInfo: Codable {
    var workableAmount: String?
    var product: String?
}

// Define the main item structure
struct Item: Codable {
    var name: String
    var description: String
    var details: ItemDetail
    var craftingIngredients: [CraftingIngredient]
    var productionInfo: ProductionInfo?
}
