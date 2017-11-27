//
//  Perfil_ViewController.swift
//  MueveSF
//
//  Created by Marvi on 20/11/17.
//  Copyright © 2017 marvi. All rights reserved.
//

import UIKit

class Perfil_ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getImage(){
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("user.png")
        if fileManager.fileExists(atPath: imagePath){
            image.image = UIImage(contentsOfFile: imagePath)
            image.contentMode = .scaleAspectFit
        }else{
            print("Panic! No Image!")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
