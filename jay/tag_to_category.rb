hash = { "error" => %w(error),
         "code" => %w(ruby android rails octopress markdown kramdown python java bash),
         "report" => %w(qlikview bi report cognos),
         "database" => %w(kettle mysql oracle  plsql database postsql),
         "linux" => %w(centos linux vim mac iterm),
         "web" => %w(html jquery nginx css bootstrap disqus uyan)
}

base_path = "../source/_posts"
Dir.foreach(base_path) do |file|
  next unless file =~ /markdown/
  lines = IO.readlines(File.join(base_path,file))
  content = lines[2] + lines[7..lines.size-1].join

  categories = []
  hash.each_pair do |key, value|
    categories += value.select { |i| content.downcase.include? i }
  end
  categories << "other" if categories.empty?
  lines[5] = "categories: [" + categories.join(",") +"]\n"
  puts file+"["+categories.join(",")+"]"
  File.open(File.join(base_path,file),"w") { |f| f.puts lines.join }
end
