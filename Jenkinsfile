def SERVICE_GROUP = "sample"
def SERVICE_NAME = "terraform"
def IMAGE_NAME = "${SERVICE_GROUP}-${SERVICE_NAME}"
def REPOSITORY_URL = "https://github.com/opsnow-tools/sample-terraform.git"
def REPOSITORY_SECRET = ""
def SLACK_TOKEN_DEV = "T95EAPLT1/B9CNR2Q9M/0c31312w1aEts55hKVBVFttG"
def SLACK_TOKEN_OPS = "T95EAPLT1/B9CNR2Q9M/0c31312w1aEts55hKVBVFttG"
def SLACK_TOKEN_SEC = "T95EAPLT1/B9CNR2Q9M/0c31312w1aEts55hKVBVFttG"

@Library("github.com/opsnow-tools/valve-butler")
def butler = new com.opsnow.valve.v7.Butler()
def label = "worker-${UUID.randomUUID().toString()}"

properties([
  buildDiscarder(logRotator(daysToKeepStr: "60", numToKeepStr: "30"))
])
podTemplate(label: label, containers: [
  containerTemplate(name: "builder", image: "opsnowtools/valve-builder:v0.2.17", command: "cat", ttyEnabled: true, alwaysPullImage: true)
], volumes: [
  hostPathVolume(mountPath: "/var/run/docker.sock", hostPath: "/var/run/docker.sock")
]) {
  node(label) {
    stage("Prepare") {
      container("builder") {
        butler.prepare(IMAGE_NAME)
      }
    }
    stage("Checkout") {
      container("builder") {
        try {
          if (REPOSITORY_SECRET) {
            git(url: REPOSITORY_URL, branch: BRANCH_NAME, credentialsId: REPOSITORY_SECRET)
          } else {
            git(url: REPOSITORY_URL, branch: BRANCH_NAME)
          }
        } catch (e) {
          butler.failure(SLACK_TOKEN_DEV, "Checkout")
          throw e
        }
      }
    }
    stage("Plan DEV") {
      container("builder") {
        try {
          butler.terraform_check_changes("dev", "dev")
          butler.success(SLACK_TOKEN_DEV, "Plan DEV")
        } catch (e) {
          butler.failure(SLACK_TOKEN_DEV, "Plan DEV")
          throw e
        }
      }
    }
    stage("Apply to DEV?") {
      container("builder") {
        butler.proceed([SLACK_TOKEN_OPS,SLACK_TOKEN_SEC], "Apply to DEV", "dev")
        timeout(time: 60, unit: "MINUTES") {
          input(message: "${butler.name} ${butler.version} to dev")
        }
      }
    }
    stage("Apply to DEV") {
      container("builder") {
        try {
          butler.terraform_apply("dev", "dev")
          butler.success([SLACK_TOKEN_DEV,SLACK_TOKEN_OPS,SLACK_TOKEN_SEC], "Apply to DEV")
        } catch (e) {
          butler.failure([SLACK_TOKEN_DEV,SLACK_TOKEN_OPS,SLACK_TOKEN_SEC], "Apply to DEV")
          throw e
        }
      }
    }
  }
}
