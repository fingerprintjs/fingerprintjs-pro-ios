import Foundation
import fpjs_ios_wv
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        let vc = UIViewController()
        vc.view.backgroundColor = .white

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()

        FingerprintJS.Factory
            .getInstance(token: "kDIPlabQCHvWcgMHSyei", endpoint: nil, deviceId: nil)
            .track { result in

                let alert: UIAlertController

                switch result {
                case let .failure(error):
                    alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                case let .success(visitorId):
                    alert = UIAlertController(title: "FingerprintJS.VisitorId:", message: visitorId, preferredStyle: .alert)
                }

                alert.addAction(.init(title: "OK", style: .default, handler: nil))

                vc.present(alert, animated: true)
            }

        return true
    }
}
