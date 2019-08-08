class InviteCode < ApplicationRecord
    validates_uniqueness_of :invite_code
end
