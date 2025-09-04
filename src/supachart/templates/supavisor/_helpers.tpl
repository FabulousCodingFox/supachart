{{/*
Expand the name of the database.
*/}}
{{- define "supachart.supavisor.name" -}}
{{- default (print .Chart.Name "-supavisor") .Values.supavisor.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified database name.
*/}}
{{- define "supachart.supavisor.fullname" -}}
{{- if .Values.supavisor.fullnameOverride }}
  {{- .Values.supavisor.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
  {{- printf "%s-%s" (include "supachart.fullname" .) (.Values.supavisor.nameOverride | default "supavisor") | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "supachart.supavisor.serviceAccountName" -}}
{{- if .Values.supavisor.serviceAccount.enabled }}
{{- default (include "supachart.supavisor.fullname" .) .Values.supavisor.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.supavisor.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "supachart.supavisor.selectorLabels" -}}
app.kubernetes.io/name: {{ include "supachart.supavisor.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}