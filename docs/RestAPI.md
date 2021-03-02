## Functional Specification

| Category  | Name  | Function  |
|-----------|-------|-----------|
|Sign in SSHELL | Sign in| Login with id and password|
|            | Sign up | Sign up with id and password |
|Connect To PC | Load session | Load saved session|
|           | Save session |   Save session information |
|           | Delete session | Delete selected session |
|           | Connect ssh   | Connect to remote PC |
| Use terminal | Terminal shell | Use CLI |
|              | Customize      | customize font, background color |
| Customize themes | Customize preview | Show preview based on present font, </br>background color |
|                  | Save customization | Save present font, background color |
<br/>

## REST API
```
{
    signin : 
    - id,
      password
    signup : [
        id,
        password
    ],  
    session :{
        load : [
            sessionID           
        ],
        save : [
            IP
        ],
        delete : [
            sessionID
        ]
    },  
    open : [
        IP :           
    ],  
    customize : {
        preview : [
            font,
            fontColor,
            fontSize,
            backgroundColor
        ],
        save : [
            font,
            fontColor,
            fontSize,
            backgroundColor
        ]
    },  
}
```

| URI   | Input | Function |
|-------|-------|----------|
|signin|{ id: "",<br/> password: "" }| login|
|signup|{ id: "",<br/> password: "" }| signup|
|session/load | { sessionID: "" } | load session |
|session/save | { IP: "" } | save session |
|session/delete | { sessionID: "" } | delete session |
|open | { ip: "" } | connect |
|customize | | customize|
|customize/preview | { font: "", <br/>fontcolor: "", <br/>fontsize: "",<br/>backgroundColor: ""} | preview customization|
|customize/save | { font: "", <br/>fontcolor: "", <br/>fontsize: "",<br/>backgroundColor: ""} | save customization |

