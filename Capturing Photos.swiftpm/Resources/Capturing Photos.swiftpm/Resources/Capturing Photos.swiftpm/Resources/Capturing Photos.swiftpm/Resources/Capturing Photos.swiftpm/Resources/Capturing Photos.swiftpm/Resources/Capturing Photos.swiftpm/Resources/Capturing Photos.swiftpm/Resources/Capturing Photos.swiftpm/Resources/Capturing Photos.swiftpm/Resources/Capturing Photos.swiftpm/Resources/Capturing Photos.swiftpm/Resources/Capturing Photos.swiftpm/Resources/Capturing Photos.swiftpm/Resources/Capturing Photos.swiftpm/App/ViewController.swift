//
//  ViewController.swift
//  
//
//  Created by Manali Patil on 3/18/23.
//

import UIKit

class MyViewController: UIViewController{
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var button:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapButton(sender: AnyObject){
        button.backgroundColor = UIColor.black
    }
    
    @IBAction func buttonReleassed(sender: AnyObject){
        button.backgroundColor = UIColor.blue
    }
}
