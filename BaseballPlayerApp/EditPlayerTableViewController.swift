//
//  EditPlayerTableViewController.swift
//  BaseballPlayerApp
//
//  Created by kuani on 2022/9/30.
//

import UIKit

class EditPlayerTableViewController: UITableViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    var player:PlayerInfo?
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var defenseTextField: UITextField!
    @IBOutlet weak var teamTextField: UITextField!
    @IBOutlet weak var teamsPic: UIImageView!
    
    var baseballTeamPkv:UIPickerView!
    let baseballTeamArr = ["中信兄弟","樂天桃猿","統一7-ELEVEn獅","富邦悍將","味全龍"]
    let myPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingPkv()
        updateUI()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        self.view.addGestureRecognizer(tap)
        
        
    }

    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if nameTextField.text?.isEmpty == false,
           numberTextField.text?.isEmpty == false,
           defenseTextField.text?.isEmpty == false,
           teamTextField.text?.isEmpty == false{
            return true
        }else{
            let alertController = UIAlertController(title: "表格資料錯誤", message: nil, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "確認", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            return false
        }
    }
    
    func settingPkv(){
        myPickerView.delegate = self
        myPickerView.dataSource = self
        teamTextField.inputView = myPickerView
        //teamTextField.text = baseballTeamArr[0]
        teamTextField.tag = 100
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return baseballTeamArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return baseballTeamArr[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        teamTextField?.text = baseballTeamArr[row]
        
        if teamTextField.text == "中信兄弟"{
            teamsPic.image = UIImage(named: "中信兄弟")
        }
        if teamTextField.text == "樂天桃猿"{
            teamsPic.image = UIImage(named: "樂天桃猿")
        }
        if teamTextField.text == "統一7-ELEVEn獅"{
           teamsPic.image = UIImage(named: "統一獅")
        }
        if teamTextField.text == "富邦悍將"{
           teamsPic.image = UIImage(named: "富邦悍將")
        }
        if teamTextField.text == "味全龍"{
           teamsPic.image = UIImage(named: "味全龍")
        }
    }
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
    }
    
    // MARK: - Table view data source

    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
        let name = nameTextField.text ?? ""
        let number = numberTextField.text ?? ""
        let defense = defenseTextField.text ?? ""
        let team = teamTextField.text ?? ""
        
        player = PlayerInfo(name: name, number: number, defense: defense, team: team)
    }
    
    func updateUI(){
        if let player {
            nameTextField.text = player.name
            numberTextField.text = player.number
            defenseTextField.text = player.defense
            teamTextField.text = player.team
        }
    }
    

}
