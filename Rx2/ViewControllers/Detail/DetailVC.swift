import UIKit

class DetailVC: ViewController<DetailVM, DetailC> {
    
    @IBOutlet weak var okButton: UIButton!
    
    var user: User!
    
    deinit {
        print("")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = user.email
    }
    
    override func setupVM(output: DetailVM.Output) {
        okButton.rx.tap
            .bind { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }.disposed(by: disposeBag)
    }
    
    override func initInput() -> DetailVM.Input {
        return DetailVM.Input()
    }
}
