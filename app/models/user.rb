class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts  # ERD relationship (one user has many posts)
  has_many :comments, through: :post
    # Post has foreign keys of comments, so User can access comments through post
    # Enables the JOIN operation. eg. current_user.comments.count

  has_many :tags, through: :posts

end
