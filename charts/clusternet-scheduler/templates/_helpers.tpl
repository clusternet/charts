{{/*
Create the name of the service account to use
*/}}
{{- define "clusternet-scheduler.serviceAccountName" -}}
{{- default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- end }}
