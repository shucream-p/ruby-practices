# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(marks)
    @marks = marks.split(',')
  end

  def score
    frames = create_frames
    frames.each_with_index.sum do |frame, idx|
      if idx < 9
        frame.score + calc_bonus(frames, frame, idx)
      else
        frame.score
      end
    end
  end

  private

  def create_frames
    marks_copy = @marks.dup

    frames = Array.new(9) do
      frame = Shot.strike?(marks_copy.first) ? [marks_copy.shift] : marks_copy.shift(2)
      Frame.new(*frame)
    end
    [*frames, Frame.new(*marks_copy)]
  end

  def calc_bonus(frames, frame, idx)
    next_frame = frames[idx + 1]
    after_next_frame = frames[idx + 2]

    if frame.strike? && next_frame.strike?
      bonus_shot = idx < 8 ? after_next_frame[0] : next_frame[1]
      10 + bonus_shot.point
    elsif frame.strike?
      next_frame.first_two_points
    elsif frame.spare?
      next_frame[0].point
    else
      0
    end
  end
end

game = Game.new(ARGV[0])
p game.score
