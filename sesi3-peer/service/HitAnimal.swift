//
//  HitAnimal.swift
//  sesi3-peer
//
//  Created by Dony Prastiya on 17/03/23.
//

import Foundation
import Contentful

final class HitAnimal{
    let client = Client(spaceId: "h3hrmp71em6y",
                        environmentId: "master", // Defaults to "master" if omitted
                        accessToken: "JG4gIA_pKZnfD34I1Ec-jF2jJJK6B7HPYbZIpUJJZ98")

    func getAnimal(){
        client.fetch(Entry.self, id: "gWlG5n5UHiynINSFvMPhd") {
            (result: Result<Entry>) in
          switch result {
          case .success(let entry):
            print(entry.id)
          case .error(let error):
            print(error)
          }
        }

    }
}
