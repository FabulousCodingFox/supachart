{{/*
Expand the name of the chart.
*/}}
{{- define "supachart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "supachart.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "supachart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "supachart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "supachart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "supachart.labels" -}}
helm.sh/chart: {{ include "supachart.chart" . }}
{{ include "supachart.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Secrets helper
*/}}
{{- define "supachart.env" -}}
- name: {{ .name }}
{{- if .path.secretKeyReference.name }}
  valueFrom:
    secretKeyRef:
      name: {{ .path.secretKeyReference.name }}
      key: {{ .path.secretKeyReference.key }}
{{- else }}
  value: {{ .path.value | quote }}
{{- end }}
{{- end }}

{{/*
Wait for db initcontainer
*/}}
{{- define "supachart.waitForDbInitContainer" }}
- name: wait-for-db
  image: {{ .Values.db.deployment.image }}
  imagePullPolicy: {{ .Values.db.deployment.imagePullPolicy }}
  command:
    - /bin/sh
    - -c
  args:
    - |
      until pg_isready -h $(POSTGRES_HOST) -p $(POSTGRES_PORT) -U $(POSTGRES_USER); do
        echo "Waiting for connection to database..."
        sleep 2
      done
  env:
    {{- include "supachart.env" (dict "name" "POSTGRES_USER" "path" .Values.db.username ) | nindent 4 }}
    - name: POSTGRES_PORT
      value: {{ .Values.db.service.port | quote }}
    - name: POSTGRES_HOST
      value: {{ include "supachart.db.fullname" . | quote }}
{{- end }}
