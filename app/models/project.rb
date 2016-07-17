class Project < ActiveRecord::Base
  has_many :user_projects
  has_many :users

  validates :name, :body, presence: true
end
