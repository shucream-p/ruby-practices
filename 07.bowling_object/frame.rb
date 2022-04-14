# frozen_string_literal: true

require_relative 'shot'

class Frame
  def initialize(first_mark, second_mark = nil, third_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def [](idx)
    case idx
    when 0
      @first_shot
    when 1
      @second_shot
    else
      raise ArgumentError, "Invalid index #{idx}"
    end
  end

  def score
    [@first_shot, @second_shot, @third_shot].sum(&:point)
  end

  def first_two_points
    [@first_shot, @second_shot].sum(&:point)
  end

  def strike?
    @first_shot.strike?
  end

  def spare?
    score == 10
  end
end
