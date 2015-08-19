class Person < ActiveRecord::Base
end

class AddUniqueIndexOnPeopleEmail < ActiveRecord::Migration

  def up
    emails = Person.pluck(:email)
    return if emails.uniq.count != emails.count
    add_index :people, :email, unique: true
  end

  def down
    return unless index_exists? :people, :email, unique: true
    remove_index :people, :email
  end
end
