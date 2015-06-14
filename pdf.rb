#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'pdf/reader'



#ページ毎に文字列を格納する
str = Array.new()
count = 0
page = 0
#ファイルの指定
File.open("/Users/user/Desktop/test.pdf", "rb") do |io|
  # インスタンス化
  reader = PDF::Reader.new(io)
	#ページの枚数だけ配列を用意
	str = Array.new(reader.page_count)
	page = reader.page_count
  # ページ単位で文字列を格納
  reader.pages.each do |page|
	str[count] = page.text
	count = count + 1
  end
end



text = Array.new(1000)
count = 0

#正規表現(Regular Explesion)を用いて空白を取り除き，必要な部分だけ取り除く
for i in 0..page do
	loop{
		if/([^\s]*)\b[0-9]*/ =~ str[i] then
  			text[count] = $&
			 str[i].slice!("#{$&}")
			 count= count + 1
		else
			break
		end
	}
end

#格納した文字列を出力してみる
for i in 0 .. 1000 do
	print i 
	print ":"
	puts text[i] 
end

