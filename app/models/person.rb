class Person < ActiveRecord::Base
  has_many :authored_commits, class_name: 'Commit', inverse_of: :author, foreign_key: 'author_id'
  has_one :user
  before_create :assign_user

  private

  def assign_user
    self.user = User.find_by(email: email)
  end
end
