//
//  NetworkManager.swift
//  NasaApp
//
//  Created by Artem Pavlov on 26.09.2021.
//

import Foundation
import Alamofire

enum Link: String {
    case imageURL = "https://apod.nasa.gov/apod/image/2109/RedSquare_Tuthill_960.jpg"
    case pictureOfToday = "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY"
    case marsRoverPhotos = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&camera=fhaz&api_key=DEMO_KEY"
    case geomagneticStorm = "https://api.nasa.gov/DONKI/GST?startDate=2016-01-01&endDate=2016-01-30&api_key=DEMO_KEY"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            } 
        }
    }
    
    func fetch<T: Decodable>(dataType: T.Type, from url: String, convertFromSnakeCase: Bool = true, completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let decoder = JSONDecoder()
                if convertFromSnakeCase {
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                }
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchDataWithAlamofire(_ url: String, completion: @escaping(Result<[PhotoOfMarsRover], NetworkError>) -> Void) {
        AF.request(Link.marsRoverPhotos.rawValue)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let rovers = PhotoOfMarsRover.getPhotos(from: value)
                    DispatchQueue.main.async {
                        completion(.success(rovers))
                    }
                case .failure:
                    completion(.failure(.decodingError))
                }
            }
    }
    
}
