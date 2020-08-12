class UserApp < ApplicationRecord
  belongs_to :user
  belongs_to :app

  WILL_TO_SHARE_OPTIONS = [['Unwillng to share', 'unwilling'],['Likely to share', 'likely'],['Willing to share', 'willing']].freeze
end