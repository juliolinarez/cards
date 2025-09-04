# Use Fly.io Tigris for Active Storage in production

## Problem
Uploads were stored on local disk (`:local`) which isn’t durable or shared across Fly Machines. We need globally available, S3‑compatible object storage.

## Solution
Configure Rails Active Storage to use **Fly.io Tigris** (S3 API) in production and provision a bucket. Files remain private and are served through short‑lived signed URLs.

## What changed
- Added dependency: `aws-sdk-s3`.
- Added `:tigris` service in `config/storage.yml` with:
  - `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_REGION=auto`, `AWS_ENDPOINT_URL_S3=https://fly.storage.tigris.dev`, `BUCKET_NAME`.
- Switched `config/environments/production.rb` to `config.active_storage.service = :tigris`.
- Added Active Storage tables migration.

## Infra
- Bucket: `proxyfield-assets` (Tigris)
- App: `proxyfield-app` (org `cards`)
- Secrets set on Fly: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_REGION`, `AWS_ENDPOINT_URL_S3`, `BUCKET_NAME`.

## Verification
```bash
# Show service class on a running machine
fly ssh console -a proxyfield-app -C 'bash -lc "cd /rails && RAILS_ENV=production ./bin/rails runner \"puts ActiveStorage::Blob.service.class.name\""'

# Upload a tiny blob (prints key on success)
fly ssh console -a proxyfield-app -C 'bash -lc "cd /rails && RAILS_ENV=production ./bin/rails runner \"require \"stringio\"; io=StringIO.new(\"hello tigris\"); b=ActiveStorage::Blob.create_and_upload!(io: io, filename: \"health.txt\", content_type: \"text/plain\"); puts b.key\""'
```

## Behavior
- Files are private by default and accessed via signed URLs (recommended).
- To make files public: `fly storage update proxyfield-assets --public` and add `public: true` under `:tigris` in `config/storage.yml`.

## Rollback
1) Set `config.active_storage.service = :local` in production.
2) Redeploy. Optionally remove Tigris secrets and destroy the bucket.

## References
- [Fly.io Tigris docs](https://fly.io/docs/reference/tigris/)
