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
}

struct MarsRoverPhoto: Decodable {
    let id: Int?
    let sol: Int?
    let imgSrc: String?
    let earthDate: String?
    let rover: RoverSpecs?
}

struct RoverSpecs: Decodable {
    let name: String?
    let landingDate: String?
    let status: String?
}

//GeomagneticStorm
struct GeomagneticStorm: Decodable {
    let startTime: String?
    let link: String?
}
