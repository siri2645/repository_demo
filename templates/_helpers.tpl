{{- $releaseName := include "Jenkins-K8s-Deployment.fullname" . -}}

{{/*
Common Lables
*/}}
{{- define "jenkins-ingress.lables" -}}
app.kubernetes.io/component: controller
app.kubernetes.io/name: aws-load-balancer-controller
{{- end -}}

{{/*
Common Anotations
*/}}
{{- define "jenkins-annotation.annotations" -}}
alb.ingress.kubernetes.io/scheme: internal
alb.ingress.kubernetes.io/certificate-arn: 'arn:aws:acm:eu-central-1:803'
alb.ingress.kubernetes.io/listen-ports: '[{"HTTP":80}, {"HTTPS":443}]'
alb.ingress.kubernetes.io/ssl-redirect: '443'
{{- end -}}

{{- define "jenkins-LB.annotations" -}}
eks.amazonaws.com/role-arn: arn:aws:iam::803843141221:role/AmazonEKSLoad
{{- end -}}

{{- define "Jenkins-K8s-Deployment.fullname" -}}
{{- printf "%s" .Release.Name }}
{{- end }}

{{- define "jenkins-role.rules" -}}
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["create","delete","get","list","patch","update","watch"]
- apiGroups: [""]
  resources: ["pod/exec"]
  verbs: ["create","delete","get","list","patch","update","watch"]
- apiGroups: [""]
  resources: ["pods/log"]
  verbs: ["get","list","watch"]
- apiGroups: [""]
  resources: ["services"]
  verbs: ["get"]
{{- end -}} 