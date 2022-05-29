//
//  userModel.swift
//  suitmediatestXIB
//
//  Created by Hannatassja Hardjadinata on 28/05/22.
//

import Foundation
import CoreLocation
import MapKit

struct info: Decodable {
    var page: Int
    var per_page: Int
    var total: Int
    var total_pages: Int
    var data: [user]
}

struct user {
    var id : Int
    var email : String
    var first_name : String
    var last_name : String
    var avatar : String
    var location: CLLocationCoordinate2D

    enum CodingKeys: String, CodingKey {
        case id, email, avatar, first_name, last_name, location
    }
}

extension user: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        first_name = try values.decode(String.self, forKey: .first_name)
        last_name = try values.decode(String.self, forKey: .last_name)
        id = try values.decode(Int.self, forKey: .id)
        email = try values.decode(String.self, forKey: .email)
        avatar = try values.decode(String.self, forKey: .avatar)
        
        location = generateRandomCoordinates(min: 70, max: 150)
        
    }
}

extension user: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.id, forKey: .id)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.first_name, forKey: .first_name)
        try container.encode(self.last_name, forKey: .last_name)
        try container.encode(self.avatar, forKey: .avatar)

    }
}

class MapPin: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title : String?
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}

func generateRandomCoordinates(min: UInt32, max: UInt32)-> CLLocationCoordinate2D {
    let currentLong = 106.865036
    let currentLat = -6.175110

    let meterCord = 0.00900900900901 / 1000

    let randomMeters = UInt(arc4random_uniform(max) + min)

    let randomPM = arc4random_uniform(6)

    let metersCordN = meterCord * Double(randomMeters)

    if randomPM == 0 {
        return CLLocationCoordinate2D(latitude: currentLat + metersCordN, longitude: currentLong + metersCordN)
    }else if randomPM == 1 {
        return CLLocationCoordinate2D(latitude: currentLat - metersCordN, longitude: currentLong - metersCordN)
    }else if randomPM == 2 {
        return CLLocationCoordinate2D(latitude: currentLat + metersCordN, longitude: currentLong - metersCordN)
    }else if randomPM == 3 {
        return CLLocationCoordinate2D(latitude: currentLat - metersCordN, longitude: currentLong + metersCordN)
    }else if randomPM == 4 {
        return CLLocationCoordinate2D(latitude: currentLat, longitude: currentLong - metersCordN)
    }else {
        return CLLocationCoordinate2D(latitude: currentLat - metersCordN, longitude: currentLong)
    }

}
