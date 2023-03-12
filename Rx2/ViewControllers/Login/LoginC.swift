import UIKit

final class LoginC: Coordinator {
    var id: TimeInterval
    var navigationController: UINavigationController
    
    var parentCoordinator: Coordinator?
    // var childCoordinators: [Coordinator] = []
    
    deinit {
        print("")
    }
    
    init(navigationController: UINavigationController,
         parentCoordinator: Coordinator? = nil) {
        
        self.id = Date().timeIntervalSince1970
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let vm = LoginVM()
        let c = self
        let controller = LoginVC.self
        let vc = LoginVC(viewModel: vm,
                         coordinator: c,
                         vc: controller)
        
        navigationController.viewControllers = [vc]
    }
    
    func goToList() {
        let listC = ListC(navigationController: navigationController,
                          parentCoordinator: self)
        
        listC.start()
        // childCoordinators.append(listC)
    }
}
