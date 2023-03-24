//
//  Animal.swift
//  sesi3-peer
//
//  Created by Dony Prastiya on 17/03/23.
//

import Foundation
import Contentful

enum CodingKeys: String, CodingKey {
    case title
    case subtitle
    case desc
    case imgUrl
    case featured
    case pic
}

final class Animal: EntryDecodable, FieldKeysQueryable{
    static var contentTypeId: Contentful.ContentTypeId {
        return "animal"
    }
    
    typealias FieldKeys = CodingKeys
    
    var id: String
    var updatedAt: Date?
    var createdAt: Date?
    var localeCode: String?
    
    var title: String?
    var subtitle: String?
    var desc: String?
    var imgUrl: String?
    var featured : Bool?
//    var pic : Asset?
    
    init(from decoder: Decoder) throws {
        let sys = try decoder.sys()
        id = sys.id
        localeCode = sys.locale
        updatedAt = sys.updatedAt
        createdAt = sys.createdAt
        
        let container = try decoder.contentfulFieldsContainer(keyedBy: Animal.FieldKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        subtitle = try container.decodeIfPresent(String.self, forKey: .subtitle)
        imgUrl = try container.decodeIfPresent(String.self, forKey: .imgUrl)
        desc = try container.decodeIfPresent(String.self, forKey: .desc)
        featured = try container.decodeIfPresent(Bool.self, forKey: .featured)
//        pic = try container.decodeIfPresent(Asset.self, forKey: .pic)
    }
    
}




