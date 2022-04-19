# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(marks_text)
    @marks_text = marks_text
  end

  def score
    frames = create_frames
    frames.each_with_index.sum { |frame, idx| frame.score + calc_bonus(frames, frame, idx) }
  end

  private

  def create_frames
    marks = @marks_text.split(',')

    frames = Array.new(9) do
      frame = Shot.strike?(marks.first) ? [marks.shift] : marks.shift(2)
      Frame.new(*frame)
    end
    [*frames, Frame.new(*marks)]
  end

  def calc_bonus(frames, frame, idx)
    next_frame = frames[idx + 1]
    after_next_frame = frames[idx + 2]

    if frame.strike?(idx) && next_frame.strike?(idx)
      bonus_shot = idx < 8 ? after_next_frame[0] : next_frame[1]
      10 + bonus_shot.point
    elsif frame.strike?(idx)
      next_frame.first_two_points
    elsif frame.spare?(idx)
      next_frame[0].point
    else
      0
    end
  end
end

game = Game.new(ARGV[0])
p game.score
