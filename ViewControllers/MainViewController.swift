//
//  MainCollectionViewController.swift
//  NasaApp
// 
//  Created by Artem Pavlov on 26.09.2021.
//

import UIKit

enum UserAction: String, CaseIterable {
    case downloadImage = "NASA photo"
    case pictureOfToday = "Today's NASA media"
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
        } else {
            guard let imageOfDayVC = segue.destination as? ImageOfDayTableViewController else { return }
            imageOfDayVC.photoOfDayInfo()
        }
    }
}

// MARK: - Networking
extension MainViewController {
    
    private func geomagneticStormButtonPressed() {
        NetworkManager.shared.fetch(dataType: [GeomagneticStorm].self, from: Link.geomagneticStorm.rawValue) { result in
            switch result {
            case .success(let storms):
                for storm in storms {
                    print(
                        """
                        Geomagnetic storm had been started on: \(storm.startTime ?? "")
                        You can find more information here: \(storm.link ?? "")
                        """
                    )
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

// отображение cell под разные экраны
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}
