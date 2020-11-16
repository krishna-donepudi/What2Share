class App < ApplicationRecord
  # relations
  has_many :user_apps, dependent: :destroy
  has_many :users, through: :user_apps

  # callbacks
  before_save :format_name

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  #scopes
  scope :alphabetical, -> { order('name') }
<<<<<<< HEAD
  before_save { self.name = name.downcase }
  # private
  def format_name
    name = self.name.chomp
=======
  private
  def format_name
    name = self.name.downcase.chomp
>>>>>>> 89df238e29c4d79ae07eadac0a2a901b02ca48b0
    self.name = name
  end
  
end
