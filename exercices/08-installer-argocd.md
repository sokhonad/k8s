# Exercice 08 : Installer ArgoCD

**Durée :** 40 min · **Niveau :** intermédiaire

## Objectif

Installer ArgoCD dans le cluster et accéder à son interface web.

## Contexte

**ArgoCD** est un outil de **GitOps** : il lit des fichiers YAML dans un dépôt Git et les applique dans le cluster. Il tourne lui-même **dans** le cluster, sous forme de plusieurs pods.

## Travail demandé

1. Créez un namespace `argocd`.
2. Installez ArgoCD avec le manifeste officiel (version `stable`).
3. Attendez que tous les pods du namespace `argocd` soient `Running`.
4. Récupérez le mot de passe initial de l'utilisateur `admin`. Il est stocké, **encodé en base64**, dans le Secret `argocd-initial-admin-secret`.
5. Ouvrez l'accès à l'interface avec un `port-forward` vers le Service `argocd-server`, sur le port local 8080.
6. Connectez-vous sur https://localhost:8080.
7. Complétez le tableau :

| Pod | Rôle |
|---|---|
| `argocd-server` | |
| `argocd-repo-server` | |
| `argocd-application-controller` | |
| `argocd-redis` | |
| `argocd-dex-server` | |

## Critères de réussite

- [ ] Tous les pods `argocd` sont `Running`
- [ ] Vous êtes connecté à l'interface en `admin`
- [ ] Le tableau est rempli

## Questions

1. Pourquoi le Secret `argocd-initial-admin-secret` n'existe-t-il pas dans les premières minutes ?
2. Pourquoi faut-il un `port-forward` ? Le Service `argocd-server` est-il de type NodePort ?
3. Le pod `argocd-dex-server` a peut-être redémarré une fois au lancement. Lisez ses logs : pourquoi ?

## Indices

<details>
<summary>Installation</summary>

```powershell
kubectl create namespace argocd
kubectl apply -n argocd --server-side -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl -n argocd get pods -w
```

L'option `--server-side` évite une erreur liée à la taille de certaines définitions.
</details>

<details>
<summary>Décoder le mot de passe en PowerShell</summary>

```powershell
$p = kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}"
[Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($p))
```
</details>

<details>
<summary>Port-forward</summary>

```powershell
kubectl -n argocd port-forward svc/argocd-server 8080:443
```

Laissez la fenêtre ouverte. Le navigateur affichera un avertissement de certificat : c'est normal en local.
</details>

## Pour aller plus loin

- Changez le mot de passe `admin` depuis l'interface (User Info → Update Password).
