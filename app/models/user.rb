class User < ApplicationRecord
  has_attached_file :image, default_url: ":style/avatar.png", :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  before_create :set_admin, :create_slug
  validates :email, uniqueness: true

  enum role: [:admin, :author, :editor]

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
