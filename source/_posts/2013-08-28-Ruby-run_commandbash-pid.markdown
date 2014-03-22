---
layout: post
title: Ruby - run_command(bash) & pid
date: 2013-08-28 03:51:57
comments: true
categories: code
---
## run_command

使用ruby#popen查看进程是否正在运行

    #!/usr/local/bin/ruby -w
    @domains = %w(qq 163 sina other hotmail gmail yahoo tom sohu)
    
    def dispatch(runs)
      puts "#{runs.to_s} is running"
      unruns = @domains - runs
      unruns.each do |dd|
      puts "setup [#{dd}] to runn.."
        system("nohup /usr/local/bin/ruby /home/webmail/FocusAgent/SendMail/mail_sender.rb #{dd} > mynohup.out 2>&1 &")
        sleep(0.5)
      end
    end
    
    def run_command(cmd, exit_on_error=true)
      ret = []
      IO.popen(cmd) do |stdout|
        stdout.each do |line|
          #puts line
          ld = line.split[-1].chomp
          ret << ld if @domains.include?(ld)
        end
      end
    
      if exit_on_error && ($?.exitstatus != 0)
        $stderr.puts "command failed:\n#{cmd}"
        exit -1
      end
    
      ret
    end
    
    str = "ps -ef | grep mail_sender"
    runs = run_command(str)
    
    dispatch(runs)

## system <= pid

ruby程序中使用system操作后台运行程序,取得后台程序的pid,查看运行状态比较便捷。
 
    domain_pid = File.join(dir_path,"#{domain_file}.pid")
    system("nohup ruby #{run_backer} #{domain_path} & echo $! > #{domain_pid} &")
              
    pid = File.readlines(domain_pid)[0].to_i
    File.open(pid_file,"a+") { |file| file.puts [domain_file,pid] }

## 参考

[link](http://blog.csdn.net/liltos/article/details/4554202)
