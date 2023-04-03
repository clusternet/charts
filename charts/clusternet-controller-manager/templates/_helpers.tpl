{{/*
Create the name of the service account to use
*/}}
{{- define "clusternet-controller-manager.serviceAccountName" -}}
{{- default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- end }}
