import UIKit
import MBProgressHUD

final class LoginVC: ViewController<LoginVM, LoginC> {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var messageLabel: UILabel!    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupVM(output: LoginVM.Output) {
        output.isLoading
            .drive(onNext: { [weak self] isLoading in
                guard let self = self else { return }
                
                if !isLoading {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    return
                }
                
                MBProgressHUD.showAdded(to: self.view, animated: true)
            })
            .disposed(by: disposeBag)
        
        output.message
            .drive(messageLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.enableLogin
            .drive(loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    override func initInput() -> LoginVM.Input {
        return LoginVM.Input.init(email: emailTF.rx.text.orEmpty.asObservable(),
                                  password: passwordTF.rx.text.orEmpty.asObservable(),
                                  login: loginButton.rx.tap.asObservable())
    }
}
