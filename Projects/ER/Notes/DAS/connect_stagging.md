# connect staging
19 Jan 24 
---
* first time need to log in 
```gcloud container clusters get-credentials er-prod --region europe-west3 --project earthranger-prod```

* enter das-api
```kubectl exec -it deploy/das-server-earthranger-api -n das-server -- bash```
