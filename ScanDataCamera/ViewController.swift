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
    guard checkPermissions() == true else { return }
    
    let regonizedDataTypes:Set<DataScannerViewController.RecognizedDataType> = [
      .text()
    ]
    
    let dataScanner = DataScannerViewController(recognizedDataTypes: regonizedDataTypes)
    present(dataScanner, animated: true) {
      try? dataScanner.startScanning()
    }
  }
  
  /// Checks is `isSupported` and `isAvailable`
  private func checkPermissions() -> Bool {
    // 2018 or newer with Neural Engine
    print("DataScannerViewController.isSupported: \(DataScannerViewController.isSupported)")
    
    // ✅ Make sure Camera is enabled
    print("DataScannerViewControllerisAvailable: \(DataScannerViewController.isAvailable)")
    
    if DataScannerViewController.isSupported && DataScannerViewController.isAvailable {
      return true
    } else {
      return false
    }
  }
  

}

