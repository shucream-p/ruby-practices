# frozen_string_literal: true

require_relative 'file_list'

module Ls
  class Display
    COLUMN_NUMBER = 3

    def initialize(options)
      file_names = options['a'] ? Dir.glob('*', ::File::FNM_DOTMATCH) : Dir.glob('*')
      file_names = file_names.reverse if options['r']
      @file_list = file_names.map { |file_name| Ls::File.new(file_name) }
    end

    def show_list_short
      devided_list = devide_the_file_list
      max_filename_length = calc_max_file_name_length
      # 表示の間隔は常に8の倍数
      adjustment_width = (max_filename_length / 8 + 1) * 8

      devided_list.transpose.each do |files|
        line = files.map do |file|
          file_name = file.class == Ls::File ? file.name : file.to_s
            file_name.ljust(adjustment_width)
        end.join
        puts line
      end
    end

    private

    def devide_the_file_list
      num_to_slice = (@file_list.size.to_f / COLUMN_NUMBER).ceil
      devided_list = @file_list.each_slice(num_to_slice).to_a
      devided_list.last << nil while devided_list.last.size < num_to_slice
      devided_list
    end

    def calc_max_file_name_length
      @file_list.max_by(&:name_length).name_length
    end
  end
end
