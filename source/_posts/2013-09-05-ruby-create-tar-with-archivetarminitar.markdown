---
layout: post
title: ruby - create tar with archive-tar-minitar
date: 2013-09-05 09:33:36
comments: true
categories: [ruby]
---
## gem

    gem install archive-tar-minitar

## usage

Using this library is easy. The simplest case is:

    require 'zlib'
    require 'archive/tar/minitar'
    include Archive::Tar
    
      # Packs everything that matches Find.find('tests')
    File.open('test.tar', 'wb') { |tar| Minitar.pack('tests', tar) }
      # Unpacks 'test.tar' to 'x', creating 'x' if necessary.
    Minitar.unpack('test.tar', 'x')

A gzipped tar can be written with:

    tgz = Zlib::GzipWriter.new(File.open('test.tgz', 'wb'))
      # Warning: tgz will be closed!
    Minitar.pack('tests', tgz)
    
    tgz = Zlib::GzipReader.new(File.open('test.tgz', 'rb'))
      # Warning: tgz will be closed!
    Minitar.unpack(tgz, 'x')

As the case above shows, one need not write to a file. However, it will sometimes require that one dive a little deeper into the API, as in the case of StringIO objects. Note that I'm not providing a block with Minitar::Output, as Minitar::Output#close automatically closes both the Output object and the wrappd data stream object.

    begin
      sgz = Zlib::GzipWriter.new(StringIO.new(""))
      tar = Output.new(sgz)
      Find.find('tests') do |entry|
        Minitar.pack_file(entry, tar)
      end
    ensure
        # Closes both tar and sgz.
      tar.close
    end

## link

[archive tar minitar](http://rubydoc.info/gems/archive-tar-minitar/0.5.2/frames)
