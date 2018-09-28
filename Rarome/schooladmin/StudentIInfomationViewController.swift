//
//  StudentIInfomationViewController.swift
//  Rarome
//
//  Created by AntonDream on 8/1/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class StudentIInfomationViewController: UITableViewController {

    var selectedIndexPath: IndexPath?
    
    var sImgUrl: String!
    var sUserName: String!
    var sGrade: String!
    var sSection: String!
    var sRoll: String!
    var sEnrollmenDate: String!
    var sICardNumber: String!
    var sPreviousSchool: String!
    var sCourse: String!
    var sPassportNumber: String!
    var sGender: String!
    var sDateOfBirth: String!
    var sAge: String!
    var sStatus: String!
    var sSend: String!
    var sPhone: String!
    var sEmail: String!
    var sEmergencyContantNumber: String!
    var sNameOfEmergencyContact: String!
    var sRelationFoEmergecyContactWithChild: String!
    var sAddress: String!
    var sPlaceOfBirth: String!
    var sCountry: String!
    var sFatherName: String!
    var sFatherPhone: String!
    var sFatherEmail: String!
    var sMotherName: String!
    var sMotherPhone: String!
    var sMotherEmail: String!
    
    var sBusName: String!
    var sBusNumber: String!
    var sRouteName: String!
    var sDriverName: String!
    var sDriverPhoneNumber: String!
    
    var sHostelName: String!
    var sType: String!
    var sFloorName: String!
    var sRoomNo: String!
    var sFood: String!
    var sRegidterationDate: String!
    var sVacatingDate: String!
    var sTransferDate: String!
    var sDomitoryInfoStatus: String!
    
    var sDocumentsTitles = [String]()
    var sDocumentsDates = [String]()
    var sDocumentsSizes = [String]()
    
    var sExtracurricularCertificates = [String]()
    var sIssueDates = [String]()
    
    var sImmunizationFileNames: String!
    var sImmunizationFile: String!
    var dMedicalProblem: String!
    var sDescription: String!
    var sConsultingType: String!
    var sDiagnosis: String!
    var sDiseases = [String]()
    var sDates = [String]()
    var sDescriptions = [String]()
    var sPrescriptions = [String]()
    
    var sMonths = [String]()
    var sDays = [Int]()
    var sPercents = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sGrade = GlobalConst.glb_studentGrade
        getStudentInfo()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "gotoGeneralInformationTableCell", for: indexPath) as! GeneralInfomationTabelCell
            if (sImgUrl != nil) && (sImgUrl.count) > 4 {
                let photourl = GlobalConst.glb_studentImg_path + sImgUrl
                let session = URLSession(configuration: .default)
                let url = URL(string: photourl)!
                let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
                    if let e = error {
                        DispatchQueue.main.async{
                            cell.imgView_userPhoto.image = UIImage(named: "ic_userPhoto")
                        }
                    } else {
                        if let res = response as? HTTPURLResponse {
                            print("Downloaded cat picture with response code \(res.statusCode)")
                            if let imageData = data {
                                let image = UIImage(data: imageData)
                                if ((image?.size) != nil){
                                    DispatchQueue.main.async{
                                        if let updateCell = tableView.cellForRow(at: indexPath){
                                            let cell = updateCell as! GeneralInfomationTabelCell
                                            cell.imgView_userPhoto?.image = image
                                        }
                                    }
                                } else {
                                    DispatchQueue.main.async{
                                        cell.imgView_userPhoto.image = UIImage(named: "ic_userPhoto")
                                    }
                                }
                            } else {
                                DispatchQueue.main.async{
                                    cell.imgView_userPhoto.image = UIImage(named: "ic_userPhoto")
                                }
                            }
                        } else {
                            DispatchQueue.main.async{
                                cell.imgView_userPhoto.image = UIImage(named: "ic_userPhoto")
                            }
                        }
                    }
                }
                downloadPicTask.resume()
            }
            return setGeneralInformation(cell: cell)
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "gotoParentInfoTableCell", for: indexPath) as! ParentInfoTableCell
            return setParentInfo(cell: cell)
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "gotoGradeRoutineTableViewCell", for: indexPath) as! GradRoutineTabelViewCell
            return setGradeRoutine(cell: cell)
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "gotoLiberaryInformationTableViewCell", for: indexPath) as! LibraryInfomationTableViewCell
            return setLlibraryInformation(cell: cell)
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "gotoTransportInformationTableViewCell", for: indexPath) as! TransportInformationTableCell
            return setTransportInformation(cell: cell)
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "gotoDomitoryInformation", for: indexPath) as! DomitoryInformationTableCell
            return setDomitoryInfo(cell: cell)
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "gotoDocumentsTableViewCell", for: indexPath) as! DocumentsTabelViewCell
            return setDocumentsInfo(cell: cell)
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: "gotoExtraurricularTableViewCell", for: indexPath) as! ExtracurricularActivitiesAwardsTableViewCell
            return setExtracurricularInfo(cell: cell)
        case 8:
            let cell = tableView.dequeueReusableCell(withIdentifier: "gotoMedicalRecirdTableViewCell", for: indexPath) as! MedicalRecordTableViewCell
            return setMedicalRecordInfo(cell: cell)
        case 9:
            let cell = tableView.dequeueReusableCell(withIdentifier: "gotoAttendanceRecordeTableCell", for: indexPath) as! AttendanceRecordTableViewCell
            return setAttendaceRecordInfo(cell: cell)
        default:
            break
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previousIndexPath = selectedIndexPath
        if indexPath == selectedIndexPath{
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        
        tableView.reloadData()
        var indexPaths: Array<IndexPath> = []
        if let previous = previousIndexPath {
            indexPaths += [previous]
        }
        if let current = selectedIndexPath {
            indexPaths += [current]
        }
        if indexPaths.count > 0 {
            tableView.reloadRows(at: indexPaths as [IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            (cell as! GeneralInfomationTabelCell).watchFrameChanges()
        case 1:
            (cell as! ParentInfoTableCell).watchFrameChanges()
        case 2:
            (cell as! GradRoutineTabelViewCell).watchFrameChanges()
        case 3:
            (cell as! LibraryInfomationTableViewCell).watchFrameChanges()
        case 4:
            (cell as! TransportInformationTableCell).watchFrameChanges()
        case 5:
            (cell as! DomitoryInformationTableCell).watchFrameChanges()
        case 6:
            (cell as! DocumentsTabelViewCell).watchFrameChanges()
        case 7:
            (cell as! ExtracurricularActivitiesAwardsTableViewCell).watchFrameChanges()
        case 8:
            (cell as! MedicalRecordTableViewCell).watchFrameChanges()
        case 9:
            (cell as! AttendanceRecordTableViewCell).watchFrameChanges()
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            (cell as! GeneralInfomationTabelCell).ignoreFrameChanges()
        case 1:
            (cell as! ParentInfoTableCell).ignoreFrameChanges()
        case 2:
            (cell as! GradRoutineTabelViewCell).ignoreFrameChanges()
        case 3:
            (cell as! LibraryInfomationTableViewCell).ignoreFrameChanges()
        case 4:
            (cell as! TransportInformationTableCell).ignoreFrameChanges()
        case 5:
            (cell as! DomitoryInformationTableCell).ignoreFrameChanges()
        case 6:
            (cell as! DocumentsTabelViewCell).ignoreFrameChanges()
        case 7:
            (cell as! ExtracurricularActivitiesAwardsTableViewCell).ignoreFrameChanges()
        case 8:
            (cell as! MedicalRecordTableViewCell).ignoreFrameChanges()
        case 9:
            (cell as! AttendanceRecordTableViewCell).ignoreFrameChanges()
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == selectedIndexPath {
            switch indexPath.section {
            case 0:
                return GeneralInfomationTabelCell.expendedHeight
            case 1:
                return ParentInfoTableCell.expendedHeight
            case 2:
                return GradRoutineTabelViewCell.expendedHeight
            case 3:
                return LibraryInfomationTableViewCell.expendedHeight
            case 4:
                return TransportInformationTableCell.expendedHeight
            case 5:
                return DomitoryInformationTableCell.expendedHeight
            case 6:
                return DocumentsTabelViewCell.expendedHeight
            case 7:
                return ExtracurricularActivitiesAwardsTableViewCell.expendedHeight
            case 8:
                return MedicalRecordTableViewCell.expendedHeight
            case 9:
                return AttendanceRecordTableViewCell.expendedHeight
            default:
                return 400
            }
        } else {
            return 50
        }
    }
    
    
    func getStudentInfo(){
        let userid: String = GlobalConst.glb_sUserId
        let usertype: String = GlobalConst.glb_sUserType
        let schoolid: String = GlobalConst.glb_sSchoolID
        let runing_year: String = GlobalConst.glb_sRunning_year
        let studentid: String = GlobalConst.glb_studentID
        let url = URL(string: "https://demo.rarome.com/index.php/?api/student_profile")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "school_id=\(schoolid)&running_year=\(runing_year)&user_type=\(usertype)&user_id=\(userid)&student_id=\(studentid)"
        request.httpBody = postString.data(using: .utf8);
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            do{
                let parseData = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                let iStatus = parseData["status"] as! Int
                let sMessage = parseData["message"] as! String
                if iStatus == 1 {
                    let result = parseData["general_information"] as! [String:AnyObject]
                    self.sImgUrl = result["stud_image"] as? String
                    let sStudentName = result["name"] as? String
                    let sStudentLName = result["lname"] as? String
                    let sStudentFullName: String!
                    sStudentFullName = "\(sStudentName ?? "") \(sStudentLName ?? "")"
                    self.sUserName = sStudentFullName
                    self.sSection = result["section_name"] as? String
                    self.sRoll = result["roll"] as? String
                    self.sEnrollmenDate = result["date_time"] as? String
                    self.sICardNumber = result["icard_no"] as? String
                    self.sPreviousSchool = result["previous_school"] as? String
                    self.sCourse = result["course"] as? String
                    self.sPassportNumber = result["passport_no"] as? String
                    self.sGender = result["sex"] as? String
                    self.sDateOfBirth = result["birthday"] as? String
                    self.sAge = result["age"] as? String
                    self.sStatus = result["isActive"] as? String
                    self.sSend = result["send"] as? String
                    self.sPhone = result["phone"] as? String
                    self.sEmail = result["email"] as? String
                    self.sEmergencyContantNumber = result["emergency_contact_number"] as? String
                    self.sNameOfEmergencyContact = result["name_of_emergency_contact"] as? String
                    self.sRelationFoEmergecyContactWithChild = result["relation_of_emergency_contact"] as? String
                    self.sAddress = result["address"] as? String
                    self.sPlaceOfBirth = result["place_of_birth"] as? String
                    self.sCountry = result["country"] as? String
                    let fatherName = result["father_name"] as? String
                    self.sFatherName = "\(fatherName ?? "") \(sStudentLName ?? "")"
                    self.sFatherPhone = result["father_phone_number"] as? String
                    self.sFatherEmail = result["father_email"] as? String
                    let motherName = result["mother_name"] as? String
                    self.sMotherName = "\(motherName ?? "") \(sStudentLName ?? "")"
                    self.sMotherPhone = result["mother_mobile"] as? String
                    self.sMotherEmail = result["mother_email"] as? String
                    
                    let transportInfor = parseData["transport_info"] as! [String:AnyObject]
                    self.sBusName = transportInfor["bus_name"] as! String
                    self.sBusNumber = transportInfor["bus_unique_key"] as! String
                    let routeFrom = transportInfor["route_from"] as? String
                    let routeTo = transportInfor["route_to"] as? String
                    self.sMotherName = "\(routeFrom ?? "") To \(routeTo ?? "")"
                    self.sRouteName = transportInfor["bus_name"] as! String
                    self.sDriverName = transportInfor["bus_driver_name"] as! String
                    self.sDriverPhoneNumber = transportInfor["phone"] as! String
                    
                    let domitoryInfo = parseData["dormitory_info"] as! [String:AnyObject]
                    self.sHostelName = domitoryInfo["hostel_name"] as! String
                    self.sType = domitoryInfo["hostel_type"] as! String
                    self.sFloorName = domitoryInfo["floor_name"] as! String
                    self.sRoomNo = domitoryInfo["room_no"] as! String
                    self.sFood = domitoryInfo["food"] as! String
                    self.sRegidterationDate = domitoryInfo["register_date"] as! String
                    self.sVacatingDate = domitoryInfo["vacating_date"] as! String
                    self.sTransferDate = domitoryInfo["transfer_date"] as? String
                    self.sDomitoryInfoStatus = domitoryInfo["status"] as! String
                    
                    let documentsInfo = parseData["documents"] as! [[String:AnyObject]]
                    for documentInfo in documentsInfo {
                        let title = documentInfo["name"] as? String
                        self.sDocumentsTitles.append(title!)
                        let date = documentInfo["issue_date"] as? String
                        self.sDocumentsDates.append(date!)
                        let size = documentInfo["size"] as? String
                        self.sDocumentsSizes.append(size!)
                    }
                    
                    let extracurricularsInfo = parseData["extra_curricular_rewards"] as! [[String:AnyObject]]
                    for extracurricularInfo in extracurricularsInfo {
                        let title = extracurricularInfo["certificate_title"] as? String
                        self.sExtracurricularCertificates.append(title!)
                        let date = extracurricularInfo["date"] as? String
                        self.sIssueDates.append(date!)
                    }
                    
                    let medicalRecordInfo = parseData["medical_record"] as! [String:AnyObject]
                    let immunizationRecords = medicalRecordInfo["imunization_record"] as! [String:AnyObject]
                    self.sImmunizationFile = immunizationRecords["immunization_file"] as? String
                    self.sImmunizationFileNames = immunizationRecords["immunization_file_name"] as? String
                    let medicalProblem = medicalRecordInfo["medical_problem"] as! [String:AnyObject]
                    self.dMedicalProblem = medicalRecordInfo["desease_title"] as? String
                    self.sDescription = medicalRecordInfo["description"] as? String
                    self.sConsultingType = medicalRecordInfo["consulting_type"] as? String
                    self.sDiagnosis = medicalRecordInfo["diagnosis"] as? String
                    let medicalHistories = medicalRecordInfo["student_medical_history"] as! [[String:AnyObject]]
                    for medicalHistory in medicalHistories {
                        let disease = medicalHistory["desease_title"] as? String
                        self.sDiseases.append(disease!)
                        let date = medicalHistory["consult_date"] as? String
                        self.sDates.append(date!)
                        let description = medicalHistory["description"] as? String
                        self.sDescriptions.append(description!)
                        let prescrption = medicalHistory["prescriptions"] as? String
                        self.sPrescriptions.append(prescrption!)
                    }
                    
                    let attendanceRecordInfo = parseData["attendance_data"] as! [String:AnyObject]
                    let records = attendanceRecordInfo["record"] as! [[String:AnyObject]]
                    for record in records {
                        let month = record["month"] as? String
                        self.sMonths.append(month!)
                        let days = record["total_days"] as? Int
                        self.sDays.append(days!)
                        let percent = record["total_attendance"] as? Int
                        self.sPercents.append(percent!)
                    }
                }
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }

    func setGeneralInformation(cell: GeneralInfomationTabelCell) -> GeneralInfomationTabelCell {
        cell.lbl_userName.text = sUserName
        cell.lbl_grade.text = sGrade
        cell.lbl_section.text = sSection
        cell.lbl_Roll.text = sRoll
        cell.lbl_enrollmentDate.text = sEmergencyContantNumber
        cell.lbl_iCardNumber.text = sICardNumber
        cell.lbl_previousSchool.text = sPreviousSchool
        cell.lbl_course.text = sCourse
        cell.lbl_passportNumber.text = sPassportNumber
        cell.lbl_gender.text = sGender
        cell.lbl_dateOfBirth.text = sDateOfBirth
        cell.lbl_age.text = sAge
        if sStatus == "1" {
            cell.lbl_status.text = "Active"
        } else {
            cell.lbl_status.text = "No Active"
        }
        cell.lbl_send.text = sSend
        cell.lbl_phone.text = sPhone
        cell.lbl_email.text = sEmail
        cell.lbl_emergencyContantNumber.text = sEmergencyContantNumber
        cell.lbl_nameOfEmergencyContact.text = sNameOfEmergencyContact
        cell.lbl_relationOfEmergencyContactWithChild.text = sRelationFoEmergecyContactWithChild
        cell.lbl_adress.text = sAddress
        cell.lbl_placeOfBirth.text = sPlaceOfBirth
        cell.lbl_country.text = sCountry
        return cell
    }

    func setParentInfo(cell: ParentInfoTableCell) -> ParentInfoTableCell {
        cell.lbl_fatherName.text = sFatherName
        cell.lbl_fatherPhone.text = sFatherPhone
        cell.lbl_fatherEmail.text = sFatherEmail
        cell.lbl_motherName.text = sMotherName
        cell.lbl_motherPhone.text = sMotherPhone
        cell.lbl_motherEmail.text = sMotherEmail
        return cell
    }
    
    func setGradeRoutine(cell: GradRoutineTabelViewCell) -> GradRoutineTabelViewCell {
        return cell
    }
    
    func setLlibraryInformation(cell: LibraryInfomationTableViewCell) -> LibraryInfomationTableViewCell{
        return cell
    }
    
    func setTransportInformation(cell: TransportInformationTableCell) -> TransportInformationTableCell{
        cell.lbl_busName.text = sBusName
        cell.lbl_busNumber.text = sBusNumber
        cell.lbl_routeNumber.text = sRouteName
        cell.lbl_drigerNumber.text = sDriverName
        cell.lbl_driverPhoneNumber.text = sDriverPhoneNumber
        return cell
    }
    
    func setDomitoryInfo(cell: DomitoryInformationTableCell) -> DomitoryInformationTableCell {
        cell.lbl_hostelName.text = sHostelName
        cell.lbl_type.text = sType
        cell.lbl_floorName.text = sFloorName
        cell.lbl_roomNo.text = sRoomNo
        cell.lbl_food.text = sFood
        cell.lbl_registeraionDate.text = sRegidterationDate
        cell.lbl_vocationDate.text = sVacatingDate
        cell.lbl_transferDate.text = sTransferDate
        cell.lbl_status.text = sDomitoryInfoStatus
        return cell
    }
    
    func setDocumentsInfo(cell: DocumentsTabelViewCell) -> DocumentsTabelViewCell {
        cell.sDocumentTitles = sDocumentsTitles
        cell.sDocumentDates = sDocumentsDates
        cell.sDocumentSizes = sDocumentsSizes
        return cell
    }
    
    func setExtracurricularInfo(cell: ExtracurricularActivitiesAwardsTableViewCell) -> ExtracurricularActivitiesAwardsTableViewCell {
        cell.sExtracurricularCertificates = sExtracurricularCertificates
        cell.sIssueDates = sIssueDates
        return cell
    }
    
    func setMedicalRecordInfo(cell: MedicalRecordTableViewCell) -> MedicalRecordTableViewCell {
        if sImmunizationFile != nil {
            cell.lbl_immunizationRecordTitle.text = "No Immunization Record"
            cell.btn_immunizationReport.isHidden = true
        } else {
            cell.lbl_immunizationRecordTitle.text = self.sImmunizationFile
        }
        cell.sImmunizationURL = self.sImmunizationFileNames
        cell.sMedicalProblem = self.dMedicalProblem
        cell.sDescription = self.description
        cell.sConsultingType = self.sConsultingType
        cell.sDiagnosis = self.sDiagnosis
        cell.sImmunizationURL = self.sImmunizationFileNames
        cell.sDiseases = self.sDiseases
        cell.sDates = self.sDates
        cell.sDescriptions = self.sDescriptions
        cell.sprescriptions = self.sPrescriptions
        return cell
    }
    
    func setAttendaceRecordInfo(cell: AttendanceRecordTableViewCell) -> AttendanceRecordTableViewCell{
        cell.sMonths = self.sMonths
        cell.sDays = self.sDays
        cell.sPercents = self.sPercents
        return cell
    }
    
    func showResult(){
        DispatchQueue.main.async(execute: {
            
        })        
    }
}
