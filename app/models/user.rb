class User < ApplicationRecord

  before_create :set_admin, :create_slug
  validates :email, uniqueness: true
  #validates :full_name, presence: true
 # validates :slug, uniqueness: true

  enum role: [:admin, :author, :editor]
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :author
  end

  def create_slug
    if full_name
      full_name_split = self.full_name.split(" ");
      self.slug = full_name_split[0].to_s + "-" + full_name_split[1]&.first.to_s;
    end
  end

  def set_admin
    self.role = :admin if User.count == 0
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
