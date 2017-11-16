//
//  MyHousesTableViewController.swift
//  ProyectoJaus
//
//  Created by Alberto on 11/10/16.
//  Copyright © 2016 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit

class MyHousesTableViewController: UITableViewController {

    var houses: [House] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        connect()
    }
    
    
    func connect(){
        
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

    func loadTable(){
        houses = [House]()
        for casa in CONSTANTS.HOUSES{
            if (casa.provUsername == CONSTANTS.currentUser){
                self.houses.append(casa)
            }
        }
        tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.houses.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myHouseCell2", for: indexPath) as! MyCellTableViewCell
        
        cell.houseNameLabel.text = self.houses[indexPath.row].name
        cell.houseDescriptionLabel.text = self.houses[indexPath.row].details
        cell.housePriceLabel.text = String(self.houses[indexPath.row].price)
        cell.houseID = self.houses[indexPath.row].houseID
        


        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editHouseSegue" {
            let dvc = segue.destination as! EditHouseViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow! as IndexPath
            dvc.houseToEdit = self.houses[(indexPath as NSIndexPath).row]
        }
    }
    

}
