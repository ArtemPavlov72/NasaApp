//
//  MainCollectionViewController.swift
//  NasaApp
//
//  Created by iMac on 26.09.2021.
//

import UIKit

enum Link: String {
    case imageURL = "https://apod.nasa.gov/apod/image/2109/RedSquare_Tuthill_960.jpg"
    case pictureOfToday = "https://apod.nasa.gov/apod/astropix.html"
    case marsRoverPhotos = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2015-6-3&api_key=DEMO_KEY"
    case geomagneticStorm = "https://api.nasa.gov/DONKI/GST?startDate=yyyy-MM-dd&endDate=yyyy-MM-dd&api_key=DEMO_KEY"
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
        case .pictureOfToday: pictureOfTodayButtonPressed()
        case .marsRoverPhotos: marsRoverPhotosButtonPressed()
        case .geomagneticStorm: geomagneticStormButtonPressed()
        }
    }
}
// MARK: - Networking
extension MainViewController {
    private func pictureOfTodayButtonPressed() {
        
    }
    
    private func marsRoverPhotosButtonPressed() {
        
    }
    
    private func geomagneticStormButtonPressed() {
        
    }
    
}
// отображение cell под разные экраны
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}
