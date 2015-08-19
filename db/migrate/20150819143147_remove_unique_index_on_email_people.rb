class RemoveUniqueIndexOnEmailPeople < ActiveRecord::Migration
  def up
    return unless index_exists? :people, :email, unique: true
    remove_index :people, :email
  end

  def down
    return if index_exists? :people, :email, unique: true
    add_index :people, :email, unique: true
  end
end
