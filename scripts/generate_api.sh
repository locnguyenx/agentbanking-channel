#!/bin/bash
npx @openapitools/openapi-generator-cli generate -i docs/api/openapi.yaml -g dart-dio -o lib/api/generated --additional-properties=pubName=agent_api
cd lib/api/generated && flutter pub get && dart run build_runner build --delete-conflicting-outputs
