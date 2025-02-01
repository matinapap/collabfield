FactoryBot.define do 
    factory :post do
      title { 'a' * 20 }   # Δημιουργεί έναν τίτλο με 20 χαρακτήρες 'a'
      content { 'a' * 20 } # Δημιουργεί περιεχόμενο με 20 χαρακτήρες 'a'
      user                 # Αυτόματα συνδέει το post με έναν user (χρησιμοποιεί την user factory)
      category             # Αυτόματα συνδέει το post με μία category (χρησιμοποιεί την category factory)
    end
  end
  