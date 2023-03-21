import UIKit

class SchoolDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mathsLabel: UILabel!
    @IBOutlet weak var readingLabel: UILabel!
    @IBOutlet weak var writingLabel: UILabel!
    
    func setData(schoolDetail: SchoolDetail?) {
        nameLabel.text = "School Name: \(schoolDetail?.name ?? "")"
        mathsLabel.text = "Maths score: \(schoolDetail?.maths ?? "")"
        readingLabel.text = "Reading score: \(schoolDetail?.reading ?? "")"
        writingLabel.text = "Writing score: \(schoolDetail?.writing ?? "")"
    }
}
