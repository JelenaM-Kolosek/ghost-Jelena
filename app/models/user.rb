class User < ApplicationRecord
  before_create :set_admin, :create_slug
  validates :email, uniqueness: true
  enum role: %i[admin author editor]

  def create_slug
    self.slug = full_name.split(' ')[0].to_s + '-' + full_name.split(' ')[1]&.first.to_s
  end

  def set_admin
    self.role = :admin if User.count == 0
  end

  scope :pending, -> { where.not(invitation_token: true) }
  scope :accepted, -> { where(!User.where.not(invitation_token: true)) }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable,
         :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :trackable,
         invite_for: 7.days
end
