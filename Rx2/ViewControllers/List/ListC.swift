import UIKit

class ListC: Coordinator {
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
        let vm = ListVM()
        let c = self
        let controller = ListVC.self
        let vc = ListVC(viewModel: vm,
                        coordinator: c,
                        vc: controller)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToDetail(_ user: User) {
        let detailC = DetailC(navigationController: navigationController,
                              parentCoordinator: self,
                              user: user)
        
        detailC.start()
        // childCoordinators.append(detailC)
    }
}
