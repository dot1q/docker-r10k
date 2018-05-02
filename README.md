# docker-r10k

This is a docker file that will run r10k.

## Usage

### Using a username and password

```
docker run -v /your/codedir:/etc/puppetlabs/code -e REPOSITORY="https://github.com/someone/control-repo.git" -e GITHUB_USER="someuser" -e GITHUB_PASSWORD="somepassword" grahamgilbert/r10k
```

### Using a SSH key

```
export PRIVATE_KEY="$(cat /path/to/your/key)"
docker run -v /your/codedir:/etc/puppetlabs/code -e REPOSITORY="git@github.com:someone/control-repo.git" -e PRIVATE_KEY="$PRIVATE_KEY" grahamgilbert/r10k
```

### Jenkins Pipeline Example

```
node {
    def app
    
    withCredentials([sshUserPrivateKey(credentialsId: 'deez-creds-uuid', keyFileVariable: 'keyfile')]) {
        stage('Run R10k') {
            withDockerServer([uri: "tcp://10.10.10.10:2375"]) {
                Image = docker.image('gbrewster/r10k')
                def file = readFile("${keyfile}")

                try {
                    c = Image.run("-v /puppet/etc/puppetlabs/code/:/etc/puppetlabs/code -e REPOSITORY=\"git@github.com:dot1q/puppet-iac.git\" -e PRIVATE_KEY=\"${file}\"")
                    sh "docker logs -f ${c.id}"
                    def out = sh script: "docker inspect ${c.id} --format='{{.State.ExitCode}}'", returnStdout: true
                    sh "exit ${out}"
                } finally {
                    c.stop()
                }
            }
        }
    }
}
```

This example allows you to run r10k on a repo with a password or private ssh key within a jenkins job in detached mode. If errors occur the job will fail. 
