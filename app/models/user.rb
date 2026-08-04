class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  has_many :owned_workspaces,
         class_name: "Workspace",
         foreign_key: :owner_id,
         dependent: :destroy

  normalizes :email_address, with: ->(email) { email.strip.downcase }

  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end