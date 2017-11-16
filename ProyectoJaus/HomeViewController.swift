//
//  HomeViewController.swift
//  ProyectoJaus
//
//  Created by Estudiante on 4/10/16.
//  Copyright © 2016 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate{

    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var saleOrRentTogle: UISegmentedControl!
    
    
    var housesToData : [House] = []
    var filterHouses : [House] = []
    var sale : Bool = false
    var shouldShowSearchResults = false
    
    var searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        connect()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search here..."
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
 
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults{
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        filterHouses = housesToData.filter({ (house) -> Bool in
            let houseText: NSString = house.name as NSString
            return (houseText.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        tableView.reloadData()
    }
    
    func connect(){
        self.activityIndicator.startAnimating()
        
        let urlPath : String! = CONSTANTS.BASE_URL + "/get_houses"
        let url = URL(string: urlPath)!
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: {data, response, error -> Void in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            //let convertedString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            if statusCode == CONSTANTS.STATUS_OK {
                
                DispatchQueue.main.async{
                    CONSTANTS.HOUSES = JSON.parseHouses(data!)
                    self.loadTable()
                }
                
            }
            print(statusCode.description)
        })
        
        task.resume()
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        connect()
        
    }
    
    
    @IBAction func segmentedAction(_ sender: AnyObject) {
        loadTable()
    }
    
    func loadTable(){
        housesToData = [House]()
        for casa in CONSTANTS.HOUSES{
            if (saleOrRentTogle.selectedSegmentIndex == 0 && (casa.type == "Sale" || casa.type == "ForSale")){
                housesToData.append(casa)
            }else if (saleOrRentTogle.selectedSegmentIndex == 1 && casa.type == "Rental"){
                housesToData.append(casa)
            }
        }
        tableView.reloadData()
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults{
            return filterHouses.count
        }
        else{
            return self.housesToData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! homeTableViewCell
        
        if shouldShowSearchResults{
            cell.cellName.text = filterHouses[indexPath.row].name
            cell.cellAddress.text = filterHouses[indexPath.row].address
            cell.cellPrice.text = String(filterHouses[indexPath.row].price)
        }
        else{
            cell.cellName.text = housesToData[indexPath.row].name
            cell.cellAddress.text = housesToData[indexPath.row].address
            cell.cellPrice.text = String( housesToData[indexPath.row].price)
        }
        
       
        
        return cell
        
    }
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
    }*/
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detailsSegue"){
            let dvc = segue.destination as! houseViewViewController
           
            let indexPath = self.tableView.indexPathForSelectedRow! as IndexPath
            if shouldShowSearchResults{
                let houseSelected = self.filterHouses[(indexPath as NSIndexPath).row]
                dvc.house = houseSelected
            }
            else{
               let houseSelected = self.housesToData[(indexPath as NSIndexPath).row]
                dvc.house = houseSelected
            }
            
            

        }
        
        
    }
 

}

