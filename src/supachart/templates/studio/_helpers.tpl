{{/*
Expand the name of the database.
*/}}
{{- define "supachart.studio.name" -}}
{{- default (print .Chart.Name "-studio") .Values.studio.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified database name.
*/}}
{{- define "supachart.studio.fullname" -}}
{{- if .Values.studio.fullnameOverride }}
  {{- .Values.studio.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
  {{- printf "%s-%s" (include "supachart.fullname" .) (.Values.studio.nameOverride | default "studio") | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "supachart.studio.serviceAccountName" -}}
{{- if .Values.studio.serviceAccount.enabled }}
{{- default (include "supachart.studio.fullname" .) .Values.studio.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.studio.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "supachart.studio.selectorLabels" -}}
app.kubernetes.io/name: {{ include "supachart.studio.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}