//
//  HitAnimal.swift
//  sesi3-peer
//
//  Created by Dony Prastiya on 17/03/23.
//

import Foundation
import Contentful

let SPACE_ID = "h3hrmp71em6y"
let ACCESS_TOKEN = "JG4gIA_pKZnfD34I1Ec-jF2jJJK6B7HPYbZIpUJJZ98"


final class HitAnimal {
    static let shared: HitAnimal = HitAnimal()
    private init() { }
    
    let client = Client(spaceId: SPACE_ID, accessToken: ACCESS_TOKEN, contentTypeClasses: [Animal.self])
    
    func getAnimals(completion: @escaping (Result<[Animal], Error>) -> Void) {
        
        let query = QueryOn<Animal>.init()

        client.fetchArray(of: Animal.self, matching: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    completion(.success(response.items))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}


final class HitAnimalFeatured {
    static let shared: HitAnimalFeatured = HitAnimalFeatured()
    private init() { }
    
    let client = Client(spaceId: SPACE_ID, accessToken: ACCESS_TOKEN, contentTypeClasses: [Animal.self])
    
    func getAnimalFeatureds(completion: @escaping (Result<[Animal], Error>) -> Void) {
        
        let query = QueryOn<Animal>.init()

        client.fetchArray(of: Animal.self, matching: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    let filter = response.items.filter{animal in
                        return animal.featured == true
                    }
                    completion(.success(filter))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}


//let client = Client(spaceId: spaceId, accessToken: accessToken)
//
//func getArray(id: String, completion: @escaping([Entry]) -> ()) {
//    let query = Query.where(contentTypeId: id)
//    try! query.order(by: Ordering(sys: .createdAt, inReverse: true))
//
//    client.fetchArray(of: Entry.self, matching: query) { result in
//        switch result {
//            case .success(let array):
//                DispatchQueue.main.async {
//                    completion(array.items)
//                }
//            case .failure(let error):
//                print(error)
//        }
//    }
//}
