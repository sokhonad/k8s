# Exercice 07 : Tout déployer en une commande

**Durée :** 20 min · **Niveau :** débutant

## Objectif

Regrouper tous les fichiers d'une application pour les appliquer ou les supprimer d'une seule commande.

## Contexte

Appliquer les fichiers un par un est fastidieux, et l'ordre compte. **Kustomize**, intégré à `kubectl`, lit un fichier `kustomization.yaml` qui liste les ressources de l'application.

## Travail demandé

1. Créez **`k8s/kustomization.yaml`** qui liste vos 4 fichiers : namespace, configmap, deployment, service.
2. Affichez le résultat **sans l'appliquer**, pour vérifier qu'il n'y a pas d'erreur.
3. Supprimez toute l'application en une commande.
4. Redéployez-la en une commande.

## Critères de réussite

- [ ] `kubectl kustomize k8s` affiche les 4 ressources sans erreur
- [ ] `kubectl apply -k k8s` déploie tout
- [ ] `kubectl delete -k k8s` supprime tout

## Questions

1. Dans quel ordre Kustomize applique-t-il les ressources ? L'ordre de la liste compte-t-il ?
2. Quelle est la différence entre `-f` et `-k` ?

## Indices

<details>
<summary>Format du fichier</summary>

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - namespace.yaml
  - ...
```
</details>

## Pour aller plus loin

- Ajoutez `commonLabels` (ou `labels`) au `kustomization.yaml` pour poser le label `projet: formation` sur toutes les ressources, puis vérifiez avec `kubectl -n demo get all --show-labels`.
