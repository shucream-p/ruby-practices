# frozen_string_literal: true

require_relative 'file'

module Ls
  class Display
    COLUMN_NUMBER = 3

    def initialize(options)
      params = options['a'] ? ['*', ::File::FNM_DOTMATCH] : ['*']
      file_names = Dir.glob(*params)
      file_names = file_names.reverse if options['r']
      @files = file_names.map { |file_name| Ls::File.new(file_name) }
    end

    def show_list_short
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

    def show_list_long
      puts "total #{calc_total_blocks}"
      puts build_file_stats_format_list
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
      {
        nlink: @files.max_by(&:nlink_length).nlink_length,
        user_name: @files.max_by(&:user_name_length).user_name_length,
        group_name: @files.max_by(&:group_name_length).group_name_length,
        size: @files.max_by(&:size_length).size_length
      }
    end

    def calc_total_blocks
      @files.sum(&:blocks)
    end
  end
end
