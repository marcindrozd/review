class Token < ActiveRecord::Base
  belongs_to :tokenable, polymorphic: true

  scope :from_value, ->(value){ where(value: value) }

  before_create :generate_token!

  private
  def generate_token!
    begin
      self.value = SecureRandom.hex
    end while self.class.from_value(self.value).exists?
  end
end
