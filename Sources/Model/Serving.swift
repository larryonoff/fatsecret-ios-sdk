//
//  Serving.swift
//  FatSecretSDK
//
//  Created by Ilya Laryionau on 01/07/2018.
//  Copyright © 2018 larryonoff. All rights reserved.
//

import Foundation

struct _Serving: Decodable {
    let serving: Serving
}

public struct Serving: Decodable, Equatable {
    public typealias Id = String

    public let id: Id
    public let url: URL?
    public let servingDescription: String

    public let metricServingAmount: Double
    public let metricServingUnit: String

    public let unitsCount: Double

    public let measurementDescription: String

    // Macronutrients

    public let calories: Double
    public let carbohydrates: Double
    public let cholesterol: Double?
    public let fatTotal: Double
    public let fatMonounsaturated: Double?
    public let fatPolyunsaturated: Double?
    public let fatSaturated: Double?
    public let fatTrans: Double?
    public let fiber: Double?
    public let protein: Double
    public let sugar: Double?

    // Micronutrients minerals

    public let calcium: Int?
    public let iron: Int?
    public let potassium: Double?
    public let sodium: Double?

    // Micronutrients vitamins

    public let vitaminA: Int?
    public let vitaminC: Int?

    // MARK: - Decodable
    
    private enum CodingKeys: String, CodingKey {
        case servingId
        case servingURL
        case servingDescription

        case metricServingAmount
        case metricServingUnit
        case numberOfUnits

        case measurementDescription

        case calories
        case carbohydrates = "carbohydrate"
        case cholesterol
        case fatTotal = "fat"
        case fatMonounsaturated = "monounsaturatedFat"
        case fatPolyunsaturated = "polyunsaturatedFat"
        case fatSaturated = "saturatedFat"
        case fatTrans = "transFat"
        case fiber
        case protein
        case sugar

        case calcium
        case iron
        case potassium
        case sodium

        case vitaminA
        case vitaminC
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Id.self, forKey: .servingId)
        url = try container.decodeIfPresent(URL.self, forKey: .servingURL)
        servingDescription = try container.decode(String.self, forKey: .servingDescription)

        let metricServingAmountString = try container.decode(String.self, forKey: .metricServingAmount)
        metricServingAmount = Double(metricServingAmountString) ?? 0
        metricServingUnit = try container.decode(String.self, forKey: .metricServingUnit)

        let unitsCountString = try container.decode(String.self, forKey: .numberOfUnits)
        unitsCount = Double(unitsCountString) ?? 0

        measurementDescription = try container.decode(String.self, forKey: .measurementDescription)

        // Nutrients

        let caloriesString = try container.decode(String.self, forKey: .calories)
        calories = Double(caloriesString) ?? 0

        let carbohydratesString = try container.decode(String.self, forKey: .carbohydrates)
        carbohydrates = Double(carbohydratesString) ?? 0

        let cholesterolString = try container.decodeIfPresent(String.self, forKey: .cholesterol)
        cholesterol = cholesterolString.flatMap { Double($0) } ?? 0

        let fatTotalString = try container.decode(String.self, forKey: .fatTotal)
        fatTotal = Double(fatTotalString) ?? 0

        let fatMonounsaturatedString = try container.decodeIfPresent(String.self, forKey: .fatMonounsaturated)
        fatMonounsaturated = fatMonounsaturatedString.flatMap { Double($0) } ?? 0

        let fatPolyunsaturatedString = try container.decodeIfPresent(String.self, forKey: .fatPolyunsaturated)
        fatPolyunsaturated = fatPolyunsaturatedString.flatMap { Double($0) } ?? 0

        let fatSaturatedString = try container.decodeIfPresent(String.self, forKey: .fatSaturated)
        fatSaturated = fatSaturatedString.flatMap { Double($0) } ?? 0

        let fatTransString = try container.decodeIfPresent(String.self, forKey: .fatTrans)
        fatTrans = fatTransString.flatMap { Double($0) } ?? 0

        let fiberString = try container.decodeIfPresent(String.self, forKey: .fiber)
        fiber = fiberString.flatMap { Double($0) } ?? 0

        let proteinString = try container.decode(String.self, forKey: .protein)
        protein = Double(proteinString) ?? 0

        let sugarString = try container.decodeIfPresent(String.self, forKey: .sugar)
        sugar = sugarString.flatMap { Double($0) } ?? 0

        let calciumString = try container.decodeIfPresent(String.self, forKey: .calcium)
        calcium = calciumString.flatMap { Int($0) } ?? 0

        let ironString = try container.decodeIfPresent(String.self, forKey: .iron)
        iron = ironString.flatMap { Int($0) } ?? 0

        let potassiumString = try container.decodeIfPresent(String.self, forKey: .potassium)
        potassium = potassiumString.flatMap { Double($0) } ?? 0

        let sodiumString = try container.decodeIfPresent(String.self, forKey: .sodium)
        sodium = sodiumString.flatMap { Double($0) } ?? 0

        let vitaminAString = try container.decodeIfPresent(String.self, forKey: .vitaminA)
        vitaminA = vitaminAString.flatMap { Int($0) } ?? 0

        let vitaminCString = try container.decodeIfPresent(String.self, forKey: .vitaminC)
        vitaminC = vitaminCString.flatMap { Int($0) } ?? 0
    }
}
