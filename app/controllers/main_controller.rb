# coding: utf-8
require 'nokogiri'
require 'open-uri'

class MainController < ApplicationController

  caches_action :index, :search, expires_in: 1.month

  def index
  end

  def search
    words = %w"あ い う え お か き く け こ さ し す せ そ た ち つ て と な に ぬ ね の は ひ ふ へ ほ ま み む め も や ゆ よ わ を ん"
    @q = params[:q]
    @suggestions = []
    words.each do |w|
      query = "#{@q} #{w}"
      url = "http://google.co.jp/complete/search?output=toolbar&q=#{URI.encode(query)}"
      @doc = Nokogiri::XML(open(url).read)
      @doc.xpath("//suggestion").each do |e|
        @suggestions << e.attributes['data']
      end
    end
  end
end
