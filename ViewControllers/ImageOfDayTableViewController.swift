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
       // tableView.rowHeight = 700
       
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
        guard let url = URL(string: Link.pictureOfToday.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                self.photo = try JSONDecoder().decode(PhotoOfToday.self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
