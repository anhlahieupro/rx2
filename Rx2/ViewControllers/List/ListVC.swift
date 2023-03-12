import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ListVC: ViewController<ListVM, ListC> {
    
    @IBOutlet weak var tableView: UITableView!
    
    let getList = PublishRelay<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Users"
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: UITableViewCell.className)
    }
    
    override func setupVM(output: ListVM.Output) {
        output.response
            .map({ $0?.data ?? [] })
            .bind(to: tableView.rx.items(cellIdentifier: UITableViewCell.className)) { index, model, cell in
                cell.textLabel?.text = model.email
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(User.self)
            .bind(onNext: { [weak self] user in
                self?.coordinator.goToDetail(user)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .bind(onNext: { [weak self] in
                self?.tableView.deselectRow(at: $0, animated: true)
            }).disposed(by: disposeBag)
        
        getList.accept(())
    }
    
    override func initInput() -> ListVM.Input {
        return ListVM.Input(getList: getList.asObservable())
    }
}
