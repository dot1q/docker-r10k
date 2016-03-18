# docker-r10k

This is a docker file that will run r10k.

## Usage

### Using a username and password

```
docker run -v /your/codedir:/etc/puppetlabs/code -e REPOSITORY="https://github.com/someone/control-repo.git" -e GITHUB_USER="someuser" -e GITHUB_PASSWORD="somepassword" grahamgilbert/r10k
```

### Using a SSH key

```
docker run -v /your/codedir:/etc/puppetlabs/code -e REPOSITORY="https://github.com/someone/control-repo.git" -e PRIVATE_KEY="YOURREALLYLONGKEY" grahamgilbert/r10k
```
