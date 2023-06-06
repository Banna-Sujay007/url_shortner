class Url < ApplicationRecord
  before_create :generate_short_url

  # ...

  private

  def generate_short_url
    self.short_url = SecureRandom.hex(4)
  end
end

