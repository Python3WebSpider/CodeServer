# code-server on Kubernetes

code-server is VS Code running on a remote server, accessible through the browser. https://github.com/cdr/code-server

Authentication default password is `P@ssw0rd`.
You can overwrite password by environment variables.(`PASSWORD`)

## How to use `code-server` image

```
helm install code-server-<username> . --namespace <namespace> --set user=<username>
```
