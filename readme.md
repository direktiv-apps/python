
# python 1.0

Python environment

---
- #### Categories: build, development
- #### Image: direktiv.azurecr.io/functions/python 
- #### License: [Apache-2.0](https://www.apache.org/licenses/LICENSE-2.0)
- #### Issue Tracking: https://github.com/direktiv-apps/python/issues
- #### URL: https://github.com/direktiv-apps/python
- #### Maintainer: [direktiv.io](https://www.direktiv.io) 
---

## About python

This function provides a Python environment with Pyenv installed. Other versions can be installed with `pyenv install 3.x.y`. The following versions are installed:
- 3.10.5
- 3.9.13
- 3.8.13

You can change the python version by running the command `pyenv local 3.x.y` in the working directory. The image also contains pip, pipenv, and poetry.

### Example(s)
  #### Function Configuration
```yaml
functions:
- id: python
  image: direktiv.azurecr.io/functions/python:1.0
  type: knative-workflow
```
   #### Basic
```yaml
- id: python
  type: action
  action:
    function: python
    input: 
      commands:
      - command: python3 -c 'print("Hello World")'
```
   #### Environment Variables
```yaml
- id: python
  type: action
  action:
    function: python
    input:
      commands:
      - command: python3 -c 'import os;print(os.environ["hello"])'
        envs: 
        - name: hello
          value: world
```
   #### Switch version
```yaml
- id: python
  type: action
  action:
    function: python
    input:
      commands:
      - command: pyenv local 3.8.13
      - command: python3 -V
```

   ### Secrets


*No secrets required*







### Request



#### Request Attributes
[PostParamsBody](#post-params-body)

### Response
  List of executed commands.
#### Reponse Types
    
  

[PostOKBody](#post-o-k-body)
#### Example Reponses
    
```json
[
  {
    "result": "Python 3.8.13",
    "success": true
  }
]
```

### Errors
| Type | Description
|------|---------|
| io.direktiv.command.error | Command execution failed |
| io.direktiv.output.error | Template error for output generation of the service |
| io.direktiv.ri.error | Can not create information object from request |


### Types
#### <span id="post-o-k-body"></span> postOKBody

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| python | [][PostOKBodyPythonItems](#post-o-k-body-python-items)| `[]*PostOKBodyPythonItems` |  | |  |  |


#### <span id="post-o-k-body-python-items"></span> postOKBodyPythonItems

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| result | [interface{}](#interface)| `interface{}` | ✓ | |  |  |
| success | boolean| `bool` | ✓ | |  |  |


#### <span id="post-params-body"></span> postParamsBody

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| commands | [][PostParamsBodyCommandsItems](#post-params-body-commands-items)| `[]*PostParamsBodyCommandsItems` |  | | Array of commands. |  |
| files | [][DirektivFile](#direktiv-file)| `[]apps.DirektivFile` |  | | File to create before running commands. |  |


#### <span id="post-params-body-commands-items"></span> postParamsBodyCommandsItems

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| command | string| `string` |  | | Command to run | `python3 -c 'print(\"jens\")` |
| continue | boolean| `bool` |  | | Stops excecution if command fails, otherwise proceeds with next command |  |
| envs | [][PostParamsBodyCommandsItemsEnvsItems](#post-params-body-commands-items-envs-items)| `[]*PostParamsBodyCommandsItemsEnvsItems` |  | | Environment variables set for each command. | `[{"name":"MYVALUE","value":"hello"}]` |
| print | boolean| `bool` |  | `true`| If set to false the command will not print the full command with arguments to logs. |  |
| silent | boolean| `bool` |  | | If set to false the command will not print output to logs. |  |


#### <span id="post-params-body-commands-items-envs-items"></span> postParamsBodyCommandsItemsEnvsItems

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| name | string| `string` |  | | Name of the variable. |  |
| value | string| `string` |  | | Value of the variable. |  |

 
