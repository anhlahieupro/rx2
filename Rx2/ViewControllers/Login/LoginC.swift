import UIKit

final class LoginC: Coordinator {
    var navigationController: UINavigationController
    
    var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController, parentCoordinator: Coordinator? = nil) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let vm = LoginVM()
        let c = self
        let controller = LoginVC.self
        let vc = LoginVC.init(viewModel: vm, coordinator: c, vc: controller)
        
        navigationController.viewControllers = [vc]
    }
}
