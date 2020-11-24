class User < ApplicationRecord
  has_attached_file :image, default_url: ":style/avatar.png", :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  #validates :slug, uniqueness: true

  def create_slug
    #index = self.full_name.index(' ')
   #self.full_name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/,'')[index+2..-1]
  
  end

  def update_slug
    update_attributes slug: assign_slug
  end
  private
  def assign_slug
    self.slug = create_slug
  end

  after_update :assign_slug

  enum role: [:admin, :author, :editor]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :author
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create do 
    if User.count == 1
      self.role = :admin
      self.admin = true
      self.save
    end
  end

end
