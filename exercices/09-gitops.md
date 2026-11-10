# Exercice 09 : Le GitOps en pratique

**Durée :** 60 min · **Niveau :** intermédiaire

## Objectif

Confier le déploiement de l'application à ArgoCD : à partir de maintenant, **on modifie Git, et le cluster suit**.

## Contexte

```
git push ──> GitHub ──> ArgoCD détecte le changement ──> applique dans le cluster
```

ArgoCD décrit chaque application suivie avec une ressource **`Application`** : quel dépôt, quelle branche, quel dossier, et où déployer.

## Travail demandé

### Partie A : publier le code

1. Créez un dépôt **public** sur GitHub.
2. Initialisez Git dans votre projet, faites un premier commit et poussez sur la branche `main`.

### Partie B : déclarer l'application

3. Créez **`argocd/application.yaml`** : une `Application` nommée `hello-k8s`, dans le namespace `argocd`, qui :
   - suit votre dépôt, branche `main`, dossier `k8s` ;
   - déploie dans le cluster local (`https://kubernetes.default.svc`), namespace `demo` ;
   - se synchronise **automatiquement**, avec `prune` et `selfHeal` activés.
4. Appliquez ce fichier, puis vérifiez dans l'interface que l'app est **Synced / Healthy**.

### Partie C : tester le GitOps

5. Changez le titre de la page dans Git et poussez. Mesurez le temps avant que la page change, avec puis sans le bouton **Refresh**.
6. Passez `replicas` à 4 **dans Git**. Vérifiez le résultat.
7. Lancez `kubectl -n demo scale deploy/hello-k8s --replicas=10`. Que fait ArgoCD ?
8. Ajoutez au Service une annotation pour qu'ArgoCD affiche un lien vers http://localhost:30080.

## Critères de réussite

- [ ] L'application est **Synced / Healthy** dans ArgoCD
- [ ] Une modification poussée sur GitHub arrive dans le cluster sans aucune commande `kubectl`
- [ ] Un `kubectl scale` manuel est annulé automatiquement
- [ ] Une icône ↗ ouvre l'application depuis ArgoCD

## Questions

1. Comment ArgoCD sait-il qu'un nouveau commit existe ? Est-ce GitHub qui le prévient ?
2. Quels pods ArgoCD participent à une synchronisation, et que fait chacun ?
3. Que ferait `prune: true` si vous supprimiez `service.yaml` du dépôt ?
4. Pourquoi `argocd/application.yaml` n'est-il pas dans le dossier `k8s/` ?

## Indices

<details>
<summary>Squelette de l'Application</summary>

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: hello-k8s
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/<vous>/<depot>.git
    targetRevision: main
    path: k8s
  destination:
    server: https://kubernetes.default.svc
    namespace: demo
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```
</details>

<details>
<summary>Erreur « authentication required: Repository not found »</summary>

Le dépôt est privé. Rendez-le public, ou ajoutez-le dans ArgoCD avec un token (Settings → Repositories).
</details>

<details>
<summary>Annotation du lien</summary>

```yaml
metadata:
  annotations:
    link.argocd.argoproj.io/external-link: http://localhost:30080
```
</details>

## Pour aller plus loin

- Retrouvez dans le Deployment la marque laissée par ArgoCD : `kubectl -n demo get deploy hello-k8s -o yaml` (cherchez `tracking-id` et `managedFields`).
