---
title: Worked Example
linktitle: Worked Example
description: Implement support for JUnit Test reports in Jenkins X
weight: 20
aliases:
    - /docs/contributing/addons/worked-example/
---

In this worked example we will implement the functionality of the classic [JUnit Plugin](https://wiki.jenkins.io/display/JENKINS/JUnit+Plugin) from Jenkins in Jenkins X as a series of extensions to Jenkins X.

> This guide is still a work in progress!

# Functional Requirements

* Collect JUnit XML files from build
* Associate with pipeline / pipeline step execution
* Notify user of URL to view test results
* Provide historical/trend view of tests
* Allow test results to affect build health

# Implementation

## Prerequisites

* A working installation of `jx`
* A working Jenkins X cluster
* A working local install of Java and Maven

## Collect JUnit XML files from build

### Create a sample project

We'll start by creating a sample Java project which will run some tests.

1. Run `jx create quickstart -f spring-boot-web`. You can accept the defaults when prompted.
1. Import the created sources into your favorite IDE.
1. Open `pom.xml` and add JUnit as a dependency:

    ```xml
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <scope>test</scope>
      <version>4.12</version>
    </dependency>
    ```

1. Create the file `src/test/java/jenkinsx/example/springboot/WelcomeControllerTest.java`.
1. Copy and paste this code into the `WelcomeControllerTest`

    ```java
    package jenkinsx.example.springboot;

    import org.junit.Assert;
    import org.junit.Test;

    import java.util.HashMap;
    import java.util.Map;

    public class WelcomeControllerTest {

        @Test
        public void testWelcome() {
            WelcomeController wc = new WelcomeController();
            Map<String, Object> res = new HashMap<String, Object>();
            wc.welcome(res);
            Assert.assertEquals(res.get("message"), "Hello World");
        }
    }

    ```

1. Validate your changes by running `mvn test`.
2. Commit your changes and make sure the app makes it to staging in Jenkins X.
3. Our test reports will be generated in Jenkins X build pods, so we want to use that for development. Jenkins X DevPods make that easy. Run `jx create devpod --sync` in your project.
4. Validate the DevPod is working by running `mvn test`.

### Generate a Human Readable Report

By default Maven Surefire doesn't generate HTML files, just XML reports. We want people to be able to look at the reports, as well as be able to submit the XML for analysis.

1. In the DevPod run `mvn install surefire-report:report`. Validate that `target/site/surefire-report.html` is generated.
1. Create a script `junit.sh` in the sample project with this code:

    ```bash
    #!/bin/bash

    # Generate the HTML report
    mvn surefire-report:report
    ```

### Store the reports

We need a place to store the reports. A simple Go program will suffice for now.

1. Run `jx create quickstart -f spring-boot-web`. You can accept the defaults when prompted.
2. Replace the `main.go` contents with this code:

    ```golang
    package main

    import (
      "fmt"
      "io/ioutil"
      "log"
      "net/http"
      "os"
      "path/filepath"
    )

    const maxUploadSize = 2 * 1024 * 1024 // 2 MB
    const uploadPath = "/reports"
    const downloadPort = 8080
    const uploadPort = 8081
    const bind = "0.0.0.0"

    func main() {
      go uploadServer()
      downloadServer()
    }

    func downloadServer() {
      server:= http.NewServeMux()
      server.Handle("/", http.FileServer(http.Dir(uploadPath)))
      log.Printf("Download server listening on %s:%d\n", bind, downloadPort)
      http.ListenAndServe(fmt.Sprintf("%s:%d", bind, downloadPort), server)
    }

    func uploadServer() {
      server:= http.NewServeMux()
      server.HandleFunc("/", uploadFileHandler())
      log.Printf("Upload server listening on %s:%d\n", bind, uploadPort)
      http.ListenAndServe(fmt.Sprintf("%s:%d", bind, uploadPort), server)
    }

    func uploadFileHandler() http.HandlerFunc {
      return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        // validate file size
        r.Body = http.MaxBytesReader(w, r.Body, maxUploadSize)
        if err := r.ParseMultipartForm(maxUploadSize); err != nil {
          log.Println(err)
          renderError(w, "FILE_TOO_BIG", http.StatusBadRequest)
          log.Println(err)
          return
        }

        // parse and validate file and post parameters
        file, _, err := r.FormFile("upload")
        if err != nil {
          renderError(w, "INVALID_FILE", http.StatusBadRequest)
          log.Println(err)
          return
        }
        defer file.Close()
        fileBytes, err := ioutil.ReadAll(file)
        if err != nil {
          renderError(w, "INVALID_FILE", http.StatusBadRequest)
          log.Println(err)
          return
        }
        filename, dir := filepath.Split(r.URL.Path)
        newPath := filepath.Join(dir, filename)

        err = os.MkdirAll(dir, os.FileMode(0755))
        if err != nil {
          renderError(w, "CANT_CREATE_DIR", http.StatusInternalServerError)
          log.Println(err)
          return
        }
        // write file
        newFile, err := os.Create(newPath)
        if err != nil {
          renderError(w, "CANT_WRITE_FILE", http.StatusInternalServerError)
          log.Println(err)
          return
        }
        defer newFile.Close() // idempotent, okay to call twice
        if _, err := newFile.Write(fileBytes); err != nil || newFile.Close() != nil {
          renderError(w, "CANT_WRITE_FILE", http.StatusInternalServerError)
          log.Println(err)
          return
        }
        w.Write([]byte("SUCCESS"))
      })
    }

    func renderError(w http.ResponseWriter, message string, statusCode int) {
      w.WriteHeader(http.StatusBadRequest)
      w.Write([]byte(message))
    }
    ```

    This code will create an HTTP server that listens on two ports. It listens on 8080 to serve files from the `/reports` directory, and listens on 8081 for file uploads (using the URL path as the path as the location under `/reports` to store the file). By listening on different ports for download and upload we can easily expose the downloads service outside the cluster, but restrict the uploads service to inside the cluster meaning we have no need to secure the transport.

    We'll add authentication to the upload endpoint at a later point.
1. We need to store the reports somewhere, and in Kubernetes this means using a volume. Add this snippet to the bottom of `charts/jenkins-x-reports/templates/deployment.yaml`:

    ```yaml
          volumes:
          - name: {{ .Values.service.reportVolumeName }}
            emptyDir: {}
    ```

    and add this snippet to the container (just below above `ports` will work well):

    ```yaml
            volumeMounts:
            - name: {{ .Values.service.reportVolumeName }}
              mountPath: {{ .Values.service.reportMountPath }}
    ```

    Now modify `charts/jenkins-x-reports/values.yaml` and modify the `service` and add (just after `internalPort` will work well):
    ```yaml
      reportVolumeName: reports-volume
      reportMountPath: /reports
    ```

    You'll notice that we've used `emptyDir{}` to store the reports - this is transient and reports will be lost when the pod dies. We'll replace this with a persistent volume later.
1. Modify the `Dockerfile` to expose port `8081` as well by adding the line `EXPOSE 8081` just after `EXPOSE 8080`.
2. Modify `charts/jenkins-x-reports/values.yaml` and add the values for the upload service just after the existing service:

    ```yaml
    serviceUpload:
      name: jenkins-x-reports-upload
      type: ClusterIP
      externalPort: 80
      internalPort: 8081
    ```

    Notice how we've given it a unique name, set the internal port correctly and removed the annotations that instruct Jenkins X to expose the service outside the cluster.

    We now need to create a template for these values. Add the file `charts/jenkins-x-reports/templates/service-upload.yaml`:

      ```
      apiVersion: v1
      kind: Service
      metadata:
      {{- if .Values.serviceUpload.name }}
        name: {{ .Values.serviceUpload.name }}
      {{- else }}
        name: {{ template "fullname" . }}
      {{- end }}
        labels:
          chart: "{{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}"
      {{- if .Values.serviceUpload.annotations }}
        annotations:
      {{ toYaml .Values.serviceUpload.annotations | indent 4 }}
      {{- end }}
      spec:
        type: {{ .Values.serviceUpload.type }}
        ports:
        - port: {{ .Values.serviceUpload.externalPort }}
          targetPort: {{ .Values.serviceUpload.internalPort }}
          protocol: TCP
          name: http
        selector:
          app: {{ template "fullname" . }}
      ```

    This file is simply a copy of `service.yaml` with the `service` variable changed to `serviceUpload`.


    We also need to add the upload port to the list of container ports. Just below `containerPort: {{ .Values.service.internalPort }}` add:

    ```yaml
              containerPort: {{ .Values.serviceUpload.internalPort }}
    ```
1. Run this as an app on your Jenkins X cluster by pushing your code changes to GitHub. The app will build and can be tested in the staging environment.
1. Validate you can upload and download files. In the DevPod for the sample app run `curl -F upload=@target/site/surefire-report.html http://jenkins-x-reports-upload.jx-staging/test/1` and then validate that the file is there by running `curl http://jenkins-x-reports.jx-staging/test/1`.
2. Promote the app to production using `jx promote -a jenkins-x-reports -e production -v 0.0.1` (assuming you are still on your first version of the app)
1. To POST all the JUnit artifacts to the reports server use this script

    ```bash
    #!/bin/bash

    UPLOADED=uploaded.yaml
    REPORT_HOST=`jx get urls -e production | grep -o http://jenkins-x-reports.jx-production.*`

    function upload() {
        upload_junit_artifacts
    }

    function upload_junit_artifacts() {
        # Generate the HTML report
        mvn surefire-report:report
        upload_file target/site/surefire-report.html
        for f in target/surefire-reports/*.xml; do
            upload_file ${f}
        done
    }

    function upload_file() {
        [ -f "$1" ] || break
        filename=$(basename $1)
        path=$ORG/$APP_NAME/$VERSION/$filename
        set -x
        curl -s -F upload=@$1 http://jenkins-x-reports-upload.jx-production/$path
        set +x
        echo "    ${filename}: ${REPORT_HOST}/${path}" >> $UPLOADED
    }
    ```

1. Make the script executable by running `chmod u+x junit.sh`
1. Tell Jenkins to execute the script by adding this snippet to the `Jenkinsfile` just above the `jx step post build` lines in both the `CI Build and push snapshot` and `Build Release` stages:
```bash
            sh "VERSION=`cat VERSION` ./junit.sh"
```

So far we've had to add a script to the sample and modify the `Jenkinsfile` to run the script. Later in this tutorial we'll implement this functionality as a cross-cutting concern and be able to remove this from the sample project. But for now let's focus on the functionality we need.

### Create an index of reports

In order to provide the user with access to reports we need to create a central list. A Kubernetes `ConfigMap` is a simple way to store this information. A config map does have some limitations (they aren't ideal for large amounts of rapidly changing data) so we'll come back at a later stage and provide a better solution, but for now it allows us to focus on the user functionality.

We'll use one `ConfigMap` per app, and we'll use a standard naming pattern so that other tools can work out where the test report config map is for each app. We'll store the config maps in the `jx` namespace.

1. Update the `junit.sh` script with these three functions:

    ```bash

    CM_NAME=$ORG-$APP_NAME-test-reports

    function create_cm_if_needed() {
        if ! kubectl get cm $CM_NAME &> /dev/null; then
            echo "Creating ConfigMap $CM_NAME"
            kubectl create cm $CM_NAME
        fi
    }

    function init_patch() {
        rm -f $UPLOADED
        echo "data:" >> $UPLOADED
        echo "  $VERSION: |-" >> $UPLOADED
    }

    function update_cm() {
        set -x
        kubectl -v1 patch cm $CM_NAME --patch "$(cat $UPLOADED)"
        set +x
    }
    ```

2. And update the `upload()` function to call these functions:

    ```bash
    function upload() {
        create_cm_if_needed
        init_patch
        upload_junit_artifacts
        update_cm
    }
    ```

### Visualize the test results

We'll use Kibana and ElasticSearch to create dashboards to visualize the test results.

1. Install ElasticSearch by running `helm install --name jenkins-x-reports-elasticsearch incubator/elasticsearch`
2. Install Kibana by running `helm install stable/kibana --name=jenkins-x-reports-kibana --set service.annotations."fabric8\.io/expose"=true --set files."kibana\.yml"."elasticsearch\.url"=http://jenkins-x-reports-elasticsearch-client:9200 --set  && jx upgrade ingress`.

    The ingress upgrade will ask you a number of questions, and you can just accept the defaults. You can now access Kibana by running `jx get urls` and copying the URL for `jenkins-x-reports-kibana` into your browser.

3. Create a mapping for the JUnit XML format in Kibana by pasting this code into the Kibana console:

    ```json
    PUT tests
    {
        "mappings": {
          "junit": {
            "properties": {
            "errors": { "type": "integer" },
            "failures": { "type": "integer" },
            "name": { "type": "keyword" },
            "noNamespaceSchemaLocation": { "type": "text" },
            "skipped": { "type": "integer" },
            "tests": { "type": "integer" },
            "time": { "type": "double" },
            "xsi": { "type": "text" },
            "appName": { "type": "keyword" },
            "org": { "type": "keyword" },
            "version": { "type": "keyword" },
            "timestamp": { "type": "date" }
          }
          }
        }
    }
    ```

1. An initial client for sending data to Kibana is available at (https://github.com/pmuir/junit-runner). Download it and get it building.
As we start to convert the functionality we've built so far to a Jenkins X extension, we'll move the scripted code we've written so far into this Go program. For now, we can just use the current version.
1. Add this function to `junit.sh`:

    ```bash

    function dashboard() {
        curl https://github.com/pmuir/junit-runner/releases/download/v0.0.4/junit-runner > junit-runner
        chmod u+x junit-runner
        ./junit-runner
    }
    ```

    and call it from `upload()`. Push your changes to the sample repo and watch as Kibana starts to be populated with data.

### A better way to build functionality

If you have built plugins for something like Jenkins or Eclipse, you will be used to building the functionality you need to run "in process" - inside the main process that the application is running (e.g. the Jenkins master). More recently a different approach to writing plugins has become more popular where you build the functionality as a separate process that is managed by the main process; this is the model used by VS Code for example. We would recommend using this approach in Jenkins X, and because Jenkins X is based on Kubernetes, that means using a separate container or Pod to build your functionality, and calling out to using REST APIs.

In this case that means that it would be better to build the functionality we created in `junit-runner` into a separate pod, rather than run it inside the build pod. As it so happens we already have a pod - the one we built to store and serve the test artifacts.

Let's open that project up, and move the code which transforms the JUnit XML and sends it to elastic search into it.

1. Open the `main.go` file and add this function:

    ```go
    func toJson(json []byte) ([]byte, error) {
      m, err := mxj.NewMapJson(json)
      if err != nil {
        return nil, err
      }

      if err != nil {
        return nil, err
      }
      // Kibana is quite restrictive in the way it accepts JSON, so just rebuild the JSON entirely!

      utc, _ := time.LoadLocation("UTC")
      data := map[string]interface{} {
        "org": os.Getenv("ORG"),
        "appName": os.Getenv("APP_NAME"),
        "version": os.Getenv("VERSION"),
        "errors": m.ValueOrEmptyForPathString("testsuite.-errors"),
        "failures": m.ValueOrEmptyForPathString("testsuite.-failures"),
        "testsuiteName": m.ValueOrEmptyForPathString("testsuite.-name"),
        "skippedTests": m.ValueOrEmptyForPathString("testsuite.-skipped"),
        "tests": m.ValueOrEmptyForPathString("testsuite.-tests"),
        "time": m.ValueOrEmptyForPathString("testsuite.-time"),
        "timestamp": time.Now().In(utc).Format("2006-01-02T15:04:05Z"),
        // TODO Add the TestCases
      }
      fmt.Printf("%s", data)
      return json2.Marshal(data)
    }
    ```

    This function comes directly from the `junit-runner` code and is responsible for building a piece of JSON that is used by Kibana.
2. We also need to add this function from the `junit-runner` code which reads the XML file, converts it to JSON using `toJson()`, and then sends it onwards to our ElasticSearch instance:

    ```go
    func sendToElasticSearch(reader io.Reader, path string) error {
      _, json, err := x2j.XmlReaderToJson(reader)
      if err != nil {
        return err
      }
      json, err = toJson(json)
      fmt.Printf("Successfully annnotated JUnit result with build info\n")
      if err != nil {
        return err
      }
      req, err := http.NewRequest("POST", url, bytes.NewBuffer(json))

      req.Header.Set("Content-Type", "application/json")

      if err != nil {
        return err
      }

      client := &http.Client{}
      resp, err := client.Do(req)
      if err != nil {
        return err
      }
      defer resp.Body.Close()
      if (resp.StatusCode >= 200 && resp.StatusCode < 300 ) {
        fmt.Printf("Sent %s to %s\n", path, url)
      } else {
        body, _ := ioutil.ReadAll(resp.Body)
        return errors.New(fmt.Sprintf("HTTP status: %s; HTTP Body: %s\n", resp.Status, body))
      }
      return nil
    }
    ```

    Finally, we need to add a const to the go file which specifies the URL of the ElasticSearch instance. Add this to the top of `main.go` file:

    ```go
    const url = "http://jenkins-x-reports-elasticsearch-client:9200/tests/junit/"
    ```

3. Once you've resolved all the imports, you'll notice that we still have some errors. That's because we are missing a dependency on the `mxj` library which we are using to work with XML and JSON. Make sure you have these imports:

    ```go
      "github.com/clbanning/mxj"
      "github.com/clbanning/mxj/x2j"
      json2 "encoding/json"
    ```

    And then add this by running `dep init` which will detect our dependency and set it up properly.
4. We'll also need to call it for each JUnit XML file we receive. And only for JUnit files. We can use the HTTP headers for this:
Just above where we write the success message to the HTTP stream, add this code to call `sendToElasticSearch()`:

    ```go
        if r.Header.Get("X-Content-Type") == "text/vnd.junit-xml" {
          err = sendToElasticSearch(r.Body, r.URL.Path)
          if err != nil {
            renderError(w, "CANT_SEND_TO_ELASTICSEATCH", http.StatusInternalServerError)
            log.Println(err)
          }
        }
    ```

    Push your changes up to Git to have the updated server built on Jenkins X.
5. We now need to modify our script to send JUnit XML files with the mime type set to `text/vnd.junit-xml`. In the `junit.sh` file in the sample project modify the curl command in `upload_file()` to add the header. The whole line should look like:

    ```bash
        curl -H "X-Content-Type: text/vnd.junit-xml" -s -F upload=@$1 http://jenkins-x-reports-upload.jx-production/$path
    ```

    If you are wondering why we use `X-Content-Type` it is to avoid breaking the multipart form upload for the file!
6. And of course we need to remove `junit-runner`. Delete the `dashboard()` function and remove the call to it from `upload()`.
7. Now, let's clean things up a bit more by moving the code creating the configmap from the `junit.sh` script into the `jenkins-x-reports` code. First, we need to add a dependency on kubernetes-client to our code. Edit `Gopkg.toml` and add:

    ```toml
    [[constraint]]
      name = "k8s.io/api"
      version = "kubernetes-1.11.0"

    [[constraint]]
      name = "k8s.io/apimachinery"
      version = "kubernetes-1.11.0"
    [[constraint]]
      name = "k8s.io/client-go"
      version = "kubernetes-1.11.0"
    ```

8. Now we can add this function to create the Kubernetes client:

    ```go
    func createKubernetesClient() (*kubernetes.Clientset, error) {
      // creates the in-cluster config
      config, err := rest.InClusterConfig()
      if err != nil {
        return nil, err
      }
      // creates the clientset
      client, err := kubernetes.NewForConfig(config)
      if err != nil {
        return nil, err
      }
      return client, nil
    }
    ```

    And call it by adding these lines to the top of `main()`:

    ```go
      client, err := createKubernetesClient()
      if err != nil {
        panic(err)
      }
    ```

1. We now need to pass it to the `uploadServer()` function and change the signature of `uploadServer()` to `func uploadServer(client *kubernetes.Clientset)`, and then do the same to `uploadFileHandler()`, changing the signature to `func uploadServer(client *kubernetes.Clientset)`.
2. Now, we can write a function that gets or creates the configmap:

    ```go
    func getOrCreateConfigMap(org string, app string, client kubernetes.Interface) (*corev1.ConfigMap, error) {
      cmName := fmt.Sprintf("%s-%s-test-reports", org, app)
      cm, err := client.CoreV1().ConfigMaps(cmNamespace).Get(cmName, metav1.GetOptions{})
      if err != nil {
        return nil, err
      }
      if cm == nil {
        return client.CoreV1().ConfigMaps(cmNamespace).Create(&corev1.ConfigMap{
          ObjectMeta: metav1.ObjectMeta{
            Name: cmName,
          },
        })
        if err != nil {
          return nil, err
        }
      }
      return cm, nil
    }
    ```

3. In order to pass the org name and the app name to the config map creator, we can pass them using HTTP Headers. We can call the config map creation from the `uploadFileHandler()`, just before we write success by adding these lines to the top of the function:

    ```go
        // Get and validate headers
        org := r.Header.Get("X-Org")
        if org == "" {
          renderError(w, "MUST_PROVIDE_X-ORG_HEADER", http.StatusInternalServerError)
          log.Println("No X-ORG HEADER provided")
        }
        app := r.Header.Get("X-App")
        if app == "" {
          renderError(w, "MUST_PROVIDE_X-APP_HEADER", http.StatusInternalServerError)
          log.Println("No X-APP HEADER provided")
        }
    ```

    And this to the bottom, just above the success message:

    ```go
    getOrCreateConfigMap(org, app, client)
    ```

    And before we forget, update the `junit.sh` script to send these values. The curl command should now look like `curl -H "X-Content-Type: text/vnd.junit-xml" -H "X-ORG: ${ORG}" -H "X-APP: ${APP_NAME} -s -F upload=@$1`.
4. Now, let's implement the function `updateConfigMap()` to perform the actual patch. Use this function:

    ```go
    func updateConfigMap(cm *corev1.ConfigMap, version string, filename string, url string, client kubernetes.Interface) (*corev1.ConfigMap, error){
      fmt.Printf("Updating %s with data for %s and Data %s\n", cm.Name, version, cm.Data )
      if cm.Data[version] == "" {
        cm.Data[version] = fmt.Sprintf("|-\n")
      }
      cm.Data[version] = fmt.Sprintf("%s\n    %s: %s\n", cm.Data[version], filename, url)
      return client.CoreV1().ConfigMaps(cmNamespace).Update(cm)
    }
    ```

1. Now we need to figure out the host URL for the report downloads. Use this function:

    ```go
    func getReportHost(client kubernetes.Interface) (string, error) {
      svc, err := client.CoreV1().Services("jx-production").Get("jenkins-x-reports", metav1.GetOptions{})
      if err != nil {
        return "", err
      }
      return svc.Annotations["fabric8.io/exposeUrl"], nil
    }
    ```

2. We now need to wire it in. Add a version header to the top of the `uploadFileHandler()` function:

    ```go
    version := r.Header.Get("X-Version")
    if version == "" {
      renderError(w, "MUST_PROVIDE_X-VERSION_HEADER", http.StatusInternalServerError)
      log.Println("No X-VERSION HEADER provided")
    }
    ```

    And add just above the success message:

    ```go
    cm, err := getOrCreateConfigMap(org, app, client)
		if err != nil {
			renderError(w, "ERROR_CREATING_CONFIG_MAP", http.StatusInternalServerError)
			log.Println(err)
		}
		reportHost, err := getReportHost(client)
		if err != nil {
			renderError(w, "ERROR_CREATING_CONFIG_MAP", http.StatusInternalServerError)
			log.Println(err)
		}

		url := fmt.Sprintf("%s/%s/%s/%s/%s", reportHost, org, app, version, filename)
		cm, err = updateConfigMap(cm, version, filename, url, client )
		if err != nil {
			renderError(w, "ERROR_UPDATING_CONFIG_MAP", http.StatusInternalServerError)
			log.Println(err)
		}
    ```
1. We can also improve the way we are storing the files now, using the headers to create the path rather than just copying the path that was used for upload by changing the variable `dir` to look more like `dir := filepath.Join(uploadPath, org, app, version)`
2. Finally, let's tidy up `junit.sh` by removing the remnants of the patching code and adding the version header. Your final curl command should look like: `    curl -H "X-Content-Type: text/vnd.junit-xml" -H "X-Org: ${ORG}" -H "X-App: ${APP_NAME}" -H "X-Version: ${VERSION}" -s -F upload=@$1 http://jenkins-x-reports-upload.jx-production/$filename`

## Progress Review

We still have some steps to complete.

* Add token based authentication for the upload endpoint to prevent random pieces of code updating it (it's only accessible in the cluster anyway)
* Allow contribution to build health (requires additional JX support `jx step post` and `jx step pre`)

At this point the JX team have also learned that we want to build some additional extension points into Jenkins X:

* A `jx step post` support for a 'post build` steps. This will allow us to implement build health, as it will allow us to:
   * Inject additional steps into the build that allow us to run e.g. `mvn surefire-report:report` without modifying the build
* `jx step collect` for collecting build artifact that will run even if the build fails
  * Add URLs to the `PipelineActivity` CRD

TODO complete the guide
