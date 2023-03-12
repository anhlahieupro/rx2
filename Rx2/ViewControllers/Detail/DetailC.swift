import UIKit

class DetailC: Coordinator {
    var id: TimeInterval
    var navigationController: UINavigationController
    
    var parentCoordinator: Coordinator?
    // var childCoordinators: [Coordinator] = []
    
    var user: User!
    
    deinit {
        print("")
    }
    
    init(navigationController: UINavigationController,
         parentCoordinator: Coordinator? = nil,
         user: User) {
        
        self.id = Date().timeIntervalSince1970
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        
        self.user = user
    }
    
    func start() {
        let vm = DetailVM()
        let c = self
        let controller = DetailVC.self
        let vc = DetailVC(viewModel: vm,
                          coordinator: c,
                          vc: controller)
        
        vc.user = user
        
        navigationController.pushViewController(vc, animated: true)
    }
}
