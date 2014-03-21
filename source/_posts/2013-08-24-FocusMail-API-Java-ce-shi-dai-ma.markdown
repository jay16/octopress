---
layout: post
title: FocusMail API - Java测试代码
date: 2013-08-24 16:42:37
comments: true
categories: 
---
## 代码功能

FocusMail开放API功能,对方使用java开发环境,只好提供java版本测试代码。

代码功能仅仅是http呼叫url,取得返回的json。

    import java.io.BufferedReader;
    import java.io.IOException;
    import java.io.InputStream;
    import java.io.InputStreamReader;
    import java.io.OutputStream;
    import java.io.OutputStreamWriter;
    import java.io.Reader;
    import java.io.Writer;
    import java.net.HttpURLConnection;
    import java.net.ProtocolException;
    import java.net.URL;
    import java.net.URLConnection;
    public class HelloWorld{
      public static String sendGetRequest(String endpoint, String requestParameters) 
      {
        String result = null;
        if (endpoint.startsWith("http://"))
        {
            // Send a GET request to the servlet
            try
            {    // Send data
                 String urlStr = endpoint;
                 if (requestParameters != null && requestParameters.length () > 0)
                 {
                    urlStr += "?" + requestParameters;
                 }
                 URL url = new URL(urlStr);
                 URLConnection conn = url.openConnection ();
    
                 // Get the response
                 BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                 StringBuffer sb = new StringBuffer();
                 String line;
                 while ((line = rd.readLine()) != null)
                 {
                    sb.append(line);
                 }
                 rd.close();
                 result = sb.toString();
            } catch (Exception e)
            {
                 e.printStackTrace();
            }
        }
        return result;
      }
      
      public static void main(String[] args) {  
        System.out.println("Hello World!"); 
        String endpoint = "http://************************************";
        String requestParameters = "****=****&*****=*****";
        System.out.println(sendGetRequest(endpoint,requestParameters));
      }
    }

## 参考

+ [java发送http请求例子](http://daniex.info/java-send-http-request-example.html)
