# frozen_string_literal: true

require 'etc'

module Ls
  class File
    attr_reader :name

    def initialize(name)
      @name = name
      fs = ::File::Stat.new(name)
      @ftype = fs.ftype
      @mode = fs.mode.to_s(8)
      @nlink = fs.nlink
      @user_name = Etc.getpwuid(fs.uid).name
      @group_name = Etc.getgrgid(fs.gid).name
      @size = fs.size
      @mtime = fs.size
    end

    def name_length
      @name.size
    end

    def combine_ftype_and_mode
      [
        @ftype == 'file' ? '-' : @ftype[0],
        @mode[-3, 3].chars.map { |str| convert_to_symbol(str) }.join
      ].join
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
