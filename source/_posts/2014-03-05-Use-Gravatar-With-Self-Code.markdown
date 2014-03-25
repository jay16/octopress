---
layout: post
title: 使用自己的代码调用gravatar头像
date: 2014-03-05 17:06:06
comments: true
categories: [error,ruby,android,java]
---
在写android应用时，需要调用gravatar头像，在网上找了代码，在此备忘一下。

其实调用原理很简单，就是把邮箱进行md5加密，然后到gravatar网站读取图片。

## java版

    package us.solife.consumes.api;
    
    import java.io.*;
    import java.security.*;
    
    /**
     * Gravatar.gravatar_path(email)
     * Gravatar.gravatar_url(email)
     * GRAVATAR_BASE_URL = "http://gravatar.com/avatar/";
     */
    public class Gravatar {
      public static String hex(byte[] array) {
          StringBuffer sb = new StringBuffer();
          for (int i = 0; i < array.length; ++i) {
          sb.append(Integer.toHexString((array[i] & 0xFF) | 0x100).substring(1,3));       
          }
          return sb.toString();
      }
      public static String get_md5 (String email) {
          try {
          MessageDigest md = MessageDigest.getInstance("MD5");
          return hex (md.digest(email.getBytes("CP1252")));
          } catch (NoSuchAlgorithmException e) {
          } catch (UnsupportedEncodingException e) {
          }
          return "error";
      }
      
      public static String gravatar_url (String email) {  
          return URLs.GRAVATAR_BASE_URL+get_md5(email);
      }
      
      public static String gravatar_path(String email) {
    	  File path = new File(URLs.STORAGE_GRAVATAR);
    	  if(!path.exists())  path.mkdir();
    	  
    	  return URLs.STORAGE_GRAVATAR + "/" + get_md5(email) + ".jpg";
      }
    }

## ruby版

    require "digest"
    
    email = "jay_li@solife.us"
    gravatar_url = File.join("http://gravatar.com/avatar", Digest::MD5.hexdigest(email))
    puts gravatar_url
