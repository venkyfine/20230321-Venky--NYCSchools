import Foundation

class SchoolViewModel {
    //MARK: class properties
    private var schoolResult: [School]?
    private var schoolWebService: SchoolWebService
    weak var delegate: APIResponseProtocol?

    init() {
        // initialise the webservice instance
        self.schoolWebService = SchoolWebService(urlString: Constant.schoolURLString)
    }

    // Get school for given index
    func school(at index: Int) -> School? {
        let school  = schoolResult?.filter { school in
            return (school.name != nil)
        }
        return school?[index]
    }

    // Number of Schools
    func numberOfSchools() -> Int {
        return schoolResult?.count ?? 0
    }
    
    // call the API to fetch data from server
    func fetchSchools() {
        self.schoolWebService.getSchools() { [weak self] (schoolResult, error) in
            guard let this = self else { return }
            if let error = error { // failure condition
                this.delegate?.errorHandler(error: error)
            } else {
                this.schoolResult = schoolResult
                this.delegate?.didReceiveResponse()
            }
        }
    }
}
