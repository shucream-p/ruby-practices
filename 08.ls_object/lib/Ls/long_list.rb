# frozen_string_literal: true

require_relative 'Display'

module Ls
  class LongList < Display
    def show
      puts "total #{calc_total_blocks}"
      puts build_file_stats_format_list
    end

    private

    def build_file_stats_format_list
      max_length_map = build_max_length_map

      @files.map do |file|
        [
          file.combine_ftype_and_mode,
          file.nlink.to_s.rjust(max_length_map[:nlink] + 1),
          file.user_name.ljust(max_length_map[:user_name] + 1),
          file.group_name.ljust(max_length_map[:group_name] + 1),
          file.size.to_s.rjust(max_length_map[:size]),
          file.convert_to_time_format,
          file.name
        ].join(' ')
      end
    end

    def build_max_length_map
      %i[nlink user_name group_name size].each_with_object({}) do |key, result|
        method_name = "#{key}_length"
        result[key] = @files.map { |file| file.send(method_name) }.max
      end
    end

    def calc_total_blocks
      @files.sum(&:blocks)
    end
  end
end
