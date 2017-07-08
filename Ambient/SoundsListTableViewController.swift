//
//  SoundsListTableViewController.swift
//  Ambient
//
//  Created by Vitaly Plivachuk on 08.07.17.
//  Copyright © 2017 Vitaly Plivachuk. All rights reserved.
//

import UIKit

class SoundsListTableViewController: UITableViewController {

    var soundsArray = [AmbientSound]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        soundsArray = defaultSoundsArray()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return soundsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SoundsListCell", for: indexPath) as! SoundsListTableViewCell
        cell.soundNameLabel.text = soundsArray[indexPath.row].name
        

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FromListToPlayer"{
            if let indexPath = tableView.indexPathForSelectedRow{
                
                
                let destinationViewController = segue.destination as! PlayerViewController
//                destinationViewController.soundNameLabel.text = soundsArray[indexPath.row].name
//                
                
                if let soundName = soundsArray[indexPath.row].name{
                    destinationViewController.soundName = soundName
                }
                    destinationViewController.listViewController = self
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
    
    func defaultSoundsArray() -> [AmbientSound] {
        var soundsArray = [AmbientSound]()
        soundsArray.append(AmbientSound(name: "Morning Birds", fileName: "Birds", image: UIImage(named: "birds")!, isFavorite: false))
        
        return(soundsArray)
    }

}
