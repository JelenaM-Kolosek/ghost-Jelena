class User < ApplicationRecord
  has_attached_file :image, default_url: ':style/avatar.png', styles: { medium: '300x300>', thumb: '100x100>' }
  validates_attachment_content_type :image, content_type: ['image/jpg', 'image/jpeg', 'image/png']
  
  before_create :set_admin, :create_slug
  validates :email, uniqueness: true
  has_many :stories, dependent: :destroy
  enum role: %i[admin author editor]

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
