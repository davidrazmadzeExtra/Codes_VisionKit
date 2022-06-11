//
//  ViewController.swift
//  ScanDataCamera
//
//  Created by David Razmadze on 6/11/22.
//

import UIKit
import VisionKit

class ViewController: UIViewController {
  
  // MARK: - Properties
  
  /// Checks is `isSupported` and `isAvailable` for `DataScannerViewController`
  var scannerAvailable: Bool {
      DataScannerViewController.isSupported &&
      DataScannerViewController.isAvailable
  }

  // MARK: - Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  // MARK: - IBActions
  
  @IBAction func scanPressed(_ sender: Any) {
    guard scannerAvailable == true else { return }
    
    let regonizedDataTypes:Set<DataScannerViewController.RecognizedDataType> = [
      .text(),
      .barcode()
    ]
    
    let dataScanner = DataScannerViewController(recognizedDataTypes: regonizedDataTypes, isHighlightingEnabled: true)
    dataScanner.delegate = self
    present(dataScanner, animated: true) {
      try? dataScanner.startScanning()
    }
  }
  
}

// MARK: - DataScannerViewControllerDelegate

/// Delegate methods for `DataScannerViewController`
extension ViewController: DataScannerViewControllerDelegate {
  
  /// User taps on the screen. Copy the text that was highlighted
  func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
    switch item {
    case .text(let text):
      print("text: \(text.transcript)")
      UIPasteboard.general.string = text.transcript
      dataScanner.stopScanning()
      dataScanner.dismiss(animated: true)
    case .barcode(let code):
      guard let urlString = code.payloadStringValue, let url = URL(string: urlString) else { return }
      UIApplication.shared.open(url)
      dataScanner.stopScanning()
      dataScanner.dismiss(animated: true)
    default:
      print("Unexpected item")
    }
  }
  
}

