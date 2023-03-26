//
//  PeopleView.swift
//  TakeHomeProjectSwiftUI
//
//  Created by Kevin on 11.03.23.
//

import SwiftUI

struct PeopleView: View {
  
  private let colums = Array(repeating: GridItem(.flexible()),
                             count: 2)
  
  @StateObject private var viewModel: PeopleViewModel
  @State private var shouldShowCreate = false
  @State private var shouldShowSuccess = false
  @State private var hasAppeared = false
  
  init() {
    
#if DEBUG
    
    if UITestingHelper.isUITesting {
      
      let mock: NetworkingManagerImplementation = UITestingHelper.isPeopleNetworkingSuccessful ? NetworkManagerUserResponseSuccessMock() : NetworkManagerUserResponseFailureMock()
      
      _viewModel = StateObject(wrappedValue: PeopleViewModel(networkingManager: mock))
      
    } else {
      _viewModel = StateObject(wrappedValue: PeopleViewModel())
    }
    
#else
    
    _viewModel = StateObject(wrappedValue: PeopleViewModel())
    
#endif
    
  }
  
  var body: some View {
    
    ZStack {
      
      background
      
      if viewModel.isLoading {
        ProgressView()
      } else {
        ScrollView {
          LazyVGrid(columns: colums,
                    spacing: 16) {
            ForEach(viewModel.users, id: \.id) { user in
              
              NavigationLink {
                DetailView(userId: user.id)
              } label: {
                PersonItemView(user: user)
                  .accessibilityIdentifier("item_\(user.id)")
                  .task {
                    if viewModel.hasReachedTheEnd(of: user) && !viewModel.isFetching {
                      await viewModel.fetchNextPageOfUsers()
                    }
                  }
              }
              
            }
          }
                    .padding()
                    .accessibilityIdentifier("peopleGrid")
        }
        .refreshable {
          await viewModel.fetchUsers()
        }
        .overlay(alignment: .bottom) {
          if viewModel.isFetching {
            ProgressView()
          }
        }
      }
      
    }
    .navigationTitle("People")
    .toolbar {
      
      ToolbarItem(placement: .primaryAction) {
        create
      }
      
      ToolbarItem(placement: .navigationBarLeading) {
        refresh
      }
      
    }
    .task {
      if !hasAppeared {
        await viewModel.fetchUsers()
        hasAppeared = true
      }
    }
    .sheet(isPresented: $shouldShowCreate) {
      CreateView {
        haptic(.success)
        withAnimation(.spring().delay(0.25)) {
          self.shouldShowSuccess.toggle()
        }
      }
    }
    .alert(isPresented: $viewModel.hasError,
           error: viewModel.error) {
      Button("Retry") {
        Task {
          await viewModel.fetchUsers()
        }
      }
    }
    .overlay(alignment: .center) {
      if shouldShowSuccess {
        CheckmarkPopoverView()
          .transition(.scale.combined(with: .opacity))
          .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
              withAnimation(.spring()) {
                self.shouldShowSuccess.toggle()
              }
            }
          }
      }
    }
    .embedInNavigation()
    
    
  }
}

struct PeopleView_Previews: PreviewProvider {
  static var previews: some View {
    PeopleView()
  }
}


private extension PeopleView {
  
  var background: some View {
    Theme.background
      .edgesIgnoringSafeArea(.top)
  }
  
  var create: some View {
    Button {
      shouldShowCreate.toggle()
    } label: {
      Symbols.plus
        .font(
          .system(.headline, design: .rounded)
          .bold()
        )
    }
    .disabled(viewModel.isLoading)
    .accessibilityIdentifier("createBtn")
  }
  
  var refresh: some View {
    Button {
      Task {
        await viewModel.fetchUsers()
      }
    } label: {
      Symbols.refresh
    }
    .disabled(viewModel.isLoading)
  }
}
