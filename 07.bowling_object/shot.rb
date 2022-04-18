# frozen_string_literal: true

class Shot
  STRIKE = 'X'

  def self.strike?(mark)
    mark == STRIKE
  end

  def initialize(mark)
    @mark = mark
  end

  def strike?
    Shot.strike?(@mark)
  end

  def point
    @mark == STRIKE ? 10 : @mark.to_i
  end
end
