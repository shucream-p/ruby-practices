# frozen_string_literal: true

require_relative 'file'

module Ls
  class FileList
    COLUMN_NUMBER = 3

    def initialize(options)
      filenames = options['a'] ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')
      @file_list = filenames.map { |filename| Ls::File.new(filename) }
    end

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
