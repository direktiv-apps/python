
Feature: Basic

# The secrects can be used in the payload with the following syntax #(mysecretname)
Background:


Scenario: version

	Given url karate.properties['testURL']

	And path '/'
	And header Direktiv-ActionID = 'development'
	And header Direktiv-TempDir = '/tmp'
	And request
	"""
	{
		"commands": [
		{
			"command": "python3 --version",
			"silent": true,
			"print": false,
		}
		]
	}
	"""
	When method POST
	Then status 200
		And match $ ==
	"""
	{
	"python": [
	{
		"result": "Python 3.10.5",
		"success": true
	}
	]
	}
	"""
	
Scenario: switchversion

	Given url karate.properties['testURL']

	And path '/'
	And header Direktiv-ActionID = 'development'
	And header Direktiv-TempDir = '/tmp'
	And request
	"""
	{
		"commands": [
		{
			"command": "pyenv local 3.8.13",
			"silent": false,
			"print": true,
		},
		{
			"command": "python3 -V",
			"silent": false,
			"print": true,
		},
		{
			"command": "pyenv local 3.10.5",
			"silent": false,
			"print": true,
		},
		{
			"command": "python3 -V",
			"silent": false,
			"print": true,
		}
		]
	}
	"""
	When method POST
	Then status 200
	And match $ ==
	"""
	{
	"python": [
	{
		"result": "",
		"success": true
	},
	{
		"result": "Python 3.8.13",
		"success": true
	},
	{
		"result": "",
		"success": true
	},
	{
		"result": "Python 3.10.5",
		"success": true
	},
	]
	}
	"""

Scenario: environ

	Given url karate.properties['testURL']

	And path '/'
	And header Direktiv-ActionID = 'development'
	And header Direktiv-TempDir = '/tmp'
	And request
	"""
	{
		
		"commands": [
		{
			"command": "python3 -c 'import os;print(os.environ[\"ONE\"])'",
			"silent": false,
			"print": true,
			"envs": [
			{
				"name": "ONE",
				"value": "two"
			}
			]
		}
		]
	}
	"""
	When method POST
	Then status 200
	And match $ ==
	"""
	{
	"python": [
	{
		"result": "two",
		"success": true
	}
	]
	}
	"""
