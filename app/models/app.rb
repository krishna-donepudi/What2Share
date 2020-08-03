class App < ApplicationRecord
  # relations
  has_many :user_apps
  has_many :users, through: :user_apps

  # callbacks
  before_save :format_name

  #scopes
  scope :alphabetical, -> { order('name') }

  private
  def format_name
    name = self.name.downcase.chomp
    self.name = name
  end
  
end
