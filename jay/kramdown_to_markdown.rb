
FENCED_CODEBLOCK_MATCH = /^(~{3,})\s*?(\w+)?\s*?\n(.*?)^\1~*\s*?\n/m

def kramdown_to_markdown(content)
  while content =~ FENCED_CODEBLOCK_MATCH
    lines = $&.split("\n") # $&:匹配项
    lines.delete_at(0)
    lines.delete_at(lines.size-1)

    newstr = lines.map { |l| "    " + l + "\n" }.join
    content.gsub!($&,newstr)
  end
  content
end

#file = "../markdowns/2014-01-23-Install-Rail-With-RVM-On-CentOS.markdown"
#puts kramdown_to_markdown(IO.readlines(file).join)

Dir.foreach("/home/tools/segments").each do |file|
  next unless file =~ /\.markdown$/ #非markdown文档路过

  puts file
  content   = IO.readlines(file).join
  converter = kramdown_to_markdown(content)
  File.open(file,"w") { |f| f.puts converter }
end
