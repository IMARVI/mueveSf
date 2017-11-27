//
//  Lugares_TableViewController.swift
//  MueveSF
//
//  Created by Marvi on 29/10/17.
//  Copyright © 2017 marvi. All rights reserved.
//

import UIKit

class Lugares_TableViewController: UITableViewController, UISearchBarDelegate{
    let direccion = "http://199.233.252.86/201713/SwitchesDeMarfil/lugares_visitados.json"
    var nuevoArray : [Any]?
    var searchActive : Bool = false
    var data = [String]()
    var filtered:[String] = []
    var trans:String = ""
    
    @IBOutlet weak var searchB: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: direccion)
        let datos = try? Data(contentsOf: url!)
        nuevoArray = try! JSONSerialization.jsonObject(with: datos!) as? [Any]
        tableView.delegate = self
        tableView.dataSource = self
        searchB.delegate = self
        fillArray()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Viajes_TableViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(searchActive) {
            return filtered.count
        }
        return (nuevoArray?.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Lugares", for: indexPath)
        
        if(searchActive){
            cell.textLabel?.text = filtered[indexPath.row]
        } else {
            let lugares = nuevoArray?[indexPath.row] as! [String: Any]
            let s:String = lugares["nombre"] as! String
            cell.textLabel?.text = s
        }
        // Configure the cell...
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont(name:"SystemThin", size:28)
        return cell
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = data.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    
    func fillArray(){
        var i = 0
        for _ in nuevoArray!{
            let viaje = nuevoArray?[i] as! [String: Any]
            let s:String = viaje ["nombre"] as! String
            data.append(s)
            i = i+1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "celda" {
            let siguienteV = segue.destination as! PantallaAvance_ViewController
            let indice = self.tableView.indexPathForSelectedRow?.row
            var viaje = nuevoArray?[indice!] as! [String: Any]
            
            if(searchActive && filtered.count != 0){
                var i = 0
                for _ in nuevoArray!{
                    let compare = nuevoArray?[i] as! [String: Any]
                    let s:String = compare ["nombre"] as! String
                    if s == filtered[indice!]{
                        viaje = nuevoArray![i] as! [String : Any]
                    }
                    i = i+1
                }
            }else{
                viaje = nuevoArray?[indice!] as! [String: Any]
            }
            let a:String = viaje ["nombre"] as! String
            siguienteV.lugar = a
        }
        switch segue.identifier{
            case "metro"?:
                let siguienteV = segue.destination as! PantallaAvance_ViewController
                siguienteV.trans = "metro"
            break
        
            case "bici"?:
                let siguienteV = segue.destination as! PantallaAvance_ViewController
                siguienteV.trans = "bici"
            break
            
            case "carro"?:
                let siguienteV = segue.destination as! PantallaAvance_ViewController
                siguienteV.trans = "carro"
            break
            
            case "metroBus"?:
                let siguienteV = segue.destination as! PantallaAvance_ViewController
                siguienteV.trans = "metroBus"
            break
            
            case "rtp"?:
                let siguienteV = segue.destination as! PantallaAvance_ViewController
                siguienteV.trans = "rtp"
            break
            
            default:
            break
            
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
