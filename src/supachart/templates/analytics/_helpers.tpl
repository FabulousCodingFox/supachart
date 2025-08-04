{{/*
Expand the name of the database.
*/}}
{{- define "supachart.analytics.name" -}}
{{- default (print .Chart.Name "-analytics") .Values.analytics.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified database name.
*/}}
{{- define "supachart.analytics.fullname" -}}
{{- if .Values.analytics.fullnameOverride }}
  {{- .Values.analytics.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
  {{- printf "%s-%s" (include "supachart.fullname" .) (.Values.analytics.nameOverride | default "analytics") | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "supachart.analytics.serviceAccountName" -}}
{{- if .Values.analytics.serviceAccount.enabled }}
{{- default (include "supachart.analytics.fullname" .) .Values.analytics.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.analytics.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "supachart.analytics.selectorLabels" -}}
app.kubernetes.io/name: {{ include "supachart.analytics.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}