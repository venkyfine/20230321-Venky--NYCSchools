import UIKit

protocol APIResponseProtocol: AnyObject {
    func didReceiveResponse()
    func errorHandler(error: APIError)
}

class ViewController: UIViewController {
    private lazy var schoolVM = SchoolViewModel()
    @IBOutlet weak var schoolTableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        self.schoolVM.fetchSchools()
    }
    func setUp() {
        self.schoolVM.delegate = self
        self.title = "Schools"
        self.schoolTableView.register(UINib(nibName: Constant.schoolTableCellName, bundle: nil), forCellReuseIdentifier: Constant.schoolTableCellIdentifier)
        self.schoolTableView.estimatedRowHeight = 100
        self.schoolTableView.rowHeight = UITableView.automaticDimension
    }
}

// MARK: Table View Data Source
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.schoolTableCellIdentifier, for: indexPath) as? SchoolTableViewCell else { return UITableViewCell() }
        let currentSchool = self.schoolVM.school(at: indexPath.row)
        cell.setData(school: currentSchool)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolVM.numberOfSchools()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let schoolDetailVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: Constant.schoolDetailViewController) as? SchoolDetailViewController
        self.navigationController?.pushViewController(schoolDetailVC!, animated: true)
    }
}

// MARK: API response
extension ViewController: APIResponseProtocol {
    func errorHandler(error: APIError) {
        DispatchQueue.main.async {
            self.presentAlert(withTitle: "Error", message: error.errorDescription ?? "")
            self.indicator.stopAnimating()
        }
    }

    func didReceiveResponse() {
        DispatchQueue.main.async {
            self.schoolTableView.isHidden = false
            self.schoolTableView.reloadData()
            self.indicator.stopAnimating()
        }
    }
}

