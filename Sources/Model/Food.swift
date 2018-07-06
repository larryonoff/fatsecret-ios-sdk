//
//  Food.swift
//  FatSecretSDK
//
//  Created by Ilya Laryionau on 01/07/2018.
//  Copyright © 2018 larryonoff. All rights reserved.
//

import Foundation

struct _Food: Decodable {
    let food: Food
}

public struct Food: Decodable, Equatable {
    public typealias Id = String

    public enum FoodType: String, Decodable, Equatable {
        case generic = "Generic"
        case brand = "Brand"
    }

    // the unique food identifier
    public let id: Id

    // the name of the food, not including the brand name. E.G.: "Instant Oatmeal"
    public let name: String

    // takes the value "Brand" or "Generic". Indicates whether the food is a brand or generic item
    public let foodType: FoodType

    // the brand name, only when food_type is "Brand". E.G.: "Quaker"
    public let brandName: String?

    // URL of this food item on www.fatsecret.com
    public let url: URL?

    // a summary description of key nutritional values for a nominated serving size
    public let foodDescription: String?

    // detailed nutritional information for each available standard serving size
    public let servings: [Serving]?

    // MARK: - Decodable

    private enum CodingKeys: String, CodingKey {
        case foodId
        case foodName
        case foodType
        case brandName
        case foodURL
        case foodDescription
        case servings
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Id.self, forKey: .foodId)
        name = try container.decode(String.self, forKey: .foodName)
        foodType = try container.decode(FoodType.self, forKey: .foodType)
        brandName = try container.decodeIfPresent(String.self, forKey: .brandName)
        url = try container.decodeIfPresent(URL.self, forKey: .foodURL)
        foodDescription = try container.decodeIfPresent(String.self, forKey: .foodDescription)

        let _serving = try container
            .decodeIfPresent(_Servings.self, forKey: .servings)
        servings = _serving?.serving?.servings
    }
}

// Internal

private struct _Servings: Decodable {
    let serving: _ServingsSingleOrArray?
}

private struct _ServingsSingleOrArray: Decodable {

    let servings: [Serving]?

    // MARK: - Decodable

    public init(from decoder: Decoder) throws {

        do {
            var container = try decoder.unkeyedContainer()
            var servings: [Serving] = []
            while !container.isAtEnd {
                let serving = try container.decode(Serving.self)
                servings.append(serving)
            }

            self.servings = !servings.isEmpty ? servings : nil
        } catch let DecodingError.typeMismatch(type, _) where type == [Any].self {
            do {
                let container = try decoder.singleValueContainer()
                let serving = try container.decode(Serving.self)
                servings = [serving]
            } catch {
                throw error
            }
        } catch {
            throw error
        }
    }
}
