{{/*
Expand the name of the database.
*/}}
{{- define "supachart.functions.name" -}}
{{- default (print .Chart.Name "-functions") .Values.functions.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified database name.
*/}}
{{- define "supachart.functions.fullname" -}}
{{- if .Values.functions.fullnameOverride }}
  {{- .Values.functions.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
  {{- printf "%s-%s" (include "supachart.fullname" .) (.Values.functions.nameOverride | default "functions") | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "supachart.functions.serviceAccountName" -}}
{{- if .Values.functions.serviceAccount.enabled }}
{{- default (include "supachart.functions.fullname" .) .Values.functions.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.functions.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "supachart.functions.selectorLabels" -}}
app.kubernetes.io/name: {{ include "supachart.functions.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}