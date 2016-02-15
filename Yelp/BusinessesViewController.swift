//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIScrollViewDelegate {

    var businesses: [Business]!
    
    var searchBusiness: [Business]!
    
    var isMoreDataLoading = false
    
    var offset = 20.0 as CGFloat
    
    var count = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        
        
        //the rowheight and estimatedrowheight have to be used in conjuction to each other. this is after setting constraints on the image.
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120

        Business.searchWithTerm("Thai", offset: offset, completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.searchBusiness = businesses
            self.tableView.reloadData()
        
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
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
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (!isMoreDataLoading){
            
            //calculate when there's one screen of data left
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging) {
             isMoreDataLoading = true
                offset += 20
                Business.searchWithTerm("Thai", offset: offset, completion: { (businesses: [Business]!, error: NSError!) -> Void in
                    if error == nil {
                        print("new one\n")
                        self.count++
                        print(self.count)
                        self.businesses.appendContentsOf(businesses)
                        self.searchBusiness = businesses
                        self.tableView.reloadData()
                        self.isMoreDataLoading = false
                    }
                })
                
                // ... Code to load more results ...
            }

            
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String){
        if searchText.isEmpty{
            searchBusiness = businesses
        }
        else{
            searchBusiness = businesses!.filter({(dataItem: Business) -> Bool in
                if let restaurant = dataItem.name{
                    if restaurant.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil{
                        return true
                    }
                }
                return false
            } )
            
        }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBusiness != nil{
            return searchBusiness.count;
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        cell.business = searchBusiness[indexPath.row]
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
