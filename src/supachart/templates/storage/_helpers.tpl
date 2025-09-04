{{/*
Expand the name of the database.
*/}}
{{- define "supachart.storage.name" -}}
{{- default (print .Chart.Name "-storage") .Values.storage.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified database name.
*/}}
{{- define "supachart.storage.fullname" -}}
{{- if .Values.storage.fullnameOverride }}
  {{- .Values.storage.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
  {{- printf "%s-%s" (include "supachart.fullname" .) (.Values.storage.nameOverride | default "storage") | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "supachart.storage.serviceAccountName" -}}
{{- if .Values.storage.serviceAccount.enabled }}
{{- default (include "supachart.storage.fullname" .) .Values.storage.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.storage.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "supachart.storage.selectorLabels" -}}
app.kubernetes.io/name: {{ include "supachart.storage.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}