{{/*
Expand the name of the database.
*/}}
{{- define "supachart.auth.name" -}}
{{- default (print .Chart.Name "-auth") .Values.auth.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified database name.
*/}}
{{- define "supachart.auth.fullname" -}}
{{- if .Values.auth.fullnameOverride }}
  {{- .Values.auth.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
  {{- printf "%s-%s" (include "supachart.fullname" .) (.Values.auth.nameOverride | default "auth") | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "supachart.auth.serviceAccountName" -}}
{{- if .Values.auth.serviceAccount.enabled }}
{{- default (include "supachart.auth.fullname" .) .Values.auth.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.auth.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "supachart.auth.selectorLabels" -}}
app.kubernetes.io/name: {{ include "supachart.auth.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}