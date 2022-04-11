# frozen_string_literal: true

require_relative 'frame'

class Game
  STRIKE = 'X'

  def initialize(marks)
    @marks = marks.split(',')
  end

  def score
    point = 0
    frames = create_frames
    frames.each_with_index do |frame, idx|
      point += if idx < 9
                 frame.score + bonus(frames, frame, idx)
               else
                 frame.score
               end
    end
    point
  end

  private

  def create_frames
    frames = []
    9.times do
      frame = @marks.first == STRIKE ? [@marks.shift] : @marks.shift(2)
      frames << frame
    end
    frames << @marks

    frames.map do |frame|
      Frame.new(frame[0], frame[1], frame[2])
    end
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
