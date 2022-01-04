//
//  detailViewController.swift
//  Crate
//
//  Created by Ashley Gong on 12/10/21.
//

import UIKit

class detailViewController: UITableViewController {
    @IBOutlet var ReleaseDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
//        let recording = searchResults[indexPath.row]
//        cell.releaseDateLabel.text = recording.firstReleaseDate;
        return cell
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

   
}
