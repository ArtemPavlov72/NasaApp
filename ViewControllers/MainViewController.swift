//
//  MainCollectionViewController.swift
//  NasaApp
//
//  Created by iMac on 26.09.2021.
//

import UIKit

enum Link: String {
    case imageURL = "https://apod.nasa.gov/apod/image/2109/RedSquare_Tuthill_960.jpg"
    case pictureOfToday = "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY"
    case marsRoverPhotos = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&camera=fhaz&api_key=DEMO_KEY"
    case geomagneticStorm = "https://api.nasa.gov/DONKI/GST?startDate=2016-01-01&endDate=2016-01-30&api_key=DEMO_KEY"
}

enum UserAction: String, CaseIterable {
    case downloadImage = "Today's NASA photo"
    case pictureOfToday = "Info about today's photo"
    case marsRoverPhotos = "Mars Rover photos"
    case geomagneticStorm = "Geomagnetic Storm info"
}

class MainViewController: UICollectionViewController {
    
    let userActions = UserAction.allCases
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UserActionCell
        
        cell.userActionLabel.text = userActions[indexPath.item].rawValue
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let userAction = userActions[indexPath.item]
        
        switch userAction {
        case .downloadImage: performSegue(withIdentifier: "showImage", sender: nil)
        case .pictureOfToday: performSegue(withIdentifier: "photoOfDay", sender: nil)
        case .marsRoverPhotos: performSegue(withIdentifier: "marsRover", sender: nil)
        case .geomagneticStorm: geomagneticStormButtonPressed()
        }
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "marsRover" {
            guard let marsRoverVC = segue.destination as? MarsRoverTableViewController else { return }
            marsRoverVC.fetchMarsRoversInfo()
        }
        if segue.identifier == "photoOfDay" {
            guard let imageOfDayVC = segue.destination as? ImageOfDayTableViewController else { return }
            imageOfDayVC.photoOfDayInfo()
        }
    }
}
// MARK: - Networking
extension MainViewController {
    private func pictureOfTodayButtonPressed() {
        guard let url = URL(string: Link.pictureOfToday.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let photo = try JSONDecoder().decode(PhotoOfToday.self, from: data)
                print(photo)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    // Ниже функцию заводил для проверки, данные загружаются
    /*   private func marsRoverPhotosButtonPressed() {
     guard let url = URL(string: Link.marsRoverPhotos.rawValue) else { return }
     
     URLSession.shared.dataTask(with: url) { data, _, error in
     guard let data = data else {
     print(error?.localizedDescription ?? "No error description")
     return
     }
     
     do {
     let roverInfo = try JSONDecoder().decode(PhotoOfMarsRover.self, from: data)
     print(roverInfo)
     }catch let error {
     print(error.localizedDescription)
     }
     
     }.resume()
     }
     */
    
    private func geomagneticStormButtonPressed() {
        guard let url = URL(string: Link.geomagneticStorm.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let geomagneticStorm = try JSONDecoder().decode([GeomagneticStorm].self, from: data)
                print(geomagneticStorm)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}
// отображение cell под разные экраны
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}
