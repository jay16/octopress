---
layout: post
title: Ruby Mail - bodyhtml & bodytext
date: 2013-08-28 03:26:59
comments: true
categories: Ruby,Email
---
    [webmail@cloud sh]$ cat /home/webmail/jay/rb/mail_attach.rb 
    #encoding: utf-8
    require 'mail'
    require 'base64'
    
    def mail_attcher(toinfo,from_email)
      to_email = toinfo[0]
      peo_name = toinfo[1]
    
      bodyhtml = %Q{ <p>Hello #{peo_name} 您好：</p>
            <h4>This is HTML Part!</h4>
      }
    
      bodytext = %Q{Hello #{peo_name} 您好：
             This is HTML Part!
            }
    
     # to_email = "jay_li@intfocus.com"
    
      mail = Mail.new do
        to      to_email
        from    from_email
        message_id '<' + Time.now().to_f.to_s + '@' + Time.now().to_f.to_s.split(".")[1] + '.com>'
        subject "Mail Attach Test"
    
        add_file :filename => 'Test.pdf', :content => File.read('/home/webmail/jay/rb/Test.pdf')
      end
    
        html_part = Mail::Part.new do
          content_type 'text/html; charset=UTF-8'
          content_id '<' + Time.now().to_f.to_s + '@' + Time.now().to_f.to_s.split(".")[1] + '.com>'
          body bodyhtml
        end
    
        text_part =  Mail::Part.new do
          body bodytext
        end
      mail.text_part = text_part
      mail.html_part = html_part
    
      round_tripped_mail = Mail.new(mail.encoded)
    
      filename = Time.now().to_f.to_s
      sendmail = "./#{to_email.split('@')[0]}_#{filename}.eml"
      file = File.open(sendmail,"w")
      hfrom = to_email.to_s.split("@")[0] + "@online-edm.com"
      strfile = Time.now().to_i.to_s + " 00\r\n" + "F" + hfrom + "\r\n" + "R" + to_email + "\r\n" + "E\r\n"
      strfile << round_tripped_mail.to_s
      file.print(strfile.gsub!(/\r\n/, "\n"))
      file.close
    end
    
    from = "solife_li@126.com"
    to   = ['jay_li@intfocus.com','Jay']
    mail_attcher(to,from)
