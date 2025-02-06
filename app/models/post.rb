class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category

  default_scope -> { includes(:user).order(created_at: :desc) }

  validates :title, presence: true, length: { minimum: 5, maximum: 255 }
  validates :content, presence: true, length: { minimum: 20, maximum: 1000 }
  validates :category_id, presence: true

   # Scope για φιλτράρισμα posts ανά κατηγορία και branch
   scope :by_category, -> (branch, category_name) do 
    joins(:category).where(categories: {name: category_name, branch: branch}) 
  end

  # Scope για φιλτράρισμα posts μόνο ανά branch
  scope :by_branch, -> (branch) do
    joins(:category).where(categories: {branch: branch}) 
  end

  # Scope για αναζήτηση τίτλου ή περιεχομένου
  scope :search, -> (search) do
    where("title ILIKE lower(?) OR content ILIKE lower(?)", "%#{search}%", "%#{search}%")
  end
end
