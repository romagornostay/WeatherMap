//
//  SearchResultsViewController.swift
//  WeatherMap
//
//  Created by SalemMacPro on 14.5.21.
//

import UIKit
import CoreLocation
import MapKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewController(_ vc: SearchResultsViewController, didSelectLocationWith coordinate: CLLocationCoordinate2D?)
}

final class SearchResultsViewController: UIViewController {
    weak var delegate: SearchResultsViewControllerDelegate?
    private var searchCompleter = MKLocalSearchCompleter()
    private var searchResults = [MKLocalSearchCompletion]()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .regular)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = view.bounds
        view.addSubview(blurredEffectView)
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        searchCompleter.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}
// MARK: UISearchResultsUpdating
extension SearchResultsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        searchCompleter.queryFragment = text
    }
}
// MARK: MKLocalSearchCompleterDelegate
extension SearchResultsViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        tableView.reloadData()
    }
}
// MARK: UITableViewDelegate, UITableViewDataSource
extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = searchResults[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.subtitle
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let result = searchResults[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: result)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let coordinate = response?.mapItems[0].placemark.coordinate else { return }
            self.delegate?.searchResultsViewController(self, didSelectLocationWith: coordinate)
        }
    }
}



