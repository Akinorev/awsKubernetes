#! /bin/bash

mkdir output/

kubectl get svc -o=jsonpath='{range .items[*]} {@.metadata.name}{": "}{@.spec.ports[*].port}{"\n"}{end}' >> output/output.log
