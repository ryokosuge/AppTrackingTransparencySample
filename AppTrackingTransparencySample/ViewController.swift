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
    @IBOutlet weak var openSettingButton: UIButton?

    private var token: Any?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNotification()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        requestTrackingAuthorization()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

}

// MARK: - Action
extension ViewController {

    @IBAction func openSetting() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            return
        }

        UIApplication.shared.open(url,
                                  options: [:],
                                  completionHandler: nil)
    }

}

// MARK: - Notification
extension ViewController {

    private func setupNotification() {
        self.token = NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification,
                                                           object: nil,
                                                           queue: OperationQueue.main) {[weak self] (notification) in
            self?.requestTrackingAuthorization()
        }
    }

    private func clearNotificationToken() {
        self.token = nil
    }

}

// MARK: - private
extension ViewController {

    private func prepareOpenSettingButton() {
        switch ATTrackingManager.trackingAuthorizationStatus {
        case .notDetermined:
            openSettingButton?.isHidden = false
        case .restricted:
            openSettingButton?.isHidden = false
        case .denied:
            openSettingButton?.isHidden = false
        case .authorized:
            openSettingButton?.isHidden = true
        @unknown default:
            openSettingButton?.isHidden = false
        }
    }

    private func requestTrackingAuthorization() {
        ATTrackingManager.requestTrackingAuthorization {[weak self] (status) in
            DispatchQueue.main.async {[weak self] in
                // need main thread.
                self?.prepare(status: status)
            }
        }
    }

    private func prepare(status: ATTrackingManager.AuthorizationStatus) {
        switch status {
        case .notDetermined:
            statusLabel?.text = "not determined."
            openSettingButton?.isHidden = false
        case .restricted:
            statusLabel?.text = "restricted."
            openSettingButton?.isHidden = false
        case .denied:
            statusLabel?.text = "denied."
            openSettingButton?.isHidden = false
        case .authorized:
            statusLabel?.text = "authorized."
            openSettingButton?.isHidden = true
        @unknown default:
            statusLabel?.text = "unknown status."
            openSettingButton?.isHidden = false
        }
    }

}

