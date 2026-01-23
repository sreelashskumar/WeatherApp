//
//  AppNavigationController.swift
//  Weather
//
//  Created by Sreelash Sasikumar on 23/01/26.
//

import UIKit

final class AppNavigationController: UINavigationController {

    override var shouldAutorotate: Bool {
        true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .all
    }
}
