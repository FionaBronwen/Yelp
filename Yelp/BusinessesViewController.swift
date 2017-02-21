//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var businesses: [Business]!
    var searchBar = UISearchBar()
    var filteredData: [String]!
    var searchTerm: String!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //mapButton.
        
        searchTerm = "Thai"
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        searchYelpAPI(with: searchTerm)
        
        
    }
    
    func searchYelpAPI(with searchTerm: String!){
        Business.searchWithTerm(term: searchTerm, completion: { (businesses: [Business]?, error: Error?) -> Void in
            print("Search has been initiated with: \(searchTerm)")
            self.businesses = businesses
            self.tableView.reloadData()
            
//            if let businesses = businesses {
//                for business in businesses {
//                    print(business.name!)
//                    print(business.address!)
//                }
//            }
            
        })
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
    }
    
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchYelpAPI(with: searchTerm)
    }
    
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTerm = searchText
    }
    
    //show cancel button
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if businesses != nil {
            return businesses.count
        }else{
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        
        cell.business = businesses [indexPath.row]
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let _ = sender as? UIBarButtonItem{
            let mapsViewController = segue.destination as! MapsViewController
            mapsViewController.businesses = businesses
        }
    }
    
    
    
     
    
}
