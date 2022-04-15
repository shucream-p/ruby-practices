# frozen_string_literal: true

require_relative 'shot'

class Frame
  def initialize(*marks)
    @shots = marks.map { |mark| Shot.new(mark) }
  end

  def [](idx)
    case idx
    when 0
      @shots[0]
    when 1
      @shots[1]
    else
      raise ArgumentError, "Invalid index #{idx}"
    end
  end

  def score
    @shots.sum(&:point)
  end

  def first_two_points
    [@shots[0],@shots[1]].sum(&:point)
  end

  def strike?
    @shots[0].strike?
  end

  def spare?
    !strike? && score == 10
  end
end
