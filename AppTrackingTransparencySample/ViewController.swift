//
//  ViewController.swift
//  AppTrackingTransparencySample
//
//  Created by ryokosuge on 2020/12/18.
//

import UIKit
import AppTrackingTransparency

class ViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setText(authorizationStatus: ATTrackingManager.trackingAuthorizationStatus)
    }

}

extension ViewController {

    @IBAction func requestTrackingAuthorization() {
        ATTrackingManager.requestTrackingAuthorization { (status) in
            self.setText(authorizationStatus: status)
        }
    }

    private func setText(authorizationStatus: ATTrackingManager.AuthorizationStatus) {
        switch authorizationStatus {
        case .authorized:
            statusLabel?.text = "authorized"
        case .denied:
            statusLabel?.text = "denied"
        case .notDetermined:
            statusLabel?.text = "notDetermined"
        case .restricted:
            statusLabel?.text = "restricted"
        @unknown default:
            statusLabel?.text = "unknown"
        }
    }

}
