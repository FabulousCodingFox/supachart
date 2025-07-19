{{/*
Expand the name of the database.
*/}}
{{- define "supachart.db.name" -}}
{{- default (print .Chart.Name "-db") .Values.db.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified database name.
*/}}
{{- define "supachart.db.fullname" -}}
{{- if .Values.db.fullnameOverride }}
{{- .Values.db.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default (print .Chart.Name "-db") .Values.db.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "supachart.db.serviceAccountName" -}}
{{- if .Values.db.serviceAccount.enabled }}
{{- default (include "supachart.db.fullname" .) .Values.db.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.db.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "supachart.db.selectorLabels" -}}
app.kubernetes.io/name: {{ include "supachart.db.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}