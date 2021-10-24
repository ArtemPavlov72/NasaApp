//
//  MarsRoverTableViewController.swift
//  NasaApp
// 
//  Created by Artem Pavlov on 26.09.2021.
//

import UIKit
import Alamofire

class MarsRoverTableViewController: UITableViewController {
    
    //private var roverInfo: PhotoOfMarsRover?
    private var roverPhoto: MarsRoverPhoto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        roverPhoto.
       // roverInfo?.photos?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell", for: indexPath) as! MarsRoverCell
        
        let rover = roverInfo?.photos?[indexPath.row]
        cell.configure(with: rover)
        return cell
    }
}

//MARK: - Networking
extension MarsRoverTableViewController {
//через alamofire:
    func fetchMarsRoversInfo() {
        NetworkManager.shared.fetchDataWithAlamofire(Link.marsRoverPhotos.rawValue) { result in
            switch result {
            case .success(let rovers):
                self.roverPhoto = rovers
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    
// работающий метод:
  /*  func fetchMarsRoversInfo() {
        NetworkManager.shared.fetch(dataType: PhotoOfMarsRover.self,
                                    from: Link.marsRoverPhotos.rawValue,
                                    convertFromSnakeCase: true) { result in
            switch result {
            case .success(let rover):
                self.roverInfo = rover
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    } */
}
