//
//  LoginCoordinator+Onboarding.swift
//  Boost
//
//  Created by Ondrej Rafaj on 28/05/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import Base
import AwesomeEnum
import UserNotifications


extension LoginCoordinator {
    
    /// Welcome screen
    private func firstScreen(_ onboarding: OnboardingViewController) -> OnboardingView.Config {
        // TODO: Allow for enterprise logo!!!!!
        let img = UIImage(named: "Onboarding/welcome")
        return OnboardingView.Config(
            image: img,
            title: Lang.get("onboarding.welcome.title"),
            message: Lang.get("onboarding.welcome.message"),
            style: .light,
            action: (
                title: Lang.get("onboarding.welcome.next"),
                action: { _ in
                    onboarding.scrollView.goto(page: 1)
            })
        )
    }
    
    /// Push notifications haven't been previously set and new prompt is neccessary
    private func noPushScreen(_ onboarding: OnboardingViewController, _ skip: @escaping Button.ActionClosure) -> OnboardingView.Config {
        return OnboardingView.Config(
            image: UIImage(named: "Onboarding/push"),
            title: Lang.get("onboarding.push.title"),
            message: Lang.get("onboarding.push.message"),
            style: .light,
            action: (
                title: Lang.get("onboarding.push.enable"),
                action: { _ in
                    let center = UNUserNotificationCenter.current()
                    center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                        if let _ = error {
                            Alert.show(
                                title: Lang.get("onboarding.push.error.title"),
                                message: Lang.get("onboarding.push.error.message"),
                                on: onboarding
                            )
                            return
                        }
                        guard granted else {
                            Alert.show(
                                title: Lang.get("onboarding.push.not_granted.title"),
                                message: Lang.get("onboarding.push.not_granted.message"),
                                on: onboarding
                            )
                            return
                        }
                    }
                    UIApplication.shared.registerForRemoteNotifications()
            }),
            skip: (
                title: Lang.get("onboarding.push.skip"),
                action: skip
            )
        )
    }
    
    /// Push notifications have been previously enabled, no action needed
    private func existingPushScreen(_ onboarding: OnboardingViewController, _ skip: @escaping Button.ActionClosure) -> OnboardingView.Config {
        return OnboardingView.Config(
            image: UIImage(named: "Onboarding/ok"),
            title: Lang.get("onboarding.has_push.title"),
            message: Lang.get("onboarding.has_push.message"),
            style: .light,
            action: (
                title: Lang.get("onboarding.has_push.done"),
                action: skip
            )
        )
    }
    
    /// Push notifications have been previously disabled, they can only be enabled from settings
    private func deniedPushScreen(_ onboarding: OnboardingViewController, _ skip: @escaping Button.ActionClosure) -> OnboardingView.Config {
        return OnboardingView.Config(
            image: UIImage(named: "Onboarding/denied"),
            title: Lang.get("onboarding.denied_push.title"),
            message: Lang.get("onboarding.denied_push.message"),
            style: .light,
            action: (
                title: Lang.get("onboarding.denied_push.goto_settings"),
                action: { sender in
                    guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                        return
                    }
                    
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, options: [:], completionHandler: { completed in
                            skip(sender)
                        })
                    }
            }),
            skip: (
                title: Lang.get("onboarding.denied_push.done"),
                action: skip
            )
        )
    }
    
    func onboarding() -> OnboardingViewController {
        let onboarding = OnboardingViewController(style: .light)
        // TODO: Make gradient customisable!
        onboarding.backgroundView = BackgroundView(GradientView.Config.basic())
        return onboarding
    }
    
    func configure(onboarding: OnboardingViewController, skip: @escaping Button.ActionClosure) {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            var configurations = [
                self.firstScreen(onboarding)
            ]
            switch settings.authorizationStatus {
            case .notDetermined:
                configurations.append(self.noPushScreen(onboarding, skip))
            case .authorized:
                configurations.append(self.existingPushScreen(onboarding, skip))
            case .provisional:
                configurations.append(self.existingPushScreen(onboarding, skip))
            case .denied:
                configurations.append(self.deniedPushScreen(onboarding, skip))
            }
            onboarding.configurations = configurations
        }
        onboarding.skipAll = (title: Lang.get("onboarding.skip_all"), action: skip)
    }
    
}
