class Card < ApplicationRecord
  belongs_to :user
  before_create :set_review_date_as_now

  validates_presence_of :original_text, :translated_text, :review_date

  scope :pending, -> { where('review_date <= ?', Time.now).order('RANDOM()') }
  scope :repeating, -> { where('quality < ?', 4).order('RANDOM()') }

  def check_translation(user_translation)
    distance = Levenshtein.distance(full_downcase(original_text),
                                    full_downcase(user_translation))
    sm_hash = SuperMemo.algorithm(interval, repeat, efactor, attempt, distance)
    state = if distance <= SuperMemo::DISTANCE_LIMIT
              sm_hash[:review_date] = Time.now + interval.days
              sm_hash[:attempt] = 1
              true
            else
              sm_hash[:attempt] = [attempt + 1, 5].min
              false
            end
    update_attributes(sm_hash)
    { state: state, distance: distance }
  end

  protected

  def set_review_date_as_now
    self.review_date = Time.now
  end

  def full_downcase(str)
    str.mb_chars.downcase.to_s.squeeze(' ').strip
  end
end
