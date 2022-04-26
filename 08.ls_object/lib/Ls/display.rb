# frozen_string_literal: true

require_relative 'filelist'

module Ls
  class Display
    def initialize(options)
      @file_list = Ls::FileList.new(options)
    end

    def show_list_short
      devided_list = @file_list.devide_the_file_list
      max_filename_length = @file_list.calc_max_file_name_length
      # 表示の間隔は常に8の倍数
      adjustment_width = (max_filename_length / 8 + 1) * 8

      devided_list.transpose.each do |files|
        line = files.map do |file|
          case file
          when Ls::File
            file.name.ljust(adjustment_width)
          else
            file.to_s.ljust(adjustment_width)
          end
        end.join
        puts line
      end
    end
  end
end
