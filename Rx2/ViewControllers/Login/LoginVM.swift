import UIKit
import RxSwift
import RxCocoa

final class LoginVM: ViewModel {
    struct Input {
        let email: Observable<String>
        let password: Observable<String>
        let login: Observable<Void>
    }
    
    struct Output {
        let isLoading: Driver<Bool>
        let message: Driver<String>
        let loginSuccess: Driver<Bool>
        let enableLogin: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let emailAndPassword = Observable.combineLatest(input.email, input.password) { email, password in
            return (email, password)
        }
        
        let enableLogin = emailAndPassword.map({ !$0.isEmpty && !$1.isEmpty })
        
        let activityIndicator = ActivityIndicator()
        
        let loginSuccess: BehaviorSubject<Bool> = .init(value: false)
        
        let message = input.login
            .withLatestFrom(emailAndPassword)
            .flatMap { email, password in
                
                return Api.request(url: ApiPath.login,
                                   method: .post,
                                   parameters: ["email": email, "password": password],
                                   ResponseType: LoginResponse.self)
                .trackActivity(activityIndicator)
                .map { response in
                    if let token = response.token, !token.isEmpty {
                        loginSuccess.onNext(true)
                        return "ok"
                    }
                    
                    return response.error ?? "error"
                }
                .catch { error in
                    if let error = error as? BaseError {
                        return .just(error.response?.error ?? "base error")
                    }
                    
                    return .just(error.localizedDescription)
                }
            }
        
        return Output(isLoading: activityIndicator.asDriver(onErrorJustReturn: false),
                      message: message.asDriver(onErrorJustReturn: ""),
                      loginSuccess: loginSuccess.asDriver(onErrorJustReturn: false),
                      enableLogin: enableLogin.asDriver(onErrorJustReturn: false))
    }
}
