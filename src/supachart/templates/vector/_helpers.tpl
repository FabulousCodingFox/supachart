{{/*
Expand the name of the database.
*/}}
{{- define "supachart.vector.name" -}}
{{- default (print .Chart.Name "-vector") .Values.vector.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified database name.
*/}}
{{- define "supachart.vector.fullname" -}}
{{- if .Values.vector.fullnameOverride }}
  {{- .Values.vector.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
  {{- printf "%s-%s" (include "supachart.fullname" .) (.Values.vector.nameOverride | default "vector") | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "supachart.vector.serviceAccountName" -}}
{{- if .Values.vector.serviceAccount.enabled }}
{{- default (include "supachart.vector.fullname" .) .Values.vector.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.vector.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "supachart.vector.selectorLabels" -}}
app.kubernetes.io/name: {{ include "supachart.vector.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}