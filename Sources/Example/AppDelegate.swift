import FingerprintJSPro
import Foundation
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

        #error("please setup `your-browser-token` and comment this line")
        let token: String = "your-browser-token"

        FingerprintJSPro.Factory
            .getInstance(
                token: token,
                endpoint: nil, // optional
                region: nil // optional
            )
            .getVisitorId { result in
                let alert: UIAlertController
                switch result {
                case let .failure(error):
                    alert = .init(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                case let .success(visitorId):
                    alert = .init(title: "Success", message: visitorId, preferredStyle: .alert)
                }

                alert.addAction(.init(title: "Done", style: .default, handler: nil))

                vc.present(alert, animated: true, completion: nil)
            }

        return true
    }
}
