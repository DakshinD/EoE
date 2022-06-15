//
//  UserAllergenAlertControl.swift
//  EoE
//
//  Created by Dakshin Devanand on 6/10/22.
//

import SwiftUI
import CoreData

struct UserAllergenAlertControl: UIViewControllerRepresentable {
    
    var moc: NSManagedObjectContext
    
    @Binding var textString: String
    @Binding var showAlert: Bool

    var title: String
    var message: String

    @Binding var currentOptions: [String]

    // Make sure that, this fuction returns UIViewController, instead of UIAlertController.
    // Because UIAlertController gets presented on UIViewController
    func makeUIViewController(context: UIViewControllerRepresentableContext<UserAllergenAlertControl>) -> UIViewController {
        return UIViewController() // Container on which UIAlertContoller presents
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<UserAllergenAlertControl>) {
        
        // Make sure that Alert instance exist after View's body get re-rendered
        guard context.coordinator.alert == nil else {
            //print("There is already an alert present")
            return
        }
        
        if self.showAlert {
            
            // Create UIAlertController instance that is gonna present on UIViewController
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            context.coordinator.alert = alert
            
            // Adds UITextField & make sure that coordinator is delegate to UITextField.
            alert.addTextField { textField in
                textField.placeholder = "Enter some text"
                textField.text = self.textString            // setting initial value
                textField.delegate = context.coordinator    // using coordinator as delegate
            }
            
            // As usual adding actions
            alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "") , style: .destructive) { _ in
                
                // On dismiss, SiwftUI view's two-way binding variable must be update (setting false) means, remove Alert's View from UI
                alert.dismiss(animated: true) {
                    self.textString = "" //needed?
                    self.showAlert = false
                }
            })
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("Submit", comment: ""), style: .default) { _ in
                // On submit action, get texts from TextField & set it on SwiftUI View's two-way binding varaible `textString` so that View receives enter response.
                if let textField = alert.textFields?.first, let text = textField.text {
                    self.textString = text
                }
                
                // make CoreData object for user allergen creation
                let allergen = Allergen(context: moc)
                allergen.id = UUID()
                allergen.name = textString
                allergen.type = AllergenTypes.userCreated.rawValue
                allergen.isSelected = false
                                
                do {
                    try moc.save()
                } catch {
                    print(error.localizedDescription)
                }
                //currentOptions.append(textString)
                                
                alert.dismiss(animated: true) {
                    self.textString = "" //needed?
                    self.showAlert = false
                }
            })
            
            // Most important, must be dispatched on Main thread,
            // Curious? then remove `DispatchQueue.main.async` & find out yourself, Dont be lazy
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.10) { // must be async !!
                uiViewController.present(alert, animated: true, completion: {
                    self.showAlert = false  // hide holder after alert dismiss
                    context.coordinator.alert = nil
                })
                
            }
        }
    }

    func makeCoordinator() -> UserAllergenAlertControl.Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        
        // Holds reference of UIAlertController, so that when `body` of view gets re-rendered so that Alert should not disappear
        var alert: UIAlertController?
        
        // Holds back reference to SwiftUI's View
        var control: UserAllergenAlertControl
        
        init(_ control: UserAllergenAlertControl) {
            self.control = control
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let text = textField.text as NSString? {
                self.control.textString = text.replacingCharacters(in: range, with: string)
            } else {
                self.control.textString = ""
            }
            return true
        }
    }
}

