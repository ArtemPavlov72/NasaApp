//
//  MarsRoverTableViewController.swift
//  NasaApp
//
//  Created by iMac on 26.09.2021.
//

import UIKit

class MarsRoverTableViewController: UITableViewController {

    private var roverInfo: [MarsRoverPhoto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
       
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        roverInfo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MarsRoverCell
        let rover = roverInfo[indexPath.row]
        cell.configure(with: rover)
        return cell
    }
    

}

//MARK: - Networking
extension MarsRoverTableViewController {
    func fetchMarsRoversInfo() {
        guard let url = URL(string: Link.marsRoverPhotos.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                self.roverInfo = try JSONDecoder().decode([MarsRoverPhoto].self, from: data)
                
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}
