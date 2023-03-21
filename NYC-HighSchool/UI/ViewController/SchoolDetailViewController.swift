import UIKit

protocol SchoolDetailAPIResponseProtocol: AnyObject {
    func didReceiveResponse()
    func errorHandler(error: APIError)
}

class SchoolDetailViewController: UIViewController {
    private lazy var schoolDetailVM = SchoolDetailViewModel()
    @IBOutlet weak var schoolDetailTableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        self.schoolDetailVM.fetchSchoolDetail()
    }
    func setUp() {
        self.schoolDetailVM.delegate = self
        self.schoolDetailTableView.register(UINib(nibName: Constant.schoolDetailTableCellName, bundle: nil), forCellReuseIdentifier: Constant.schoolDetailTableCellIdentifier)
        self.schoolDetailTableView.estimatedRowHeight = 100
        self.schoolDetailTableView.rowHeight = UITableView.automaticDimension
    }
}

// MARK: Table View Data Source
extension SchoolDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.schoolDetailTableCellIdentifier, for: indexPath) as? SchoolDetailTableViewCell else { return UITableViewCell() }
        let currentSchoolDetail = self.schoolDetailVM.schoolDetail(at: indexPath.row)
        cell.setData(schoolDetail: currentSchoolDetail)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolDetailVM.numberOfResults()
    }
}

// MARK: API response
extension SchoolDetailViewController: SchoolDetailAPIResponseProtocol {
    func errorHandler(error: APIError) {
        DispatchQueue.main.async {
            self.presentAlert(withTitle: "Error", message: error.errorDescription ?? "")
            self.indicator.stopAnimating()
        }
    }

    func didReceiveResponse() {
        DispatchQueue.main.async {
            self.schoolDetailTableView.isHidden = false
            self.schoolDetailTableView.reloadData()
            self.indicator.stopAnimating()
        }
    }
}
