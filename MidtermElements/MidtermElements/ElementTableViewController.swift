//
//  ElementTableViewController.swift
//  MidtermElements
//
//  Created by Tyler Newton on 12/8/16.
//  Copyright © 2016 Tyler Newton. All rights reserved.
//

import UIKit

class ElementTableViewController: UITableViewController {
    
    
    var elements: [Element] = []
    var elementIdentifier = "elementCell"
    let cache = NSCache<NSString, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func loadData() {
        ElementRequestManager.manager.elementData("https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/elements") { (data: Data?) in
            
            if let validData = data,
                let validElements = Element.getElements(from: validData) {
                self.elements = validElements
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        loadData()
        refreshControl.endRefreshing()
    }
        
        
        // MARK: - Table view data source
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return elements.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: elementIdentifier, for: indexPath)
        
        let cellElement = elements[indexPath.row]
        
        cell.imageView?.layer.cornerRadius = 22.5
        cell.imageView?.layer.masksToBounds = true
        cell.imageView?.downloadImage(from: "https://s3.amazonaws.com/ac3.2-elements/\(cellElement.symbol)_200.png", with: cache)
        cell.textLabel?.text = cellElement.name
        cell.detailTextLabel?.text = "\(cellElement.symbol) (\(cellElement.number)) (\(cellElement.weight))"
        // Configure the cell...
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "elementSegue" {
        if let DetailView = segue.destination as? DetailViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) {
            
            let _ = DetailView.view
            
            // I keep getting nil and I know that this has something to do with what information is being parsed. I feel that I set it
            
            DetailView.elementImage.downloadImage(from: "https://s3.amazonaws.com/ac3.2-elements/\(elements[indexPath.row].symbol).png", with: cache)
            DetailView.boilingPointLabel.text = "\(elements[indexPath.row].boilingPoint)"
            DetailView.meltingPointLabel.text = "\(elements[indexPath.row].meltingPoint)"
            DetailView.nameNumberWeightLabel.text = "\(elements[indexPath.row].name) (\(elements[indexPath.row].number)) \((elements[indexPath.row].weight))"
            DetailView.symbolLabel.text = elements[indexPath.row].symbol
            }
            
        }
        
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
