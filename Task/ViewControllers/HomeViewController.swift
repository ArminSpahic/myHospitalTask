    //
    //  ViewController.swift
    //  Task
    //
    //  Created by Armin Spahic on 15/08/2018.
    //  Copyright © 2018 Armin Spahic. All rights reserved.
    //

    import UIKit

    class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DoctorHeaderDelegate {
        
        @IBOutlet weak var tableView: UITableView!
        var viewModel: HomePageViewModel?
        var numberOfCellsInFirstSection = 2
        let anamnesisQuestionCount = Float(NumberOfQuestions().anamnesisQuestionCount)
        var headerHeight : CGFloat = 236;
        
        override func viewDidLoad() {
            super.viewDidLoad()
            addSignOutButton()
            setupLogoImage()
            tableViewSetup()
            UserDataService.shared.populateData() { (model) -> Void in
                self.viewModel = model
                tableView.delegate = self
                tableView.dataSource = self
            }
        }
        //MARK: View Setup
        func setupLogoImage() {
            let logoImage = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 77, height: 20))
            logoImage.image = UIImage.init(named: "mdoc-gray")
            logoImage.contentMode = .center
            navigationItem.titleView = logoImage
        }
        
        func addSignOutButton() {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(signOut))
        }
        
        @objc func signOut() {
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LogInViewController")
            self.present(vc, animated: true, completion: nil)
        }
        
        override func viewWillAppear(_ animated: Bool) {
            tableView.estimatedRowHeight = 100
            tableView.rowHeight = UITableViewAutomaticDimension
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableViewAutomaticDimension
        }
        
        func tableViewSetup() {
            tableView.register(UINib(nibName: "TherapyPlanCell", bundle: nil), forCellReuseIdentifier: "therapyCell")
            tableView.register(UINib(nibName: "MealPlanCell", bundle: nil), forCellReuseIdentifier: "mealPlanCell")
            tableView.register(UINib(nibName: "MyClinicCell", bundle: nil), forCellReuseIdentifier: "myClinicCell")
            tableView.register(UINib(nibName: "QuestionCell", bundle: nil), forCellReuseIdentifier: "questionCell")
            tableView.separatorStyle = .none
        }
        
        //MARK: Table View delegate and datasource methods
        func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return CGFloat.leastNormalMagnitude
        }

        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return (viewModel?.presentOrder.count)!
        }
        
        @objc func buttonTapped(_ sender:UIButton!){
            self.performSegue(withIdentifier: "showController", sender: sender)
        }
        
 
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return cellForPosition(position: (viewModel?.presentOrder[indexPath.row])!)
        }
        
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = Bundle.main.loadNibNamed("DoctorTableHeader", owner: self, options: nil)?.first as? DoctorTableHeader
            headerView?.delegate = self;
            headerView?.updateDoctorInfo(docInfo: (viewModel?.doctorInfo)!)
            headerView?.updateMessageInfo(msgInfo: (viewModel?.messageInfo)!)
            return headerView
        }
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return headerHeight
        }
        
        func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
            return true
        }
        
        func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
            tableView.reloadData()
        }
        
        func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
            return false
        }
        
        func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
            return .none
        }
        
        //MARK: Tableview reorder cells methods
        func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
            let item = viewModel?.presentOrder[sourceIndexPath.row] as! String
            viewModel?.presentOrder.remove(at: sourceIndexPath.row)
            viewModel?.presentOrder.insert(item, at: destinationIndexPath.row)
            let defaults = UserDefaults.standard
            defaults.set(viewModel?.presentOrder, forKey: "SavedOrderArray")
            //tableView.reloadData()
        }
        
        @IBAction func editBtnPressed(_ sender: UIBarButtonItem) {
            self.tableView.isEditing = !self.tableView.isEditing
            sender.title = (self.tableView.isEditing) ? "Done" : "Edit"
        }
        
        
        @objc func removeCell(sender: AnyObject) {
            numberOfCellsInFirstSection = 1
            tableView.deleteRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
           
        }
        
        //MARK: Switch cases for reordering
        func cellForPosition(position : String) -> UITableViewCell{
            switch position {
            case "therapy":
                let cell = tableView.dequeueReusableCell(withIdentifier: "therapyCell") as! TherapyPlanCell
                cell.updateTherapyPlan(therapies: (viewModel?.Therapy?.therapies)!)
                cell.updateDatesInTherapyPlan(dates: (viewModel?.dates)!)
                return cell
                //break
            case "meal":
                let cell = tableView.dequeueReusableCell(withIdentifier: "mealPlanCell") as! MealPlanCell
                cell.updateMealUI(meal: (viewModel?.mealPlan)!)
                return cell
                //break
            case "clinic":
                let cell = tableView.dequeueReusableCell(withIdentifier: "myClinicCell") as! MyClinicCell
                cell.updateClinicUI(clinicInfo: (viewModel?.myClinicInfo)!)
                return cell
                //break
            case "question":
                let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell") as! QuestionCell
                cell.updateQuestions(questions: (viewModel?.questions)!)
                if let anamnesisAnswerCount = viewModel?.anamnesisAnswers.count,
                    let feedbackAnswerCount = viewModel?.feedbackAnswers.count,
                    let scoringAnswerCount = viewModel?.scoringAnswers.count {
                    cell.anamnesisAnswerCount.text = "Answers \(anamnesisAnswerCount)/\(NumberOfQuestions().anamnesisQuestionCount)"
                    cell.feedbackAnswerCount.text = "Answers \(feedbackAnswerCount)/\(NumberOfQuestions().feedbackQuestionCount)"
                    cell.scoringAnswerCount.text = "Answers \(scoringAnswerCount)/\(NumberOfQuestions().scoringQuestionCount)"
                    cell.anamnesisProgressView.progress = Float(anamnesisAnswerCount) / Float(NumberOfQuestions().anamnesisQuestionCount)
                    cell.feedbackProgressView.progress = Float(feedbackAnswerCount) / Float(NumberOfQuestions().feedbackQuestionCount)
                    cell.scoringProgressView.progress = Float(scoringAnswerCount) / Float(NumberOfQuestions().scoringQuestionCount)
                }
                return cell
                //break
            default:
                break
            }
            
            return UITableViewCell()
        }
        
        func didTapViewChecklistInHeader() {
            performSegue(withIdentifier: "showController", sender: self)
        }
        
        func didTapDismissInHeader() {
            headerHeight = 65;
            UIView.transition(with: tableView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                () -> Void in
                self.tableView.reloadData()
            }, completion: nil)
        }
        
        
    }

