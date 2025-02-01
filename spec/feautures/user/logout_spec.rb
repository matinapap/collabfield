require "rails_helper"

RSpec.feature "Logout", :type => :feature do
  let(:user) { create(:user) }

  scenario 'user successfully logs out', js: true do
    sign_in user
    visit root_path

    # Ανοίγουμε το dropdown μενού αν δεν είναι ήδη ανοιχτό
    find('nav #user-settings').click
    expect(page).to have_selector('.dropdown-menu', visible: true) # Περιμένουμε να ανοίξει το dropdown

    # Κάνουμε κλικ στο "Log out" στο dropdown
    find('.dropdown-menu', text: 'Log out').click

    # Αν υπάρχει mobile menu με το "Log out", κάνουμε κλικ και εκεί (αν χρειάζεται)
    if page.has_selector?('.mobile-menu a', text: 'Log out')
      find('.mobile-menu a', text: 'Log out').click
    end
    
  end
end
