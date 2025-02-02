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
    find('.dropdown-menu a', text: 'Log out').click  # Εδώ χρησιμοποιούμε το κείμενο 'Log out' για να βρούμε το στοιχείο

    # Ελέγχουμε αν η σελίδα έχει ανακατευθυνθεί στην αρχική ή σελίδα σύνδεσης
    expect(page).to have_current_path(root_path) # Αν ανακατευθύνεται στην αρχική σελίδα
    expect(page).to have_selector('nav #user-settings', visible: false) # Ελέγχουμε ότι ο χρήστης αποσυνδέθηκε

    # Αν υπάρχει mobile menu με το "Log out", κάνουμε κλικ και εκεί (αν χρειάζεται)
    if page.has_selector?('.mobile-menu a', text: 'Log out')
      find('.mobile-menu a', text: 'Log out').click
    end
  end
end
