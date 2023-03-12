import UIKit

protocol Coordinator: AnyObject {
    var id: TimeInterval { get }
    var navigationController: UINavigationController { get set }
    var parentCoordinator: Coordinator? { get set }
    // var childCoordinators: [Coordinator] { get set }
    
    func start()
}
