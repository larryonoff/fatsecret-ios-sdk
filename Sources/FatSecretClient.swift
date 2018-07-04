//
//  FatSecretClient.swift
//  FatSecretSDK
//
//  Created by Ilya Laryionau on 01/07/2018.
//  Copyright © 2018 larryonoff. All rights reserved.
//

import Foundation
import OAuthSwift
import Result

private let endpointURL = URL(string: "https://platform.fatsecret.com/rest/server.api")!

open class FatSecretClient {

    private let oauth: OAuth1Swift

    public init(consumerKey: String, consumerSecret: String) {
        self.oauth = OAuth1Swift(consumerKey: consumerKey, consumerSecret: consumerSecret)
        self.oauth.client.paramsLocation = .requestURIQuery
    }

    // public

    public func searchFoods(
        searchText: String?,
        pageIndex: Int = 0,
        pageLength: Int = 20,
        completion: @escaping (Result<FoodSearchResponse, FatSecretError>) -> Void) {

        performRequest(
            withMethod: FatSecretTarget.foodsSearch.rawValue,
            parameters: [
                "search_expression": searchText,
                "page_number": "\(pageIndex)",
                "max_results": "\(pageLength)"
            ],
            completion: { [decoder = self.defaultDecoder] result in
                let convertedResult = result
                    .mapError { FatSecretError.anyError($0) }
                    .flatMap { response -> Result<FoodSearchResponse, FatSecretError> in
                        do {
                            let value = try decoder
                                .decode(_FoodSearchResponse.self, from: response.data)
                            return .success(value.foods)
                        } catch {
                            let convertedError = FatSecretError.anyError(error)
                            return .failure(convertedError)
                        }
                    }

                completion(convertedResult)
            })
    }

    public func food(
        with foodId: Food.Id,
        completion: @escaping (Result<Food, FatSecretError>) -> Void) {

        performRequest(
            withMethod: FatSecretTarget.foodGet.rawValue,
            parameters: [
                "food_id": foodId
            ],
            completion: { [decoder = self.defaultDecoder] result in
                let convertedResult = result
                    .mapError { FatSecretError.anyError($0) }
                    .flatMap { response -> Result<Food, FatSecretError> in
                        do {
                            let value = try decoder
                                .decode(_Food.self, from: response.data)
                            return .success(value.food)
                        } catch {
                            let convertedError = FatSecretError.anyError(error)
                            return .failure(convertedError)
                        }
                }

                completion(convertedResult)
        })
    }

    // private

    private var defaultDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return decoder
    }

    private func performRequest(
        withMethod method: String,
        parameters: [String: String?] = [:],
        completion: @escaping (Result<OAuthSwiftResponse, OAuthSwiftError>) -> Void) {
        var newParameters = parameters
        newParameters["format"] = "json"
        newParameters["method"] = method

        guard
            var urlComponents = URLComponents(url: endpointURL, resolvingAgainstBaseURL: false) else {
            assertionFailure()
            return
        }

        urlComponents.queryItems = newParameters
            .map { URLQueryItem(name: $0, value: $1) }

        guard let urlString = urlComponents.string else {
            assertionFailure()
            return
        }

        oauth.client.get(
            urlString,
            success: { response in completion(.success(response)) },
            failure: { error in completion(.failure(error)) })
    }
}
