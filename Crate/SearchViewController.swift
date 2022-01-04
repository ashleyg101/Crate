//
//  searchViewController.swift
//  Crate
//
//  Created by Ashley Gong on 11/28/21.
//

import UIKit

class searchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var searchResults = [Recordings]()
    var hasSearched = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // API request
        
        //tableView.contentInset = UIEdgeInsets(top: 56, left: 0, bottom: 0, right: 0)
        var cellNib = UINib(nibName: "SearchResultCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "SearchResultCell")
        
        cellNib = UINib(nibName: "NothingFoundCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "NothingFoundCell")
        
    }
}

// MARK: - Search Bar Delegate
extension searchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        searchBar.resignFirstResponder()
        hasSearched = true
        searchResults = []
        performSearch(searchBar.text!)
    }
}
    

// MARK: - Table View Delegate
extension searchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cellIdentifier = "SearchResultCell"
        //var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if searchResults.count == 0 {
            return tableView.dequeueReusableCell(withIdentifier: "NothingFoundCell", for: indexPath)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchResultCell
            
            let recording = searchResults[indexPath.row]
            cell.nameLabel.text = recording.title
            cell.artistNameLabel.text = recording.artistCredit[0].name
            return cell
        }
    }
    
    func tableView(
        _ tableView: UITableView, didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowDetail", sender: indexPath)
    }
    
    func tableView(
        _ tableView: UITableView, willSelectRowAt indexPath: IndexPath
    ) -> IndexPath? {
        if searchResults.count == 0 {
            return nil
        } else {
            return indexPath
        }
    }
    
    
    func performSearch(_ text: String) {
        guard let url = getUrl(for: text) else {
            print("Unexpected Error: URL is nil!")
            return
        }
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let results = try decoder.decode(SearchResult.self, from: data)
                    print(results.recordings)
                    self.searchResults = results.recordings
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Failed to decode JSON: \(error)")
                }
            }
        }
        task.resume()
    }
}

// MARK: - Helper Methods
func getUrl(for searchText: String) -> URL? {
    //let escapedString = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    var escapedString = searchText
    escapedString = "\"" + escapedString + "\" "
    escapedString = escapedString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed)!
    print(escapedString)
    let urlString = "https://musicbrainz.org/ws/2/recording?query=" + escapedString + "&fmt=json"
    let url = URL(string: urlString)
    return url
}



