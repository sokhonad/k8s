# Exercices Kubernetes et GitOps

Parcours progressif en **12 exercices** : on part d'un cluster vide et on termine avec deux applications gérées par **ArgoCD**, dont une application Java avec base de données.

Les solutions se trouvent dans le dépôt (dossiers [k8s/](../k8s/), [apps/mywebapp/](../apps/mywebapp/) et [argocd/](../argocd/)). Essayez d'abord sans les regarder.

## Parcours

| # | Exercice | Notions | Durée |
|---|---|---|---|
| 01 | [Découvrir le cluster](01-decouvrir-le-cluster.md) | cluster, nœud, namespace, `kubectl` | 20 min |
| 02 | [Premier déploiement](02-premier-deploiement.md) | Namespace, Deployment, Service NodePort | 40 min |
| 03 | [Servir sa propre page](03-configmap-et-volumes.md) | ConfigMap, volumes, volumeMounts | 40 min |
| 04 | [Quel pod m'a répondu ?](04-identifier-le-pod.md) | config nginx, SSI, répartition de charge | 30 min |
| 05 | [Passer à l'échelle et s'auto-réparer](05-scalabilite-auto-reparation.md) | replicas, ReplicaSet, auto-réparation | 30 min |
| 06 | [Sondes de santé et ressources](06-sondes-et-ressources.md) | readinessProbe, livenessProbe, requests, limits | 40 min |
| 07 | [Tout déployer en une commande](07-kustomize.md) | Kustomize | 20 min |
| 08 | [Installer ArgoCD](08-installer-argocd.md) | ArgoCD, port-forward, Secret | 40 min |
| 09 | [Le GitOps en pratique](09-gitops.md) | Application ArgoCD, sync, selfHeal, prune | 60 min |
| 10 | [Déployer une application Java (WAR)](10-deployer-un-war.md) | initContainer, sidecar, Secret, PVC, base de données | 2 h |
| 11 | [Changer le design sans recompiler](11-design-configmapgenerator.md) | configMapGenerator, redéploiement automatique | 60 min |
| 12 | [Historique et retour en arrière](12-historique-et-rollback.md) | révisions, rollback, GitOps vs kubectl | 30 min |

## Prérequis

- Windows avec Docker Desktop et Kubernetes activé (méthode **Kubeadm**)
- `kubectl` et `git` installés
- Un compte GitHub (à partir de l'exercice 09)

## Format des exercices

Chaque énoncé contient :

- **Objectif** : ce que vous saurez faire à la fin
- **Contexte** : pourquoi c'est utile
- **Travail demandé** : les étapes à réaliser
- **Critères de réussite** : comment vérifier que c'est terminé
- **Indices** : à ouvrir seulement en cas de blocage
- **Pour aller plus loin** : défis facultatifs
