class User < ApplicationRecord
  has_many :stories, dependent: :destroy
  before_create :set_admin, :create_slug
  validates :email, uniqueness: true
  enum role: %i[admin author editor]
  mount_uploader :image, ImageUploader

  def create_slug
    self.slug = full_name.split(' ')[0].to_s + '-' + full_name.split(' ')[1]&.first.to_s
  end

  def set_admin
    self.role = :admin if User.count == 0
  end

  scope :pending, -> { where.not(invitation_token: true) }
  scope :accepted, -> { where.not(sign_in_count: 0) }

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
