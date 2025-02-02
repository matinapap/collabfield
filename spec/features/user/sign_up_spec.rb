require "rails_helper"

RSpec.feature "Sign up", :type => :feature do
  let(:user) { build(:user) }

  scenario 'user navigates to sign up page and successfully signs up', js: true do
    visit root_path
    find('nav a', text: 'Signup').click

    # Συμπληρώνουμε τα πεδία με τις σωστές τιμές
    fill_in 'user[name]', with: user.name
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    fill_in 'user[password_confirmation]', with: user.password_confirmation
    
    # Υποβάλλουμε τη φόρμα, το οποίο μπορεί να συμβεί με το να κάνεις κλικ στο submit button
    find('input[type="submit"]').click  # Εδώ κάνουμε κλικ στο κουμπί υποβολής

    # Ελέγχουμε αν υπάρχει το στοιχείο #user-settings (που σημαίνει ότι ο χρήστης είναι συνδεδεμένος)
    expect(page).to have_selector('#user-settings')
  end
end
