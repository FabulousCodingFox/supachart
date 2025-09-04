{{/*
Expand the name of the database.
*/}}
{{- define "supachart.rest.name" -}}
{{- default (print .Chart.Name "-rest") .Values.rest.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified database name.
*/}}
{{- define "supachart.rest.fullname" -}}
{{- if .Values.rest.fullnameOverride }}
  {{- .Values.rest.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
  {{- printf "%s-%s" (include "supachart.fullname" .) (.Values.rest.nameOverride | default "rest") | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "supachart.rest.serviceAccountName" -}}
{{- if .Values.rest.serviceAccount.enabled }}
{{- default (include "supachart.rest.fullname" .) .Values.rest.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.rest.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "supachart.rest.selectorLabels" -}}
app.kubernetes.io/name: {{ include "supachart.rest.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}