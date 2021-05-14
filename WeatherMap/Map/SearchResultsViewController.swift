//
//  SearchResultsViewController.swift
//  WeatherMap
//
//  Created by SalemMacPro on 14.5.21.
//

import UIKit
import CoreLocation

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewController(_ vc: SearchResultsViewController, didSelectLocationWith coordinates: CLLocationCoordinate2D?)
}

class SearchResultsViewController: UIViewController {
    
    weak var delegate: SearchResultsViewControllerDelegate?
    
    var locations = [Location]()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(white: 1, alpha: 0.01)
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor(white: 0.1, alpha: 0.01)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
    }
    
    func updateSearchResults(text: String) {
        LocationManager.shared.findLocations(with: text) { [weak self] locations in
            DispatchQueue.main.async {
                self?.locations = locations
                self?.tableView.reloadData()
            }
        }
    }
}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = locations[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //show pin at selected place
        let coordinate = locations[indexPath.row].coordinates?.coordinate
        delegate?.searchResultsViewController(self, didSelectLocationWith: coordinate)
        print("find place at selected coordinate \n\(coordinate!)\n")
    }
}

extension SearchResultsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        LocationManager.shared.findLocations(with: text) { [weak self] locations in
            DispatchQueue.main.async {
                self?.locations = locations
                self?.tableView.reloadData()
                print(locations)
                print("1.----\n\n\(String(describing: self?.locations))\n")
            }
        }
    }
}

