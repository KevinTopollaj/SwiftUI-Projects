//
//  CreateView.swift
//  TakeHomeProjectSwiftUI
//
//  Created by Kevin on 11.03.23.
//

import SwiftUI

struct CreateView: View {
  
  @Environment(\.dismiss) private var dismiss
  @FocusState private var focusedField: Field?
  
  @StateObject private var viewModel: CreateViewModel
  
  private let successfulAction: () -> Void
  
  internal init(successfulAction: @escaping () -> Void) {
    self.successfulAction = successfulAction
    
    #if DEBUG
    
    if UITestingHelper.isUITesting {
      
      let mock: NetworkingManagerImplementation = UITestingHelper.isCreateNetworkingSuccessful ? NetworkManagerCreateSuccessMock() : NetworkManagerCreateFailureMock()
      
      _viewModel = StateObject(wrappedValue: CreateViewModel(networkingManager: mock))
      
    } else {
      _viewModel = StateObject(wrappedValue: CreateViewModel())
    }
    
    #else
    
    _viewModel = StateObject(wrappedValue: CreateViewModel())
    
    #endif
  }
  
  var body: some View {
    
    Form {
      
      Section {
        firstname
        lastname
        job
      } footer: {
        if case .validation(let error) = viewModel.error,
           let errorDescription = error.errorDescription {
          Text(errorDescription)
            .foregroundStyle(.red)
        }
        
        
      }
      
      Section {
        submit
      }
    }
    .disabled(viewModel.state == .submitting)
    .navigationTitle("Create")
    .toolbar {
      
      ToolbarItem(placement: .primaryAction) {
        done
      }
    }
    .disabled(viewModel.state == .submitting)
    .onChange(of: viewModel.state) { formState in
      if formState == .successful {
        dismiss()
        successfulAction()
      }
    }
    .alert(isPresented: $viewModel.hasError,
           error: viewModel.error) { }
      .overlay(alignment: .center) {
        if viewModel.state == .submitting {
          ProgressView()
        }
      }
      .embedInNavigation()
    
    
  }
}

struct CreateView_Previews: PreviewProvider {
  static var previews: some View {
    CreateView{}
    
  }
}

// MARK: - Field -

extension CreateView {
  
  enum Field: Hashable {
    case firstName
    case lastName
    case job
  }
  
}

// MARK: - Computed properties view -

private extension CreateView {
  
  var done: some View {
    Button("Done") {
      dismiss()
    }
    .accessibilityIdentifier("doneBtn")
  }
  
  var firstname: some View {
    TextField("First Name", text: $viewModel.person.firstName)
      .focused($focusedField, equals: .firstName)
      .accessibilityIdentifier("firstNameTxtField")
  }
  
  var lastname: some View {
    TextField("Last Name", text: $viewModel.person.lastName)
      .focused($focusedField, equals: .lastName)
      .accessibilityIdentifier("lastNameTxtField")
  }
  
  var job: some View {
    TextField("Job", text: $viewModel.person.job)
      .focused($focusedField, equals: .job)
      .accessibilityIdentifier("jobTxtField")
  }
  
  var submit: some View {
    Button("Submit") {
      focusedField = nil
      
      Task {
        await viewModel.create()
      }
      
    }
    .accessibilityIdentifier("submitBtn")
  }
}
