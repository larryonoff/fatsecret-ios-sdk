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

    // the unique serving identifier
    public let id: Id

    // URL of the serving size for this food item on www.fatsecret.com
    public let url: URL?

    // the full description of the serving size. E.G.: "1 cup" or "100 g"
    public let servingDescription: String

    // the metric quantity combined with metric_serving_unit to derive the total standardized quantity of the serving (where available)
    public let metricServingAmount: Double?

    // the metric unit of measure for the serving size – either "g" or "ml" or "oz" – combined with metric_serving_amount to derive the total standardized quantity of the serving (where available)
    public let metricServingUnit: String?

    // the number of units in this standard serving size. For instance, if the serving description is "2 tablespoons" the number of units is "2", while if the serving size is "1 cup" the number of units is "1"
    public let unitsCount: Double

    // a description of the unit of measure used in the serving description. For instance, if the description is "1/2 cup" the measurement description is "cup", while if the serving size is "100 g" the measurement description is "g"
    public let measurementDescription: String

    // (Commercial Clients Only)
    // flags the servings as the default serving (the suggested or most commonly chosen option)
    public let isDefault: Bool

    // Macronutrients

    // the energy content in kcal
    public let calories: Double

    // the total carbohydrate content in grams
    public let carbohydrates: Double

    // the cholesterol content in milligrams (where available)
    public let cholesterol: Double?

    // the total fat content in grams
    public let fatTotal: Double

    // the monounsaturated fat content in grams (where available)
    public let fatMonounsaturated: Double?

    // the polyunsaturated fat content in grams (where available)
    public let fatPolyunsaturated: Double?

    // the saturated fat content in grams (where available)
    public let fatSaturated: Double?

    // the trans fat content in grams (where available)
    public let fatTrans: Double?

    // the fiber content in grams (where available)
    public let fiber: Double?

    // the protein content in grams
    public let protein: Double

    // the sugar content in grams (where available)
    public let sugar: Double?

    // Micronutrients minerals

    // the percentage of daily recommended Calcium, based on a 2000 calorie diet (where available)
    public let calcium: Int?

    // the percentage of daily recommended Iron, based on a 2000 calorie diet (where available)
    public let iron: Int?

    // the potassium content in milligrams (where available)
    public let potassium: Double?

    // the sodium content in milligrams (where available)
    public let sodium: Double?

    // Micronutrients vitamins

    // the percentage of daily recommended Vitamin A, based on a 2000 calorie diet (where available)
    public let vitaminA: Int?

    // the percentage of daily recommended Vitamin C, based on a 2000 calorie diet (where available)
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

        case isDefault

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

        let metricServingAmountString = try container.decodeIfPresent(String.self, forKey: .metricServingAmount)
        metricServingAmount = metricServingAmountString.flatMap { Double($0) }
        metricServingUnit = try container.decodeIfPresent(String.self, forKey: .metricServingUnit)

        let unitsCountString = try container.decode(String.self, forKey: .numberOfUnits)
        unitsCount = Double(unitsCountString) ?? 0

        measurementDescription = try container.decode(String.self, forKey: .measurementDescription)

        let isDefaultString = try container.decodeIfPresent(String.self, forKey: .isDefault)
        isDefault = isDefaultString != nil

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
