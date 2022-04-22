# frozen_string_literal: true

require_relative 'shot'

class Frame
  def initialize(*marks)
    @shots = marks.map { |mark| Shot.new(mark) }
  end

  def [](idx)
    @shots[idx]
  end

  def score
    @shots.sum(&:point)
  end

  def first_two_points
    @shots.first(2).sum(&:point)
  end

  def strike?(idx)
    idx < 9 && @shots[0].strike?
  end

  def spare?(idx)
    idx < 9 && !strike?(idx) && score == 10
  end
end
