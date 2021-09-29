//
//  ImageOfDayTableViewController.swift
//  NasaApp
// 
//  Created by Artem Pavlov on 26.09.2021.
//

import UIKit

class ImageOfDayTableViewController: UITableViewController {

    private var photo: PhotoOfToday?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsOfImageOfDay", for: indexPath) as! ImageOfDayCell
        
        let photoOfDay = photo
                cell.configure(with: photoOfDay)
                return cell
        
        }

}

//MARK: - Networking
extension ImageOfDayTableViewController {
    func photoOfDayInfo() {
        NetworkManager.shared.fetch(dataType: PhotoOfToday.self, from: Link.pictureOfToday.rawValue, convertFromSnakeCase: false) { result in
            switch result {
            case .success(let photo):
                self.photo = photo
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
