import UIKit
import RxSwift
import RxCocoa

class ViewController<VM: ViewModel,  C: Coordinator>: UIViewController {
    
    var viewModel: VM!
    weak var coordinator: C!
    
    let disposeBag = DisposeBag()
    
    init(viewModel: VM, coordinator: C, vc: ViewController.Type) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        
        super.init(nibName: vc.className,
                   bundle: Bundle(for: vc))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let input = initInput()
        let output = getOutput(input: input)
        setupVM(output: output)
    }
    
    func setupVM(output: VM.Output) {
        fatalError("")
    }
    
    func initInput() -> VM.Input {
        fatalError("")
    }
    
    func getOutput(input: VM.Input) -> VM.Output {
        return viewModel.transform(input)
    }
}
