{{/*
Expand the name of the database.
*/}}
{{- define "supachart.kong.name" -}}
{{- default (print .Chart.Name "-kong") .Values.kong.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified database name.
*/}}
{{- define "supachart.kong.fullname" -}}
{{- if .Values.kong.fullnameOverride }}
  {{- .Values.kong.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
  {{- printf "%s-%s" (include "supachart.fullname" .) (.Values.kong.nameOverride | default "kong") | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "supachart.kong.serviceAccountName" -}}
{{- if .Values.kong.serviceAccount.enabled }}
{{- default (include "supachart.kong.fullname" .) .Values.kong.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.kong.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "supachart.kong.selectorLabels" -}}
app.kubernetes.io/name: {{ include "supachart.kong.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}