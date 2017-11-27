//
//  Image_ViewController.swift
//  MueveSF
//
//  Created by Marvi on 20/11/17.
//  Copyright © 2017 marvi. All rights reserved.
//

import UIKit

class Image_ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    var imagePicker: UIImagePickerController!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBAction func cargar(_ sender: UIButton) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage()
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let fileManager = FileManager.default
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        image.contentMode = .scaleAspectFit
        image.image = chosenImage
        dismiss(animated:true, completion: nil)
        
         let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("user.png")
        let pngImageData = UIImagePNGRepresentation(image.image!)
        fileManager.createFile(atPath: imagePath as String, contents: pngImageData, attributes: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
