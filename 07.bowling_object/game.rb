# frozen_string_literal: true

require_relative 'frame'

class Game
  STRIKE = 'X'

  def initialize(marks)
    @marks = marks.split(',')
  end

  def score
    frames = create_frames
    frames.each_with_index.map do |frame, idx|
      if idx < 9
        frame.score + bonus(frames, frame, idx)
      else
        frame.score
      end
    end.sum
  end

  private

  def create_frames
    frames = Array.new(9) do
      marks = @marks.first == STRIKE ? [@marks.shift] : @marks.shift(2)
      Frame.new(*marks)
    end
    frames << Frame.new(*@marks)
    frames
  end

  def bonus(frames, frame, idx)
    if frame.first_shot.mark == STRIKE && frames[idx + 1].first_shot.mark == STRIKE
      if idx < 8
        10 + frames[idx + 2].first_shot.parse_mark
      else
        10 + frames[idx + 1].second_shot.parse_mark
      end
    elsif frame.first_shot.mark == STRIKE
      frames[idx + 1].first_shot.parse_mark + frames[idx + 1].second_shot.parse_mark
    elsif frame.score == 10
      frames[idx + 1].first_shot.parse_mark
    else
      0
    end
  end
end

game = Game.new(ARGV[0])
p game.score
