//
//  LoginView.swift
//  MoLiao
//
//  Created by 华通众和 on 2019/2/28.
//  Copyright © 2019年 徐庆标. All rights reserved.
//

import UIKit

protocol LoginViewDelegate: NSObjectProtocol {
    func loginButtonClick(LoginView: LoginView, userName: String, password: String)
}

class LoginView: UIView {

    // 头像
    private let aPhoto = UIImageView()
    
    /// 账号
    let aTFPhone =  UITextField()
    /// 密码
    let aTFPassword =  UITextField()
    
    weak var delegate: LoginViewDelegate?
    
    //////// frame值 ////////
    /// x的值
    private let loginXSpace = frameLoginView.Fx.frame
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 1. 头像
        setUpUIViewWithPhoto()
        
        // 2. 账号登录界面
        let nameAndPwdView = setUIViewWithLoginView()
        self.addSubview(nameAndPwdView)
        
        // 3. 登录按钮
        let lgBtn = CGRect(x: loginXSpace, y: nameAndPwdView.frame.maxY + 35, width: nameAndPwdView.frame.width, height: 88)
        let loginBtnView = setupUIViewWithLoginBtn(frame: lgBtn)
        self.addSubview(loginBtnView)
        
        // 4. 快速登录View
        print("frame.maxY = \(frame.maxY)")
        let fastLoginF: CGRect = CGRect(x: 0, y: kScreenHeight - 140 - 64, width: kScreenWidth, height: 140)
        setupUIViewWithFastLogin(frame: fastLoginF)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 头像 View
extension LoginView {
    /// 头像 View 80 * 80
    private func setUpUIViewWithPhoto() {
        let aPY: CGFloat = 0
        let aPW: CGFloat = frameLoginView.FPhoto.frame
        let aPH: CGFloat = frameLoginView.FPhoto.frame

        aPhoto.frame = CGRect(x: loginXSpace, y: aPY, width: aPW, height: aPH)
        aPhoto.backgroundColor = UIColor.gray
        
        addSubview(aPhoto)
    }
}

// MARK: - 用户名和密码 View
extension LoginView {
    
    /// 用户名和密码 View
    private func setUIViewWithLoginView() -> UIView {
        
        /// 背景View
        let centerView = UIView()
        let aCY: CGFloat = aPhoto.frame.maxY + 16
        let aCW: CGFloat = kScreenWidth - 2 * loginXSpace
        let aCH: CGFloat = 148

        centerView.frame = CGRect(x: loginXSpace, y: aCY, width: aCW, height: aCH)
        
        // 账号登录 Label
        let aLFY: CGFloat = 0
        let aLFW: CGFloat = 100
        let aLFH: CGFloat = 26
        let aLframe = CGRect(x: 0, y: aLFY, width: aLFW, height: aLFH)
        let aLabel = UILabel(frame: aLframe)
        aLabel.text = "账号登录"
        aLabel.font = UIFont.systemFont(ofSize: 22)
        aLabel.textColor = UIColor(red: 48/255.0, green: 49/255.0, blue: 49/255.0, alpha: 1)
        aLabel.textAlignment = .left
        centerView.addSubview(aLabel)
        
        // UITexField 高度
        let tfHeight: CGFloat = frameLoginView.FNameAndPwd.frame
        // UITexField下边线的高度
        let tfLine: CGFloat = frameLoginView.Fline.frame
        
        // 简约号/邮箱/手机号
        aTFPhone.frame = CGRect(x: 0, y: aLabel.frame.maxY, width: centerView.width, height: tfHeight)
        aTFPhone.placeholder = "简约号/邮箱/手机号"
        aTFPhone.setValue(kWangjiColor, forKeyPath: "_placeholderLabel.textColor")
        aTFPhone.delegate = self
        aTFPhone.font = UIFont.systemFont(ofSize: 16)
        centerView.addSubview(aTFPhone)
        
        let phoneLine = UIView.init(frame: CGRect(x: 0, y: aTFPhone.bottomY, width: centerView.width, height: tfLine))
        phoneLine.backgroundColor = kWangjiColor
        centerView.addSubview(phoneLine)

        // 登录密码
        aTFPassword.frame = CGRect(x: 0, y: aTFPhone.bottomY , width: centerView.width, height: tfHeight)
        aTFPassword.delegate = self
        aTFPassword.setValue(kWangjiColor, forKeyPath: "_placeholderLabel.textColor")
        aTFPassword.placeholder = "输入登录密码"
        aTFPassword.font = UIFont.systemFont(ofSize: 16)
        centerView.addSubview(aTFPassword)
        
        let passwordLine = UIView.init(frame: CGRect(x: 0, y: aTFPassword.bottomY, width: centerView.width, height: tfLine))
        passwordLine.backgroundColor = kWangjiColor
        centerView.addSubview(passwordLine)
        
        
        return centerView
    }
}

// MARK: - 登录View
extension LoginView {
    private func setupUIViewWithLoginBtn(frame: CGRect) -> UIView{
        let bgView = UIView(frame: frame)
        
        let loginBtn = UIButton.init(type: .custom)
        loginBtn.backgroundColor = kNavColor
        
        let aLBW: CGFloat = kScreenWidth - 2 * loginXSpace
        let aLBH: CGFloat = frameLoginView.FLoginBtn.frame
            
        loginBtn.frame = CGRect(x: 0, y: 0, width:aLBW, height: aLBH)
        loginBtn.layer.cornerRadius = 16
        loginBtn.setTitle("登 录", for: .normal)
        loginBtn.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        loginBtn.clipsToBounds = true
        loginBtn.backgroundColor = UIColor(red: 209/255.0, green: 209/255.0, blue: 209/255.0, alpha: 1)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        bgView.addSubview(loginBtn)

        let zhuceBtn = UIButton.init(type: .custom)
        zhuceBtn.frame = CGRect(x: 0, y: loginBtn.bottomY + 13, width: 80, height: 16)
        zhuceBtn.setTitle("注册账号", for: .normal)
        zhuceBtn.setTitleColor(kWangjiColor, for: .normal)
        bgView.addSubview(zhuceBtn)

        let wangjiBtn = UIButton.init(type: .custom)
        wangjiBtn.frame = CGRect(x: bgView.width - 90, y: loginBtn.bottomY + 15, width: 90, height: 16)
        wangjiBtn.setTitle("忘记密码?", for: .normal)
        wangjiBtn.setTitleColor(kWangjiColor, for: .normal)
        bgView.addSubview(wangjiBtn)
        
        return bgView
    }
}

// MARK: - 快速登录View
extension LoginView {
    private func setupUIViewWithFastLogin(frame: CGRect) {
        let bgView = UIView(frame: frame)
        addSubview(bgView)
        
        // 左边的线
        let leftWidth: CGFloat = kScreenWidth - 2 * 10
        let leftLine = UILabel(frame: CGRect(x: 10, y: 7, width: leftWidth, height: 0.5))
        leftLine.backgroundColor = kWangjiColor
        bgView.addSubview(leftLine)
        
        // 中间文字
        let aLWidth: CGFloat = 100
        let aLX: CGFloat = (bgView.width - aLWidth) * 0.5
        let aLabel = UILabel(frame: CGRect(x: aLX, y: 0, width: aLWidth, height: 15))
        aLabel.text = "快速登录"
        aLabel.backgroundColor = UIColor.white
        aLabel.font = UIFont.systemFont(ofSize: 12)
        aLabel.textColor = kWangjiColor
        aLabel.textAlignment = .center
        bgView.addSubview(aLabel)
        
        // 微信图标
        let awxW: CGFloat = 60
        let awxX: CGFloat = kScreenWidth * 0.5 - awxW - 15
        let awxY: CGFloat = (bgView.height - awxW - aLabel.height) * 0.5

        let weixinImage = UIImageView(frame: CGRect(x: awxX, y: awxY, width: awxW, height: awxW))
        weixinImage.backgroundColor = UIColor.green
        bgView.addSubview(weixinImage)

        // QQ图标

        let qqImage = UIImageView(frame: CGRect(x: kScreenWidth * 0.5 + 15, y: awxY, width: awxW, height: awxW))
        qqImage.backgroundColor = UIColor.blue
        bgView.addSubview(qqImage)
    }
}

// MARK: - 登录按钮的点击事件
extension LoginView {
    @objc private func loginClick() {
        
        if (aTFPassword.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty) || (aTFPhone.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty) {
            print("用户名和密码不能为空")
            return
        }
        
        delegate?.loginButtonClick(LoginView: self, userName: aTFPhone.text ?? "", password: aTFPassword.text ?? "")
    }
}

// MARK: - UITextFieldDelegate
extension LoginView: UITextFieldDelegate {
    // MARK:- 5 点击手势
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//        loginFallingAnimate()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        loginRisingAnimate()
        return true
    }
    // MARK:- 3 uitextfield编辑完成后逻辑处理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        loginFallingAnimate()
        return true
    }
}