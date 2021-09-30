//
//  File.swift
//  NasaApp
//
//  Created by Artem Pavlov on 26.09.2021.
//

import Foundation

//MARK Today's NASA Photo
struct PhotoOfToday: Decodable {
    let copyright: String?
    let date: String?
    let explanation: String?
    let title: String?
    let url: String?
}

//MARK Mars Rover Photo
struct PhotoOfMarsRover: Decodable {
    let photos: [MarsRoverPhoto]?
    
    init(roverPhoto: [String: Any]) {
        photos = roverPhoto["photos"] as? [MarsRoverPhoto]
    }
    
    static func getPhotos(from value: Any) -> [PhotoOfMarsRover] {        
        guard let roversData = value as? [[String: Any]] else { return [] }
        return roversData.compactMap { PhotoOfMarsRover(roverPhoto: $0) }
    }
}

struct MarsRoverPhoto: Decodable {
    let id: Int?
    let sol: Int?
    let imgSrc: String?
    let earthDate: String?
    let rover: RoverSpecs?
    
    init(roverPhoto: [String: Any]) {
        id = roverPhoto["id"] as? Int
        sol = roverPhoto["sol"] as? Int
        imgSrc = roverPhoto["imgSrs"] as? String
        earthDate = roverPhoto["earthDate"] as? String
        rover = roverPhoto["rover"] as? RoverSpecs
    }
}

struct RoverSpecs: Decodable {
    let name: String?
    let landingDate: String?
    let status: String?
    
    init(roverSpecs: [String: Any]) {
        name = roverSpecs["name"] as? String
        landingDate = roverSpecs["landingDate"] as? String
        status = roverSpecs["status"] as? String
    }
    
}

//GeomagneticStorm
struct GeomagneticStorm: Decodable {
    let startTime: String?
    let link: String?
}
