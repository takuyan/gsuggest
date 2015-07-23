# coding: utf-8
require 'nokogiri'
require 'open-uri'
require 'kconv'

class MainController < ApplicationController
  def index
  end

  def search
    @q = params[:q]
    @suggestions = []

    single_query = "#{@q}"
    single_url = "http://google.co.jp/complete/search?output=toolbar&q=#{URI.encode(single_query)}"
    single_doc = Nokogiri::XML(open(single_url).read)
    single_doc.xpath("//suggestion").each do |e|
      @suggestions << e.attributes['data'].to_s.toutf8 #.to_s.encode("UTF-8", "UTF-8", invalid: :replace, undef: :replace, replace: '.')
    end

    words = %w"あ い う え お か き く け こ さ し す せ そ た ち つ て と な に ぬ ね の は ひ ふ へ ほ ま み む め も や ゆ よ わ を ん"
    words.each do |w|
      query = "#{@q} #{w}"
      url = "http://google.co.jp/complete/search?output=toolbar&q=#{URI.encode(query)}"
      @doc = Nokogiri::XML(open(url).read)
      @doc.xpath("//suggestion").each do |e|
        @suggestions << e.attributes['data'].to_s.toutf8 #.to_s.encode("UTF-8", "UTF-8", invalid: :replace, undef: :replace, replace: '.')
      end
    end
  end
end
