import UIKit

final class StartVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigationController = navigationController {
            let loginC = LoginC(navigationController: navigationController)
            loginC.start()
        }
    }
}
