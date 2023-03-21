import Foundation

class SchoolDetailViewModel {
    //MARK: class properties
    private var schoolDetailResult: [SchoolDetail]?
    private var schoolDetailWebService: SchoolWebService
    weak var delegate: SchoolDetailAPIResponseProtocol?

    init() {
        // initialise the webservice instance
        self.schoolDetailWebService = SchoolWebService(urlString: Constant.schoolDetailURLString)
    }

    // Get school for given index
    func schoolDetail(at index: Int) -> SchoolDetail? {
        let schoolDetail  = schoolDetailResult?.filter { schoolDetail in
            return (schoolDetail.maths != nil)
        }
        return schoolDetail?[index]
    }

    // Number of Schools
    func numberOfResults() -> Int {
        return schoolDetailResult?.count ?? 0
    }
    
    // call the API to fetch data from server
    func fetchSchoolDetail() {
        self.schoolDetailWebService.getSchoolDetail() { [weak self] (schoolDetailResult, error) in
            guard let this = self else { return }
            if let error = error { // failure condition
                this.delegate?.errorHandler(error: error)
            } else {
                this.schoolDetailResult = schoolDetailResult
                this.delegate?.didReceiveResponse()
            }
        }
    }
}
