import UIKit

final class StartVC: UIViewController {
    static var loginC: LoginC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigationController = navigationController {
            StartVC.loginC = LoginC(navigationController: navigationController)
            StartVC.loginC!.start()
        }
    }
}
