require "rails_helper"

RSpec.feature "Logout", :type => :feature do
  let(:user) { create(:user) }

  scenario 'user successfully logs out', js: true do
    sign_in user
    visit root_path

    find('nav #user-settings').click
    expect(page).to have_selector('.dropdown-menu', visible: true) 

    find('.logout-form .btn-logout').click

    expect(page).to have_current_path(root_path) 

    if page.has_selector?('.mobile-menu a', text: 'Log out')
      find('.mobile-menu a', text: 'Log out').click
    end

    expect(page).to have_current_path(root_path)
  end
end
