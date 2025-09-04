{{/*
Expand the name of the database.
*/}}
{{- define "supachart.imgproxy.name" -}}
{{- default (print .Chart.Name "-imgproxy") .Values.imgproxy.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified database name.
*/}}
{{- define "supachart.imgproxy.fullname" -}}
{{- if .Values.imgproxy.fullnameOverride }}
  {{- .Values.imgproxy.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
  {{- printf "%s-%s" (include "supachart.fullname" .) (.Values.imgproxy.nameOverride | default "imgproxy") | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "supachart.imgproxy.serviceAccountName" -}}
{{- if .Values.imgproxy.serviceAccount.enabled }}
{{- default (include "supachart.imgproxy.fullname" .) .Values.imgproxy.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.imgproxy.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "supachart.imgproxy.selectorLabels" -}}
app.kubernetes.io/name: {{ include "supachart.imgproxy.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}