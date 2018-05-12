//
//  ProfileTableVC.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 27/02/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit
import Kingfisher
import FacebookLogin

class ProfileTableVC: UITableViewController {

    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var labelProfile: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var viewBackGround: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()

        getUserInfo()

        setGradientBackGround()
    }

    func getUserInfo() {

        indicatorView.startAnimating()
        
        DataManager().checkAccessData(completion: { (success, accessToken) in

            if let accessToken = accessToken{
                LoginFBRequest().getUserInfo(accessToken: accessToken){ result, error in
                    if let result = result{
                        guard let userFace = UserFace(JSON: result) else {
                            return
                        }

                        let userViewModel = ProfileViewModel(userFace: userFace)
                        let urlImage = URL(string: userViewModel.imageURL)
                        self.imageViewProfile.kf.setImage(with: urlImage)
                        self.labelProfile.text = userViewModel.nameProfile
                        self.labelEmail.text = userViewModel.emailProfile
                    }
                    self.indicatorView.stopAnimating()
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logout(_ sender: Any) {
        let alertSheet = UIAlertController(title: "", message: "Deseja deslogar?", preferredStyle: .actionSheet)
        alertSheet.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { action in
            LoginManager().logOut()
            self.dismiss(animated: true, completion: nil)
        }))
        alertSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))

        present(alertSheet, animated: true, completion: nil)

    }

    func setupViews() {
        indicatorView.hidesWhenStopped = true
    }

    func setGradientBackGround(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.tableView.bounds

        let colorTop = UIColor(named: "ColorOrangeGrandientTop")
        let colorBottom = UIColor(named: "ColorPinkGradientBottom")
        gradientLayer.colors =  [colorTop, colorBottom].map{$0?.cgColor}
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.2)
        let backgroundView = UIView(frame: self.tableView.bounds)
        backgroundView.layer.addSublayer(gradientLayer)
        self.tableView.backgroundView = backgroundView
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    // MARK: - Table view data source
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
