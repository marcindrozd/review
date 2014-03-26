class Token < ActiveRecord::Base
  belongs_to :tokenable, polymorphic: true

  scope :from_value, ->(value){ where(value: value) }

  before_create :generate_token!

  validates :value, uniqueness: true

  private
  def generate_token!
    begin
      self.value = SecureRandom.hex
    end while self.class.from_value(self.value).exists?
  end

  def self.get_tokenable(token)
    item = first_tokenable(token)
    item ? item.tokenable : nil
  end

  def self.first_tokenable(token)
    from_value(token).first
  end
end
