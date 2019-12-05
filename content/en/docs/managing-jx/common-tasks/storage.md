---
title: Storage
linktitle: Storage
description: Let's save your pipeline files somewhere cloud native!
weight: 180
aliases:
  - /architecture/storage/
---

When we use a Static Jenkins Server with Jenkins X we inherit the usual Jenkins storage model; that build logs and test results and reports are stored on the Persistent Volume of the Jenkins server.

However as we move towards a more [Cloud Native Jenkins](/blog/2018/11/26/changes-november-26-2018/) and use [Serverless Jenkins](/news/serverless-jenkins/) we need a better solution for the storage of things like logs, test results, code coverage reports etc.

## Storage Extensions

So we've added a storage extension point which is used from:

* storing logs when using [Serverless Jenkins](/news/serverless-jenkins/) which is done by the [jx controller build](/commands/jx_controller_build/) command
* using the [jx step stash](/commands/jx_step_stash/) command which stashes files from a build (test or coverage reports)


## Configuring Storage

You can setup the default location to use for storage. We currently support:

* storing files (logs, test or coverage reports) in a branch of a git repository. e.g. they could be part of your `gh-pages` branch for your static site.
* storing files in Cloud Storage buckets like S3, GCS, Azure blobs etc

Storage uses classifications which are used to define the folder in which the kind of resources live such as

* logs
* tests
* coverage

You can also use the special classification `default` which is used if you don't have a configuration for the classification in question. e.g. you could define a location of `default` and then just configure where `logs` go if thats different.

If you are using [jx boot](/docs/getting-started/setup/boot/) to install and configure your setup then modify your `jx-requirements.yml` file to configure storage as described in the [boot storage documentation](/docs/getting-started/setup/boot/#storage)


Otherwise to configure the storage location for a classification and team you use the [jx edit storage](/commands/jx_edit_storage/)

e.g.

```sh
# Configure the tests to be stored in cloud storage (using S3 / GCS / Azure Blobs etc)
jx edit storage -c tests --bucket-url s3://myExistingBucketName

# Configure the git URL and branch of where to store logs
jx edit storage -c logs --git-url https://github.com/myorg/mylogs.git --git-branch cheese
```

You can view your teams storage settings via [jx get storage](/commands/jx_get_storage/)


## Using Stash

Inside a pipeline you can then run the [jx step stash](/commands/jx_step_stash/) command to stash files:

```sh
# lets collect some files with the file names relative to the 'target/test-reports' folder and store in a Git URL
jx step stash -c tests -p "target/test-reports/*" --basedir target/test-reports

# lets collect some files to a specific AWS cloud storage bucket
jx step stash -c coverage -p "build/coverage/*" --bucket-url s3://my-aws-bucket
```

* specify the `classifier` via `-c` such as for `tests` or `coverage` etc.
* specify the files to collect via `-p` which supports wildcards like `*`. files which will be stored with the relative directory path
* if you want to remove a direectory prefix from the stashed files, like `target/reports` you can use `--basedir` to specify the directory to create relative file names from

By default [jx step stash](/commands/jx_step_stash/) will use your team's configured location for the classification you give. If you wish you can override the location for a stash using `--git-url` or `--bucket-url`

### Unstashing

If you need to you can unstash previously stored files via [jx step unstash](/commands/jx_step_unstash/)

If you are in some Go source code and you have a URL from Jenkins X, such as a Build Log URL or Attachment from a [PipelineActivity Custom Resource](/docs/reference/components/custom-resources/) the URL could be in various forms such as:

  * `gs://anotherBucket/mydir/something.txt` : using a GCS bucket on GCP
  * `s3://nameOfBucket/mydir/something.txt` : using S3 bucket on AWS
  * `azblob://thatBucket/mydir/something.txt` : using an Azure bucket
  * `http://foo/bar` : file stored in git not using HTTPS
  * `https://foo/bar` : file stored in a git repo using HTTPS


If you want to easily be able to read from the URL from Go source code you can use the [`ReadURL` function](https://github.com/jenkins-x/jx/blob/e5a7943dc0c3d79c27f30aea73235f18b3f5dcff/pkg/cloud/buckets/buckets.go#L44-L45).
