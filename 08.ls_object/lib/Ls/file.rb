# frozen_string_literal: true

require 'etc'

module Ls
  class File
    attr_reader :name, :nlink, :user_name, :group_name, :size, :blocks

    def initialize(name)
      @name = name
      fs = ::File::Stat.new(name)
      @ftype = fs.ftype
      @mode = fs.mode.to_s(8)
      @nlink = fs.nlink
      @user_name = Etc.getpwuid(fs.uid).name
      @group_name = Etc.getgrgid(fs.gid).name
      @size = fs.size
      @mtime = fs.mtime
      @blocks = fs.blocks
    end

    def name_length
      @name.size
    end

    def nlink_length
      nlink.to_s.size
    end

    def user_name_length
      user_name.size
    end

    def group_name_length
      group_name.size
    end

    def size_length
      size.to_s.size
    end

    def combine_ftype_and_mode
      [
        @ftype == 'file' ? '-' : @ftype[0],
        @mode[-3, 3].chars.map { |str| convert_to_symbol(str) }.join
      ].join
    end

    def convert_to_time_format
      # 最終更新時刻から半年経っているかどうかでフォーマットを決める
      format = @mtime.between?(Time.now - (60 * 60 * 24 * 180), Time.now) ? '%_m %e %R' : '%_m %e  %Y'
      @mtime.strftime(format)
    end

    private

    def convert_to_symbol(str)
      {
        '0' => '---',
        '1' => '--x',
        '2' => '-w-',
        '3' => '-wx',
        '4' => 'r--',
        '5' => 'r-x',
        '6' => 'rw-',
        '7' => 'rwx'
      }[str]
    end
  end
end
