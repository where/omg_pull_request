## Omg! Pull Request!  Configuration

The daemon is configured based upon the configuration yaml file that is loaded.  The location, and more general information about the file can be found in the README.  This file is designed to give a detailed description of the different configuration options that are available.

### Github Configuration

`repo_owner` should be set to the github user, or organization where the repository is listed.  For example, if we wanted to run the daemon against this project, since the github url is: [https://github.com/where/omg_pull_request](https://github.com/where/omg_pull_request), the repo owner would be set to `where`.

`repo` should be set to the github repo name.  For example, if we wanted to run the daemon against this project, since the github url is: [https://github.com/where/omg_pull_request](https://github.com/where/omg_pull_request), the repo would be set to `omg_pull_request`.

`github_credentials` should be set to the login and password of the user who wishes to make comments on the pull request with the status of the tests.  This user will need to have read access to the repo.  This field accepts two sub-parameters of `login` and `password`.

Example:

```
repo_owner: kenmazaika
repo: pictures
github_credentials:
	login: username
	password: password
```

### Localization
`locale` sets which localization file should be used for the messages that get generated.  The list of valid locales is: `"en"`.  If you wish to add support for a different locale, fork this project, and add the i18n yml file to the locales directory and add the file to the i18n load path.

Example:

```
locale: en
```

### Storage

`storage` is the section of the config file that describes where the test output will be stored.  This accepts the subparameter of `provider`.  Since the full test output is more than we want to display on the comment for the test result, we want to link to a file where it can be accessed.  The provider can be set to use Amazon S3, or Github Gists.

#### Gist

Gist is the simplest type to configure.  The Gist provider will store the result in a Github Gist under the user whose `github_credentials` are stored for.  If set to Gist no other parameters are required.

Example:

```
storage:
	provider: Gist
```

#### Amazon S3

Amazon S3 requires information about the access token, secret, and bucket to be added to the yaml file.

Example:

```
storage:
	provider: Aws
	bucket: omg_bucket
	access_token: s3_access_token
	secret_token: s3_secret_token
```

### Test Runner Configuration

The test runner that is selected describes how to run the tests.  If you wish to add support for a non ruby or an altered ruby test runner, you'll want to fork the project and add a new runner.

The test is treated as passing if the execute_tests method of the runner returns a `true` value.

#### Rails

This has a basic setup, teardown, and execution path that should work for most modern rails applications that use bundler.  The implementation of which commands are run can be seen: lib/omg_pull_request/test_runner/rails.rb.

Example:

```
runner: Rails
```

#### Ruby

This has the basic execution path that should work for non rails ruby projects.  This will be valid for most gems, and ruby libraries.  The implementation is to simply run rake.  The full implementation can be seen: lib/omg_pull_request/test_runner/ruby.rb.

Example:

```
runner: Ruby
```

#### RailsTestFast

RailsTestFast uses the `parallel_tests` gem to allow running the tests in parallel for as many cores as the machine that is running the tests has.  If it's being run on a box with many cores, it can greatly improve the speed of the tests.

For this mode to work, your project must be ready to run with parallel_tests first.  This requires some modification to the database.yml file, and fixing any concurrency bugs that exist in your codebase.

There are a number of helper rake tasks that need to be included.  You can see details about how to set that up: in this gist.

Assuming that's up and running, you should be able to run faster rails tests.

Example:

```
runner: RailsTestFast
```

### Prowl Notifications

Prowl is a service that integrates with most modern smart phones to push alerts to.  This can allow a smart phone to be alerted when the tests pass or fail.

You will need to create a prowl api key and application at the [official prowl website](https://www.prowlapp.com).

Since the identify of a commiter can be found either by the user's github handle (in the case of comments) or based off the actual git commit history (obtained through the git shortlog), it requires you to add the same key for the same user's two keys.  In the case of me, my github handle is `kenmazaika` and my email address is `kenmazaika@gmail.com`, so I'd add both.

Example:

```
prowl:
  application: OMG_PULL_REQUEST
  keys:
    kenmazaika: OMG_OMG
    kenmazaika@gmail.com: OMG_OMG
    regular_dude@yahoo.com: REG_DUDE
```