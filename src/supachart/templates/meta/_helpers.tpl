{{/*
Expand the name of the database.
*/}}
{{- define "supachart.meta.name" -}}
{{- default (print .Chart.Name "-meta") .Values.meta.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified database name.
*/}}
{{- define "supachart.meta.fullname" -}}
{{- if .Values.meta.fullnameOverride }}
  {{- .Values.meta.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
  {{- printf "%s-%s" (include "supachart.fullname" .) (.Values.meta.nameOverride | default "meta") | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "supachart.meta.serviceAccountName" -}}
{{- if .Values.meta.serviceAccount.enabled }}
{{- default (include "supachart.meta.fullname" .) .Values.meta.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.meta.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "supachart.meta.selectorLabels" -}}
app.kubernetes.io/name: {{ include "supachart.meta.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}