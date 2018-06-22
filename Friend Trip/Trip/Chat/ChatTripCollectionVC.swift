//
//  ChatTripCollectionVC.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 20/06/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//
import Foundation
import UIKit

class ChatTripCollectionVC: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {

    var containerViewBottomAnchor: NSLayoutConstraint?

    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Digite a mensagem..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    } ()

    lazy var inputContainerView: UIView = {

        let containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        containerView.backgroundColor = UIColor.white


        let sendButton = UIButton()
        sendButton.setTitle("Enviar", for: .normal)
        sendButton.setTitleColor(UIColor.blue, for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        containerView.addSubview(sendButton)

        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true

        containerView.addSubview(self.inputTextField)

        self.inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        self.inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        self.inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        self.inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true

        let separatorLineView = UIView()
        separatorLineView.backgroundColor = UIColor.black
        separatorLineView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(separatorLineView)

        separatorLineView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        separatorLineView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        separatorLineView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        separatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true

        return containerView
    }()

    override var inputAccessoryView: UIView? {
        get {
            return inputContainerView
        }
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    let cellChatID = "cellChatID"

    var messagesTrip = [MessageModel]()



    var messages = ["Bom dia, galera! 20h hoje em!", "Boa!S SIMM!!", "Vou me atrasar um pouco =/, mas eu vou.","Sem problemas"]

    func setMessagesTest() {

        let jsonUser: [String : Any] = ["picture":
            [ "data":
                [ "height": 200,
                  "is_silhouette": 0,
                  "url": "https://lookaside.facebook.com/platform/profilepic/?asid=1571861286232650&height=200&width=200&ext=1523583752&hash=AeQydwWTSzPh8O8K",
                  "width": 200 ]

            ],
                                        "name": "Fernando Santos", "email": "fernandin222@hotmail.com", "id": "1571861286232650"]

        let jsonUse2: [String : Any] = ["picture":
            [ "data":
                [ "height": 200,
                  "is_silhouette": 0,
                  "url": "https://lookaside.facebook.com/platform/profilepic/?asid=1571861286232650&height=200&width=200&ext=1523583752&hash=AeQydwWTSzPh8O8K",
                  "width": 200 ]

            ],
                                        "name": "Fernando Santos 2", "email": "fernandin222@hotmail.com", "id": "1571861286232690"]
        
        let m1 = MessageModel()
        m1.user = UserFace(JSON: jsonUser)
        m1.message = "Mensagem de testes para a lista"

        let m2 = MessageModel()
        m1.user = UserFace(JSON: jsonUse2)
        m1.message = "Mais testes de mensagem para m2"

        let m3 = MessageModel()
        m1.user = UserFace(JSON: jsonUse2)
        m1.message = "Mensagem de testes para a lista com m3"

        let m4 = MessageModel()
        m1.user = UserFace(JSON: jsonUser)
        m1.message = "Só m4"

        messagesTrip.append(m1)
        messagesTrip.append(m2)
        messagesTrip.append(m3)
        messagesTrip.append(m4)

        collectionView?.reloadData()

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setMessagesTest()

        navigationItem.title = "Chat"
        navigationController?.navigationBar.backgroundColor = UIColor(named: "ColorTransparent")

        collectionView?.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 58, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(ChatCollectionViewCell.self, forCellWithReuseIdentifier: cellChatID)

        collectionView?.keyboardDismissMode = .interactive

//        setupKeyBoardObservers()

    }

    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }

    func setupKeyBoardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

    }

    @IBAction func dismissKeyboard(){
        view.endEditing(true)
        collectionView?.endEditing(true)
    }

    @IBAction func handleKeyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue {
            containerViewBottomAnchor?.constant = -keyboardFrame.height
            if let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue {
                UIView.animate(withDuration: keyboardDuration, animations: {
                    self.view.layoutIfNeeded()
                    })
            }
        }
    }

    @IBAction func handleKeyboardWillHidden(notification: NSNotification) {
        containerViewBottomAnchor?.constant = 0
        if let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue {
            UIView.animate(withDuration: keyboardDuration, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellChatID, for: indexPath) as! ChatCollectionViewCell

        cell.textView.text = messages[indexPath.row]
        cell.bubbleWidthAnchor?.constant = estimateFrameForText(text: messages[indexPath.row]).width + 32

        if indexPath.row == 2 {
            cell.profileImageView.image = UIImage(named: "img_profile1")
            cell.bubbleView.backgroundColor = UIColor.gray
            cell.profileImageView.isHidden = true
            cell.bubbleViewRightAnchor?.isActive = true
            cell.bubbleViewLeftAnchor?.isActive = false
        } else
            if indexPath.row == 1 {

                cell.profileImageView.image = UIImage(named: "img_profile3")
                cell.bubbleView.backgroundColor = UIColor.blue
                cell.bubbleViewRightAnchor?.isActive = false
                cell.bubbleViewLeftAnchor?.isActive = true
                cell.profileImageView.isHidden = false
        } else {
            cell.profileImageView.image = UIImage(named: "img_profile2")
            cell.bubbleView.backgroundColor = UIColor.blue
            cell.bubbleViewRightAnchor?.isActive = false
            cell.bubbleViewLeftAnchor?.isActive = true
            cell.profileImageView.isHidden = false
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 80
        let textMsg = messages[indexPath.row]
        height = estimateFrameForText(text: textMsg).height + 20
        return CGSize(width: view.frame.width, height: height)
    }

    func estimateFrameForText(text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 16)], context: nil)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSend()
        return true
    }

    @IBAction func handleSend() {
        if let txt = inputTextField.text {
            messages.append(txt)
            collectionView?.reloadData()
            inputTextField.text = nil
        }
    }

}









