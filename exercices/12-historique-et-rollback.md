# Exercice 12 : Historique et retour en arrière

**Durée :** 30 min · **Niveau :** intermédiaire

## Objectif

Comprendre comment Kubernetes et ArgoCD gardent l'historique des versions, et savoir revenir en arrière proprement.

## Contexte

À chaque modification du *template* d'un Deployment, Kubernetes crée un **nouveau ReplicaSet** et réduit l'ancien à 0 pod, sans le supprimer. Ces anciens ReplicaSets sont les **révisions** (`Rev:1`, `Rev:2`… dans ArgoCD).

Avec le GitOps, il existe **deux façons** de revenir en arrière, et elles n'ont pas les mêmes conséquences.

## Travail demandé

### Partie A : observer l'historique

1. Listez les ReplicaSets du namespace `mywebapp`. Combien en compte le Deployment `mywebapp` ? Combien de pods chacun ?
2. Affichez l'historique des révisions du Deployment `mywebapp`.
3. Dans ArgoCD, retrouvez ces révisions dans l'arbre de l'application, puis dans **History and Rollback**.

### Partie B : introduire une erreur

4. Dans Git, remplacez l'image Tomcat par une version qui n'existe pas (par exemple `tomcat:9.0-nexiste-pas`) et poussez.
5. Observez : le statut du nouveau pod, le statut de l'app dans ArgoCD, et la disponibilité de http://localhost:30081.

### Partie C : revenir en arrière

6. **Méthode 1 : par Git.** Annulez le commit fautif avec `git revert` et poussez. Observez le retour à la normale.
7. Recommencez l'erreur (étape 4).
8. **Méthode 2 : par ArgoCD.** Utilisez **History and Rollback** pour revenir à la version précédente. Que devient la synchronisation automatique ? Que va-t-il se passer au prochain push ?
9. Remettez tout dans un état propre : Git correct, synchronisation automatique réactivée.

## Critères de réussite

- [ ] Vous savez associer chaque ReplicaSet à une version de l'application
- [ ] Pendant l'erreur, l'ancienne version continue de servir le trafic
- [ ] Le retour en arrière par `git revert` fonctionne
- [ ] À la fin, l'application est **Synced / Healthy** avec la synchronisation automatique active

## Questions

1. Pourquoi l'application reste-t-elle accessible pendant que le nouveau pod est en erreur ?
2. Quelle méthode de retour en arrière respecte le principe du GitOps ? Pourquoi ?
3. Pourquoi `kubectl rollout undo` est-il une mauvaise idée quand ArgoCD gère l'application avec `selfHeal` ?

## Indices

<details>
<summary>Commandes utiles</summary>

```powershell
kubectl -n mywebapp get rs
kubectl -n mywebapp rollout history deployment/mywebapp
kubectl -n mywebapp get pods -w
git log --oneline
git revert <sha-du-commit>
git push
```
</details>

<details>
<summary>Statut attendu du pod avec une image inexistante</summary>

`ErrImagePull`, puis `ImagePullBackOff`. Les détails sont dans `kubectl -n mywebapp describe pod <nom>`.
</details>

## Pour aller plus loin

- Limitez le nombre de révisions conservées avec `revisionHistoryLimit: 3` dans le Deployment.
