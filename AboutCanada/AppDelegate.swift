import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let aboutViewController = AboutViewController()
        window?.rootViewController = UINavigationController(rootViewController: aboutViewController)
        window?.makeKeyAndVisible()
        return true
    }
}
