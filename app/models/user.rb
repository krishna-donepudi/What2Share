class User < ApplicationRecord

  has_secure_password

  # relations
  has_one :partner, :class_name => 'User', :foreign_key => 'partner_id'
  belongs_to :partner, :class_name => 'User', optional: true
  has_many :user_apps
  has_many :apps, through: :user_apps

  accepts_nested_attributes_for :apps
  accepts_nested_attributes_for :user_apps

  # validations
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  scope :alphabetical, -> { order('username') }
  scope :singles, -> { where('partner_id IS NULL') }

  ROLES_LIST = ['admin', 'non-admin'].freeze

  def self.authenticate(username, password)
    find_by_username(username).try(:authenticate, password)
  end

  def done?
    if (self.apps.count > 0)
      will_to_share_incomplete = self.user_apps.map{ |a| a.will_to_share }.include?(nil)
      currently_sharing_incomplete = self.user_apps.map { |a| a.currently_sharing }.include?(nil)
      if will_to_share_incomplete || currently_sharing_incomplete
        return false
      else
        return true
      end
    else
      return false
    end
  end

  def possible_partners
    User.all.select { |a| a.partner_id  == self.id }
  end

  # callbacks
  # before_save :add_partner_if_not_added

  private
  def add_partner_if_not_added
    if !self.partner_id.nil?
      partner = User.where(:user_id => self.partner_id)
      if !partner.nil?
        if partner.partner_id.nil?
          partner.update_attribute(:partner_id, self.user_id)
        else
          errors.add(:partner_id, "has already chosed a partner")
        end
      else
        errors.add(:partner_id, "does not exist in our system as a user")
      end
    end
  end



end
