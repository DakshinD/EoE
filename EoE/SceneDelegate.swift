//
//  SceneDelegate.swift
//  EoE
//
//  Created by Dakshin Devanand on 9/27/20.
//

import UIKit
import SwiftUI
import CoreData

let names: [String] = ["Popcorn", "Sausage", "Pasta", "Pizza", "Fried Rice"]

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    @AppStorage("needsAppOnboarding") var needsAppOnboarding: Bool = true

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Get the managed object context from the shared persistent container.
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        // Create the SwiftUI view and set the context as the value for the managedObjectContext environment keyPath.
        // Add `@Environment(\.managedObjectContext)` in the views that will need the context.
        
        // Set up environment objects
        // NOTE: - Make sure this only runs once on the first run of the app
        
        
        let userData = UserData()
        //for testing purposes ---- 
        //userData.isNotFirstLaunch = false
        //needsAppOnboarding = true
        if !userData.isNotFirstLaunch { // it is the first launch
            print("first launch")
            needsAppOnboarding = true
            for aller in AllergenTypes.allCases {
                if aller != AllergenTypes.userCreated { //create all allergen options except the type that is used for user created ones
                    // Create a new allergen
                    let allergen = Allergen(context: context)
                    allergen.id = UUID()
                    allergen.name = aller.description
                    allergen.type = aller.rawValue
                    allergen.isSelected = false
                                    
                    do {
                        try context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            
            // setup medicine options
            
            // setup symptom options
            
            // set initial color scheme
            let currentSystemScheme = UITraitCollection.current.userInterfaceStyle
            let scheme: ColorScheme = schemeTransform(userInterfaceStyle: currentSystemScheme)
            userData.darkMode = (scheme == ColorScheme.dark)
            userData.isNotFirstLaunch = true
        }
        
        // Done setting up environment objects
        
        
        let contentView = ContentView()
                            .environment(\.managedObjectContext, context)
                            .environmentObject(userData)
                            .environmentObject(ScanningProcess())
                            .environmentObject(Statistics(moc: context, user: userData))

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }


    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
    
    // color scheme func
    func schemeTransform(userInterfaceStyle:UIUserInterfaceStyle) -> ColorScheme {
        if userInterfaceStyle == .light {
            return .light
        }else if userInterfaceStyle == .dark {
            return .dark
        }
        return .light
        
    }


}

