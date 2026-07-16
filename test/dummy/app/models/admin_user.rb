class AdminUser < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at current_sign_in_at email id sign_in_count updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end
end
