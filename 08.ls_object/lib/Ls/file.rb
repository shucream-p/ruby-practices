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
  end
end
