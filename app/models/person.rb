class Person < ActiveRecord::Base
  has_many :authored_commits, class_name: 'Commit', inverse_of: :author
end
