{{/*
Expand the name of the database.
*/}}
{{- define "supachart.realtime.name" -}}
{{- default (print .Chart.Name "-realtime") .Values.realtime.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified database name.
*/}}
{{- define "supachart.realtime.fullname" -}}
{{- if .Values.realtime.fullnameOverride }}
  {{- .Values.realtime.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
  {{- printf "%s-%s" (include "supachart.fullname" .) (.Values.realtime.nameOverride | default "realtime") | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "supachart.realtime.serviceAccountName" -}}
{{- if .Values.realtime.serviceAccount.enabled }}
{{- default (include "supachart.realtime.fullname" .) .Values.realtime.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.realtime.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "supachart.realtime.selectorLabels" -}}
app.kubernetes.io/name: {{ include "supachart.realtime.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}