{{/*
Create the name of the service account to use
*/}}
{{- define "clusternet-agent.serviceAccountName" -}}
{{- default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- end }}
