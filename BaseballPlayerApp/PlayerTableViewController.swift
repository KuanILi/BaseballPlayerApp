//
//  PlayerTableViewController.swift
//  BaseballPlayerApp
//
//  Created by kuani on 2022/9/30.
//

import UIKit

class PlayerTableViewController: UITableViewController {
    
    
    var players = [PlayerInfo](){
        
        didSet{
            PlayerInfo.savePlayers(players)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let players = PlayerInfo.loadPlayers(){
            self.players = players
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return players.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(BaseballPlayerTableViewCell.self)", for: indexPath) as! BaseballPlayerTableViewCell
        let player = players[indexPath.row]
        cell.playerName.text = player.name
        cell.playerNumber.text = player.number
        
        if player.team == "中信兄弟"{
            cell.teamsPicture.image = UIImage(named: "中信兄弟")
        }
        if player.team == "樂天桃猿"{
            cell.teamsPicture.image = UIImage(named: "樂天桃猿")
        }
        if player.team == "統一7-ELEVEn獅"{
            cell.teamsPicture.image = UIImage(named: "統一獅")
        }
        if player.team == "富邦悍將"{
            cell.teamsPicture.image = UIImage(named: "富邦悍將")
        }
        if player.team == "味全龍"{
            cell.teamsPicture.image = UIImage(named: "味全龍")
        }
       
        // Configure the cell...

        return cell
    }
    
    @IBAction func unwindToPlayerTableViewController(_ unwindSegue: UIStoryboardSegue) {
        if let source = unwindSegue.source as? EditPlayerTableViewController,
        let player = source.player {
            if let indexPath = tableView.indexPathForSelectedRow{
                players[indexPath.row] = player
                tableView.reloadData()
            }else{
                
                players.insert(player, at: 0)
                let newIndexPath = IndexPath(row: 0, section: 0)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                //PlayerInfo.savePlayers(players)
            }
        }
        
        //let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "確定要刪除嗎?", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "確定", style: .default) { _ in
            self.players.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            //PlayerInfo.savePlayers(self.players)
        }
        alertController.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        /*
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
         */
        //players.remove(at: indexPath.row)
        //tableView.reloadData()
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        if let controller = segue.destination as? EditPlayerTableViewController,
        let row = tableView.indexPathForSelectedRow?.row{
            controller.player = players[row]
        }
    }
    
}
