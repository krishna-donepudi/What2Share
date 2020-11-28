class UserApp < ApplicationRecord
  belongs_to :user
  belongs_to :app

  WILL_TO_SHARE_OPTIONS = [['Unwilling to share', 'unwilling'],['Neutral', 'neutral'],['Willing to share', 'willing'],['Not sure', 'notsure']].freeze
end