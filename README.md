# Supachart — Helm Chart for Supabase Deployment

## ⚠️ WARNING: This chart is a Work in Progress (WIP) and is not ready for production use

## Introduction

Supachart is an open-source Helm chart designed to simplify the deployment of [Supabase](https://supabase.com/) on Kubernetes clusters. It packages the core components of Supabase, including PostgreSQL, API Gateway, Auth, Realtime, Storage, and Studio into a configurable, production-ready Helm deployment.

## Installation

```bash
helm repo add supachart https://supachart.ffuchs.dev/
helm repo update
helm install my-supabase supachart/supachart
```

With custom configuration:

```bash
helm install my-supabase supachart/supachart -f my-values.yaml
```

For a full list of options, refer to [values.yaml](https://github.com/FabulousCodingFox/supachart/blob/main/src/supachart/values.yaml)
