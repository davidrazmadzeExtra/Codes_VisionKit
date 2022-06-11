//
//  ViewController.swift
//  ScanDataCamera
//
//  Created by David Razmadze on 6/11/22.
//


import UIKit
import VisionKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  
  @IBAction func scanPressed(_ sender: Any) {
    print("scanning")
    
    print(DataScannerViewController.isSupported)
  }
  

}

