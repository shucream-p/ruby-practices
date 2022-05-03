# frozen_string_literal: true

require_relative 'Display'

module Ls
  class ShortList < Display
    COLUMN_NUMBER = 3

    def show
      devided_list = devide_the_file_list
      max_filename_length = calc_max_file_name_length
      # 表示の間隔は常に8の倍数
      adjustment_width = (max_filename_length / 8 + 1) * 8

      devided_list.transpose.each do |files|
        line = files.map do |file|
          file_name = file.nil? ? file.to_s : file.name
          file_name.ljust(adjustment_width)
        end.join
        puts line
      end
    end

    private

    def devide_the_file_list
      num_to_slice = (@files.size.to_f / COLUMN_NUMBER).ceil
      devided_list = @files.each_slice(num_to_slice).to_a
      # transposeするために、要素数が足りない場合にnilを追加する
      devided_list.last << nil while devided_list.last.size < num_to_slice
      devided_list
    end

    def calc_max_file_name_length
      @files.max_by(&:name_length).name_length
    end
  end
end
