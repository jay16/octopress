hash = { "error" => %w(error),
         "code" => %w(ruby 2nd android rails octopress markdown kramdown),
         "report" => %w(qlikview bi report cognos),
         "database" => %w(mysql oracle  plsql database postsql),
         "linux" => %w(centos linux vim),
         "web" => %w(html jquery nginx)
}

base_path = "../source/_posts"
Dir.foreach(base_path) do |file|
  next unless file =~ /markdown/
  lines = IO.readlines(File.join(base_path,file))

  category = "other"
  hash.each_pair do |key, value|
    tags = value.select { |i| lines[5].downcase.include? i }
    category = key and break if tags.size > 0
  end
  lines[5] = "categories: " + category +"\n"
  File.open(File.join(base_path,file),"w") { |f| f.puts lines.join }
end
