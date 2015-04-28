class Url < ActiveRecord::Base
  validates_presence_of :original

  def self.unique_rand_id letters
    loop do
      @rd_id=(1..8).map {letters[rand letters.length]}.join
      break if self.where('random_id = ?', @rd_id).empty?
    end
    @rd_id
  end
end
