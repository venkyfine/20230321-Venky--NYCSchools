import UIKit

class SchoolTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    func setData(school: School?) {
        nameLabel.text = school?.name
    }
}
