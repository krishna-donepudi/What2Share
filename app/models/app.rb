class App < ApplicationRecord
  # relations
  has_many :user_apps, dependent: :destroy
  has_many :users, through: :user_apps

  # callbacks
  before_save :format_name

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  #scopes
  scope :alphabetical, -> { order('name') }
  before_save { self.name = name.downcase }
  # private
  # def format_name
  #   name = self.name.chomp
  #   self.name = name
  # end
  
end
